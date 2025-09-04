import 'package:app/feature/ledger/ledger.dart';
import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart'
    show AnyhowException, LedgerException;

extension ScanResultX on ScanResult {
  LedgerDeviceModel? getLedgerDeviceModel() {
    return ledgerDevices.firstWhereOrNull(
      (d) => advertisementData.serviceUuids.contains(
        Guid.fromString(d.bluetoothSpec.serviceUuid),
      ),
    );
  }
}

extension BluetoothDeviceX on BluetoothDevice {
  static final _logger = Logger('BluetoothDevice');

  Future<void> tryConnect([
    Duration timeout = const Duration(seconds: 10),
  ]) async {
    if (isConnected) return;

    try {
      if (FlutterBluePlus.adapterStateNow == BluetoothAdapterState.turningOn) {
        await FlutterBluePlus.adapterState.firstWhere(
          (state) => state == BluetoothAdapterState.on,
        );
      }

      await connect(timeout: timeout);
      await discoverServices();
    } catch (e) {
      _logger.severe('Failed to connect to Ledger device', e);
      throw LedgerException('Failed to connect to Ledger device: $e');
    }
  }

  CancelableOperation<bool> waitForConnection() {
    final completer = CancelableCompleter<bool>();
    _waitForConnection(completer);
    return completer.operation;
  }

  // wait for connection to be established
  Future<void> _waitForConnection(CancelableCompleter<bool> completer) async {
    while (!isConnected && !completer.isCanceled) {
      try {
        await tryConnect(const Duration(seconds: 5));
      } catch (_) {
        await Future<void>.delayed(const Duration(seconds: 1));
      }
    }

    if (!completer.isCompleted && !completer.isCanceled) {
      completer.complete(true);
    }
  }
}

extension AnyhowExceptionX on AnyhowException {
  bool get isCancelled {
    return message == 'Operation cancelled';
  }
}
