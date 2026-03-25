import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:app/feature/ledger/ledger.dart';
import 'package:async/async.dart';
import 'package:buffer/buffer.dart';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logging/logging.dart';
import 'package:mutex/mutex.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _flagWithWalletId = 1 << 0;
const _flagWithWorkchainId = 1 << 1;
const _flagWithAddress = 1 << 2;
const _signModeEmpty = 0;
const _signModeSignatureId = 1;
const _signModeSignatureDomain = 2;
const _signModeShift = 3;
const _maxChunkSize = 255;

class LedgerAppInterface {
  LedgerAppInterface({
    required this.device,
    required DeviceModelId deviceModelId,
  }) : assert(device.isConnected, 'Ledger device is not connected'),
       assert(
         device.servicesList.isNotEmpty,
         'BluetoothDevice.discoverServices() has not been called',
       ) {
    deviceModel = _resolveDeviceModel(deviceModelId);
    _transport = BleTransport(device: device, deviceModel: deviceModel);
  }

  @visibleForTesting
  LedgerAppInterface.test({
    required this.device,
    required DeviceModelId deviceModelId,
    required BleTransport transport,
  }) : assert(device.isConnected, 'Ledger device is not connected'),
       assert(
         device.servicesList.isNotEmpty,
         'BluetoothDevice.discoverServices() has not been called',
       ) {
    deviceModel = _resolveDeviceModel(deviceModelId);
    _transport = transport;
  }

  static final _logger = Logger('LedgerAppInterface');

  static LedgerDeviceModel _resolveDeviceModel(DeviceModelId deviceModelId) =>
      ledgerDevices.firstWhere((device) => device.id == deviceModelId);

  final BluetoothDevice device;
  late final LedgerDeviceModel deviceModel;

  final _mutex = Mutex();
  late final BleTransport _transport;

  CancelableOperation<LedgerResponse>? _currentOperation;

  /// Holds the most recent [LedgerException] produced by an operation on this
  /// interface.
  ///
  /// This field is reset to `null` at the start of each high-level operation
  /// (for example, [openApp] and other methods that acquire [_mutex]) and is
  /// set when an operation fails with a [LedgerException] or when a failure is
  /// wrapped into one.
  ///
  /// All writes to this field occur inside sections protected by [_mutex] in
  /// order to serialize operations on the underlying transport. Reads via the
  /// public [lastError] getter are not mutex-protected and should therefore be
  /// treated as a best-effort diagnostic snapshot that may be stale by the
  /// time it is observed.
  LedgerException? _lastError;

  /// Returns the last recorded [LedgerException] produced by an operation on
  /// this interface, or `null` if no error has been recorded since the most
  /// recent reset.
  ///
  /// The value is reset to `null` at the beginning of each operation that
  /// acquires [_mutex] (such as [openApp]) and is updated when that operation
  /// fails. Because operations are serialized using [_mutex], this getter is
  /// suitable for coarse-grained diagnostics (for example, exposing the last
  /// failure to UI or logging), but callers must not rely on it for
  /// synchronization or precise control flow: by the time it is read, a
  /// subsequent operation may already have completed and updated the value.
  LedgerException? get lastError => _lastError;

  Future<void> dispose() => _mutex.protect(() async {
    await cancelCurrentOperation();
    await _transport.dispose();

    if (device.isConnected) {
      await device.disconnect();
    }
  });

  Future<void> cancelCurrentOperation() async {
    await _currentOperation?.cancel();
    _currentOperation = null;
  }

  CancelableOperation<bool> waitForApp() {
    final completer = CancelableCompleter<bool>();
    _waitForApp(completer);
    return completer.operation;
  }

  Future<bool> openApp(String appName) => _runGuarded<bool>(
    errorMessage: 'Failed to open app',
    action: () async {
      final data = utf8.encode(appName);
      final writer = APDUWriter(ins: ApduIns.openApp)..writeData(data);

      final response = await _exchange(writer);

      return response?.isOk ?? false;
    },
  );

  Future<bool> closeApp() => _runGuarded<bool>(
    errorMessage: 'Failed to close app',
    action: () async {
      final writer = APDUWriter(cla: 0xb0, ins: ApduIns.closeApp);
      final response = await _exchange(writer);

      return response?.isOk ?? false;
    },
  );

  Future<String> getAppName() => _runGuarded<String>(
    errorMessage: 'Failed to get app name',
    action: () async {
      final writer = APDUWriter(cla: 0xb0, ins: ApduIns.getApp);
      final response = await _exchange(writer);

      if (response == null || response.isCanceled) {
        throw const LedgerOperationCancelledException();
      }

      if (!response.isOk) {
        throw LedgerException(
          'Failed to get app: SW=${response.sw.toRadixString(16)}',
        );
      }

      final reader = ByteDataReader()..add(response.data);
      final tag = reader.readUint8();

      if (tag != 0x01) {
        throw LedgerException('Unexpected tag in app response: $tag');
      }

      final length = reader.readUint8();
      final appName = ascii.decode(reader.read(length));

      return appName;
    },
  );

  Future<Uint8List> getConfiguration() => _runGuarded<Uint8List>(
    errorMessage: 'Failed to get configuration',
    action: () async {
      final writer = APDUWriter(ins: ApduIns.getConf);
      final response = await _exchange(writer);

      if (response == null || response.isCanceled) {
        throw const LedgerOperationCancelledException();
      }

      if (!response.isOk) {
        throw LedgerException(
          'Failed to get configuration: SW=${response.sw.toRadixString(16)}',
        );
      }

      return response.data;
    },
  );

  Future<Uint8List> getPublicKey(int accountId) => _runGuarded<Uint8List>(
    errorMessage: 'Failed to get public key',
    action: () async {
      final data = ByteData(4)..setUint32(0, accountId);
      final writer = APDUWriter(ins: ApduIns.getPk)..writeByteData(data);

      final response = await _exchange(writer);

      if (response == null || response.isCanceled) {
        throw const LedgerOperationCancelledException();
      }

      if (!response.isOk) {
        throw LedgerException(
          'Failed to get public key: SW=${response.sw.toRadixString(16)}',
        );
      }

      return response.dataWithOffset;
    },
  );

  Future<Uint8List> getAddress({
    required int accountId,
    required int wallet,
  }) => _runGuarded<Uint8List>(
    errorMessage: 'Failed to get wallet address',
    action: () async {
      final data = ByteData(5)
        ..setUint32(0, accountId)
        ..setUint8(4, wallet);
      final writer = APDUWriter(ins: ApduIns.getAddr, p1: 0x01)
        ..writeByteData(data);

      final response = await _exchange(writer);

      if (response == null || response.isCanceled) {
        throw const LedgerOperationCancelledException();
      }

      if (!response.isOk) {
        throw LedgerException(
          'Failed to get wallet address: SW=${response.sw.toRadixString(16)}',
        );
      }

      return response.dataWithOffset;
    },
  );

  Future<Uint8List> sign({
    required int accountId,
    required List<int> message,
    int? signatureId, // not used in newer versions
  }) => _runGuarded<Uint8List>(
    errorMessage: 'Failed to sign message',
    action: () async {
      final data =
          (ByteDataWriter()
                ..writeUint32(accountId)
                ..write(message))
              .toBytes();
      final writer = APDUWriter(ins: ApduIns.sign, p1: 0x01)..writeData(data);

      final response = await _exchange(writer);

      if (response == null || response.isCanceled) {
        throw const LedgerOperationCancelledException();
      }

      if (!response.isOk) {
        throw LedgerException(
          'Failed to sign message: SW=${response.sw.toRadixString(16)}',
        );
      }

      return response.dataWithOffset;
    },
  );

  Future<Uint8List> signTransaction({
    required int accountId,
    required int wallet,
    required List<int> message,
    required LedgerSignatureContext context,
    required SignatureContext signatureContext,
    int? originalWallet,
  }) => _runGuarded<Uint8List>(
    errorMessage: 'Failed to sign transaction',
    action: () async {
      final resolvedOriginalWallet = originalWallet ?? wallet;
      final data = buildSignTransactionPayload(
        accountId: accountId,
        wallet: wallet,
        originalWallet: resolvedOriginalWallet,
        message: message,
        context: context,
        signatureContext: signatureContext,
      );
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

        response = await _exchange(writer);

        if (response == null || !response.isOk) break;
      }

      if (response == null || response.isCanceled) {
        throw const LedgerOperationCancelledException();
      }

      if (!response.isOk) {
        throw LedgerException(
          'Failed to sign transaction: SW=${response.sw.toRadixString(16)}',
        );
      }

      return response.dataWithOffset;
    },
  );

  @visibleForTesting
  static Uint8List buildSignTransactionPayload({
    required int accountId,
    required int wallet,
    required int originalWallet,
    required List<int> message,
    required LedgerSignatureContext context,
    required SignatureContext signatureContext,
  }) {
    var metadata = 0;
    final optional = ByteDataWriter();
    final writer = ByteDataWriter()
      ..writeUint32(accountId)
      ..writeUint8(originalWallet)
      ..writeUint8(context.decimals);

    final ticker = _formatTicker(context.asset);
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

    final globalId = signatureContext.globalId;

    final mode = switch (signatureContext.signatureType) {
      SignatureType.signatureId =>
        globalId != null
            ? _signModeSignatureId
            : throw const LedgerException(
                'Invalid SignatureContext: '
                'signatureId requires non-null globalId',
              ),
      SignatureType.signatureDomain =>
        globalId != null
            ? _signModeSignatureDomain
            : throw const LedgerException(
                'Invalid SignatureContext: '
                'signatureDomain requires non-null globalId',
              ),
      _ => _signModeEmpty,
    };

    metadata |= mode << _signModeShift;

    if (mode == _signModeSignatureId && globalId != null) {
      optional.writeInt32(globalId, Endian.big);
    } else if (mode == _signModeSignatureDomain && globalId != null) {
      optional.writeInt32(globalId, Endian.little);
    }

    writer
      ..writeUint8(metadata)
      ..write(optional.toBytes())
      ..write(message.sublist(4));

    return writer.toBytes();
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

  static Uint8List _formatTicker(String asset) {
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
      chunks.add(data.sublist(i, min(data.length, i + _maxChunkSize)));
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

  Future<T> _runGuarded<T>({
    required String errorMessage,
    required Future<T> Function() action,
  }) async {
    await _mutex.acquire();
    _lastError = null;

    try {
      return await action();
    } on LedgerException catch (error) {
      _lastError = error;
      rethrow;
    } catch (error, stackTrace) {
      _logger.severe('$errorMessage: $error', error, stackTrace);
      final wrappedError = LedgerException('$errorMessage: $error');
      _lastError = wrappedError;
      throw wrappedError;
    } finally {
      _currentOperation = null;
      _mutex.release();
    }
  }

  Future<LedgerResponse?> _exchange(APDUWriter writer) async {
    final operation = await _transport.exchange(writer.toBytes());
    _currentOperation = operation;

    return operation.valueOrCancellation();
  }
}
