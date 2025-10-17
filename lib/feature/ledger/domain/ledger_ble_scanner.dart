import 'package:app/feature/ledger/ledger.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class LedgerBleScanner {
  LedgerBleScanner(this._ledgerService);

  static final _logger = Logger('LedgerBleScanner');

  final LedgerService _ledgerService;

  final _scanResult = BehaviorSubject<List<ScanResult>>.seeded([]);
  final _withServices = ledgerDevices
      .map((device) => Guid.fromString(device.bluetoothSpec.serviceUuid))
      .toList();

  Stream<bool> get isScanning => FlutterBluePlus.isScanning;

  Stream<List<ScanResult>> get scanResult => _scanResult.stream;

  /// Start scan for BLE devices that match the Ledger devices' service UUID
  ///
  /// **Note:** check if permissions are granted and bluetooth is enabled
  /// before calling this method.
  Future<void> startScan() async {
    if (!await FlutterBluePlus.isSupported) return;
    if (FlutterBluePlus.isScanningNow) return;

    if (!await _ledgerService.checkPermissions()) return;

    await FlutterBluePlus.adapterState.firstWhere(
      (state) => state != BluetoothAdapterState.unknown,
    );

    if (FlutterBluePlus.adapterStateNow == BluetoothAdapterState.turningOn) {
      await FlutterBluePlus.adapterState.firstWhere(
        (state) => state == BluetoothAdapterState.on,
      );
    }

    if (FlutterBluePlus.adapterStateNow != BluetoothAdapterState.on) return;

    final subscription = FlutterBluePlus.onScanResults.listen(
      _onScanResult,
      onError: (Object e, StackTrace st) {
        _logger.severe('BLE scan error: $e', e, st);
      },
    );
    FlutterBluePlus.cancelWhenScanComplete(subscription);

    _scanResult.add([]);

    return FlutterBluePlus.startScan(withServices: _withServices);
  }

  Future<void> stopScan() => FlutterBluePlus.stopScan();

  void _onScanResult(List<ScanResult> results) => _scanResult.add(results);
}
