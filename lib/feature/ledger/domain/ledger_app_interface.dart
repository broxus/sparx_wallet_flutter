import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:app/feature/ledger/ledger.dart';
import 'package:async/async.dart';
import 'package:buffer/buffer.dart';
import 'package:convert/convert.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logging/logging.dart';
import 'package:mutex/mutex.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _cla = 0xe0;
const _insOpenApp = 0xd8;
const _insGetConf = 0x01;
const _insGetPk = 0x02;
const _insSign = 0x03;
const _insGetAddr = 0x04;
const _insSignTransaction = 0x05;
const _flagWithWalletId = 1 << 0;
const _flagWithWorkchainId = 1 << 1;
const _flagWithAddress = 1 << 2;
const _flagWithChainId = 1 << 3;
const _maxChunkSize = 255;

class LedgerAppInterface {
  LedgerAppInterface({
    required this.device,
    required DeviceModelId deviceModelId,
  })  : assert(
          device.isConnected,
          'Ledger device is not connected',
        ),
        assert(
          device.servicesList.isNotEmpty,
          'BluetoothDevice.discoverServices() has not been called',
        ) {
    deviceModel = ledgerDevices.firstWhere((d) => d.id == deviceModelId);
    _bleService = device.servicesList.firstWhere(
      (e) => e.uuid.toString() == deviceModel.bluetoothSpec.serviceUuid,
    );
    _writeCharacteristic = _bleService.characteristics.firstWhere(
      (c) => c.uuid.toString() == deviceModel.bluetoothSpec.writeUuid,
    );
    _notifyCharacteristic = _bleService.characteristics.firstWhere(
      (c) => c.uuid.toString() == deviceModel.bluetoothSpec.notifyUuid,
    );

    _mtu = device.mtuNow;
    _mtuSubscription = device.mtu.listen((mtu) async {
      if (_mtu == mtu) return;

      await _mutex.acquire();
      try {
        _mtu = mtu;
        _logger.info('MTU updated: $_mtu');
      } finally {
        _mutex.release();
      }
    });
  }

  static final _logger = Logger('LedgerAppInterface');

  final BluetoothDevice device;
  late final LedgerDeviceModel deviceModel;

  final _mutex = Mutex();
  final _packer = BlePacker();
  late final BluetoothService _bleService;
  late final BluetoothCharacteristic _writeCharacteristic;
  late final BluetoothCharacteristic _notifyCharacteristic;
  late final StreamSubscription<int> _mtuSubscription;
  late int _mtu;

  int get mtu => _mtu;

  Future<void> dispose() => _mutex.protect(() async {
        await _mtuSubscription.cancel();

        if (device.isConnected) {
          await device.disconnect();
        }
      });

  CancelableOperation<bool> waitForApp() {
    final completer = CancelableCompleter<bool>();
    _waitForApp(completer);
    return completer.operation;
  }

  Future<bool> openApp(String appName) async {
    await _mutex.acquire();

    try {
      final data = utf8.encode(appName);
      final writer = _getAPDUWriter(ins: _insOpenApp)
        ..writeUint8(data.lengthInBytes) // Data length
        ..write(data.buffer.asUint8List()); // Data

      final response = await _write(writer.toBytes());

      return response.isOk;
    } catch (e, st) {
      _logger.severe('Failed to open app: $e', e, st);
      throw LedgerException('Failed to open app: $e');
    } finally {
      _mutex.release();
    }
  }

  Future<Uint8List> getConfiguration() async {
    await _mutex.acquire();

    try {
      final writer = _getAPDUWriter(ins: _insGetConf);
      final response = await _write(writer.toBytes());

      if (!response.isOk) {
        throw LedgerException(
          'Failed to get configuration: SW=${response.sw.toRadixString(16)}',
        );
      }

      // Only INS_GET_CONFIG returns data without offset
      return response.data;
    } catch (e, st) {
      _logger.severe('Failed to get configuration: $e', e, st);
      throw LedgerException('Failed to get configuration: $e');
    } finally {
      _mutex.release();
    }
  }

  Future<Uint8List> getPublicKey(int accountId) async {
    await _mutex.acquire();

    try {
      final data = ByteData(4)..setUint32(0, accountId);
      final writer = _getAPDUWriter(ins: _insGetPk)
        ..writeUint8(data.lengthInBytes) // Data length
        ..write(data.buffer.asUint8List()); // Data

      final response = await _write(writer.toBytes());

      if (!response.isOk) {
        throw LedgerException(
          'Failed to get public key: SW=${response.sw.toRadixString(16)}',
        );
      }

      return response.dataWithOffset;
    } catch (e, st) {
      _logger.severe('Failed to get public key: $e', e, st);
      throw LedgerException('Failed to get public key: $e');
    } finally {
      _mutex.release();
    }
  }

  Future<Uint8List> getAddress({
    required int accountId,
    required int wallet,
  }) async {
    await _mutex.acquire();

    try {
      final data = ByteData(5)
        ..setUint32(0, accountId)
        ..setUint8(4, wallet);
      final writer = _getAPDUWriter(ins: _insGetAddr, p1: 0x01)
        ..writeUint8(data.lengthInBytes) // Data length
        ..write(data.buffer.asUint8List()); // Data

      final response = await _write(writer.toBytes());

      if (!response.isOk) {
        throw LedgerException(
          'Failed to get wallet address: SW=${response.sw.toRadixString(16)}',
        );
      }

      return response.dataWithOffset;
    } catch (e, st) {
      _logger.severe('Failed to get wallet address: $e', e, st);
      throw LedgerException('Failed to get wallet address: $e');
    } finally {
      _mutex.release();
    }
  }

  Future<Uint8List> sign({
    required int accountId,
    required List<int> message,
    int? signatureId, // not used in newer versions
  }) async {
    await _mutex.acquire();

    try {
      final writer = _getAPDUWriter(ins: _insSign, p1: 0x01)
        ..writeUint8(4 + message.length) // Data length
        ..writeUint32(accountId)
        ..write(message);

      final response = await _write(writer.toBytes());

      if (!response.isOk) {
        throw LedgerException(
          'Failed to sign message: SW=${response.sw.toRadixString(16)}',
        );
      }

      return response.dataWithOffset;
    } catch (e, st) {
      _logger.severe('Failed to sign message: $e', e, st);
      throw LedgerException('Failed to sign message: $e');
    } finally {
      _mutex.release();
    }
  }

  Future<Uint8List> signTransaction({
    required int accountId,
    required int wallet,
    required List<int> message,
    required LedgerSignatureContext context,
    int? signatureId,
    int? originalWallet,
  }) async {
    await _mutex.acquire();

    try {
      originalWallet ??= wallet;

      var metadata = 0;
      final optional = ByteDataWriter();
      final writer = ByteDataWriter()
        ..writeUint32(accountId)
        ..writeUint8(originalWallet)
        ..writeUint8(context.decimals);

      final ticker = _getTicker(context.asset);
      writer
        ..writeUint8(ticker.length)
        ..write(ticker);

      if (wallet != originalWallet) {
        metadata |= _flagWithWalletId;
        optional.writeUint8(wallet);
      }

      if (context.workchainId != null) {
        metadata |= _flagWithWorkchainId;
        optional.writeUint8(context.workchainId!);
      }

      if (context.address != null) {
        if (context.address!.length != 64) {
          throw LedgerException('Invalid address format');
        }

        metadata |= _flagWithAddress;
        optional.write(hex.decode(context.address!));
      }

      if (signatureId != null) {
        metadata |= _flagWithChainId;
        optional.writeInt32(signatureId);
      }

      writer
        ..writeUint8(metadata)
        ..write(optional.toBytes())
        ..write(message.sublist(4));

      final data = writer.toBytes();
      final chunks = _split(data);
      LedgerAppResponse? response;

      for (var i = 0; i < chunks.length; i++) {
        final chunk = chunks[i];
        final p2 = switch (chunks.length) {
          1 => 0x00, // single chunk
          _ when i == 0 => 0x02, // first chunk
          _ when i == chunks.length - 1 => 0x01, // last chunk
          _ => 0x03, // intermediate chunk
        };
        final writer =
            _getAPDUWriter(ins: _insSignTransaction, p1: 0x01, p2: p2)
              ..writeUint8(chunk.length) // Data length
              ..write(chunk); // Data

        response = await _write(writer.toBytes());

        if (!response.isOk) break;
      }

      if (response == null) {
        throw LedgerException('No response received from Ledger');
      }

      if (!response.isOk) {
        throw LedgerException(
          'Failed to sign transaction: SW=${response.sw.toRadixString(16)}',
        );
      }

      return response.dataWithOffset;
    } catch (e, st) {
      _logger.severe('Failed to sign transaction: $e', e, st);
      throw LedgerException('Failed to sign transaction: $e');
    } finally {
      _mutex.release();
    }
  }

  // TODO(komarov): implement using DMK commands
  Future<void> _waitForApp(CancelableCompleter<bool> completer) async {
    Uint8List? data;

    while (data == null && !completer.isCanceled) {
      await device.tryConnect();

      if (!device.isConnected) {
        completer.completeError(LedgerException('Device connection lost'));
        return;
      }

      try {
        data = await getPublicKey(0);
      } catch (_) {
        await Future<void>.delayed(const Duration(seconds: 1));
      }
    }

    if (!completer.isCompleted && !completer.isCanceled) {
      completer.complete(true);
    }
  }

  Future<LedgerAppResponse> _write(List<int> value) async {
    StreamSubscription<List<int>>? subscription;
    LedgerDataReader? reader;

    try {
      final completer = Completer<LedgerAppResponse>();
      final packets = _packer.pack(Uint8List.fromList(value), mtu);

      subscription = _notifyCharacteristic.onValueReceived.listen(
        (value) {
          try {
            if (reader == null) {
              reader = LedgerDataReader.fromBytes(value);
            } else {
              reader!.add(value);
            }

            if (reader!.isCompleted) {
              subscription?.cancel();
              completer.complete(reader!);
            }
          } catch (e, st) {
            _logger.severe('Error processing received value: $e', e, st);
            subscription?.cancel();
            completer.completeError(
              LedgerException('Error processing received value: $e'),
              st,
            );
          }
        },
        onError: (Object e, StackTrace st) {
          _logger.severe('Error in subscription: $e', e, st);
          subscription?.cancel();
          completer.completeError(
            LedgerException('Error in subscription: $e'),
            st,
          );
        },
      );

      device.cancelWhenDisconnected(subscription);

      if (!_notifyCharacteristic.isNotifying) {
        await _notifyCharacteristic.setNotifyValue(true);
      }

      for (final packet in packets) {
        await _writeCharacteristic.write(packet);
      }

      return completer.future;
    } catch (e, st) {
      _logger.severe('Failed to write data: $e', e, st);
      await subscription?.cancel();
      throw LedgerException('Failed to write data: $e');
    }
  }

  Uint8List _getTicker(String asset) {
    var value = asset;

    if (value.contains('-LP-')) {
      value = 'LP';
    } else if (value.length > 8) {
      value = '${value.substring(0, 6)}..';
    }

    return utf8.encode(value);
  }

  List<Uint8List> _split(Uint8List data) {
    final chunks = <Uint8List>[];

    for (var i = 0; i < data.length; i += _maxChunkSize) {
      chunks.add(
        data.sublist(i, min(data.length, i + _maxChunkSize)),
      );
    }

    return chunks;
  }

  ByteDataWriter _getAPDUWriter({
    required int ins,
    int p1 = 0x00,
    int p2 = 0x00,
  }) {
    return ByteDataWriter()
      ..writeUint8(_cla) // CLA
      ..writeUint8(ins) // INS
      ..writeUint8(p1) // P1
      ..writeUint8(p2); // P2
  }
}
