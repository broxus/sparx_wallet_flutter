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
    _transport = BleTransport(device: device, deviceModel: deviceModel);
  }

  static final _logger = Logger('LedgerAppInterface');

  final BluetoothDevice device;
  late final LedgerDeviceModel deviceModel;

  final _mutex = Mutex();
  late final BleTransport _transport;

  Future<void> dispose() => _mutex.protect(() async {
        await _transport.dispose();

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
      final writer = APDUWriter(ins: ApduIns.openApp)..writeData(data);

      final response = await _transport.exchange(writer.toBytes());

      return response.isOk;
    } catch (e, st) {
      _logger.severe('Failed to open app: $e', e, st);
      throw LedgerException('Failed to open app: $e');
    } finally {
      _mutex.release();
    }
  }

  Future<String> getAppName() async {
    await _mutex.acquire();

    try {
      final writer = APDUWriter(cla: 0xb0, ins: ApduIns.getApp);
      final response = await _transport.exchange(writer.toBytes());

      if (!response.isOk) {
        throw LedgerException(
          'Failed to get app: SW=${response.sw.toRadixString(16)}',
        );
      }

      final reader = ByteDataReader()..add(response.data);
      final tag = reader.readUint8();

      if (tag != 0x01) {
        throw LedgerException(
          'Unexpected tag in app response: $tag',
        );
      }

      final length = reader.readUint8();
      final appName = ascii.decode(reader.read(length));

      return appName;
    } catch (e, st) {
      _logger.severe('Failed to get app name: $e', e, st);
      throw LedgerException('Failed to get app name: $e');
    } finally {
      _mutex.release();
    }
  }

  Future<Uint8List> getConfiguration() async {
    await _mutex.acquire();

    try {
      final writer = APDUWriter(ins: ApduIns.getConf);
      final response = await _transport.exchange(writer.toBytes());

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
      final writer = APDUWriter(ins: ApduIns.getPk)..writeByteData(data);

      final response = await _transport.exchange(writer.toBytes());

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
      final writer = APDUWriter(ins: ApduIns.getAddr, p1: 0x01)
        ..writeByteData(data);

      final response = await _transport.exchange(writer.toBytes());

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
      final data = (ByteDataWriter()
            ..writeUint32(accountId)
            ..write(message))
          .toBytes();
      final writer = APDUWriter(ins: ApduIns.sign, p1: 0x01)..writeData(data);

      final response = await _transport.exchange(writer.toBytes());

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
          throw const LedgerException('Invalid address format');
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
      LedgerResponse? response;

      for (var i = 0; i < chunks.length; i++) {
        final chunk = chunks[i];
        final p2 = switch (chunks.length) {
          1 => 0x00, // single chunk
          _ when i == 0 => 0x02, // first chunk
          _ when i == chunks.length - 1 => 0x01, // last chunk
          _ => 0x03, // intermediate chunk
        };
        final writer = APDUWriter(
          ins: ApduIns.signTransaction,
          p1: 0x01,
          p2: p2,
        )..writeData(chunk);

        response = await _transport.exchange(writer.toBytes());

        if (!response.isOk) break;
      }

      if (response == null) {
        throw const LedgerException('No response received from Ledger');
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

  Future<void> _waitForApp(CancelableCompleter<bool> completer) async {
    while (!completer.isCanceled) {
      await device.tryConnect(const Duration(seconds: 5));

      if (!device.isConnected) {
        completer.completeError(
          const LedgerException('Device connection lost'),
        );
        return;
      }

      try {
        final appName = await getAppName();
        if (_checkAppName(appName)) break;
      } catch (_) {}

      await Future<void>.delayed(const Duration(seconds: 1));
    }

    if (!completer.isCompleted && !completer.isCanceled) {
      completer.complete(true);
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

  bool _checkAppName(String appName) {
    final lower = appName.toLowerCase();
    return lower.startsWith('ever') ||
        lower.startsWith('venom') ||
        lower.startsWith('hamster') ||
        lower.startsWith('tycho');
  }
}
