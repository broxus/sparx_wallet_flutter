import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class LedgerBleScanner {
  LedgerBleScanner(this._permissionsService);

  static final _logger = Logger('LedgerBleScanner');

  final AppPermissionsService _permissionsService;

  final _scanResult = BehaviorSubject<List<ScanResult>>.seeded([]);
  final _withServices = ledgerDevices
      .map((device) => Guid.fromString(device.bluetoothSpec.serviceUuid))
      .toList();

  Future<bool> get isSupported => FlutterBluePlus.isSupported;

  Stream<bool> get isScanning => FlutterBluePlus.isScanning;

  bool get isBluetoothEnabled =>
      FlutterBluePlus.adapterStateNow == BluetoothAdapterState.on;

  Stream<List<ScanResult>> get scanResult => _scanResult.stream;

  /// Start scan for BLE devices that match the Ledger devices' service UUID
  ///
  /// **Note:** check if permissions are granted and bluetooth is enabled
  /// before calling this method.
  Future<void> startScan() async {
    if (!await FlutterBluePlus.isSupported) return;
    if (FlutterBluePlus.isScanningNow) return;

    if (!await checkPermissions()) return;

    if (FlutterBluePlus.adapterStateNow == BluetoothAdapterState.turningOn) {
      await FlutterBluePlus.adapterState.firstWhere(
        (state) => state == BluetoothAdapterState.on,
      );
    }
    if (!isBluetoothEnabled) return;

    final subscription = FlutterBluePlus.onScanResults.listen(
      _onScanResult,
      onError: (Object e, StackTrace st) {
        _logger.severe('BLE scan error: $e', e, st);
      },
    );
    FlutterBluePlus.cancelWhenScanComplete(subscription);

    _scanResult.add([]);

    return FlutterBluePlus.startScan(
      withServices: _withServices,
    );
  }

  Future<void> stopScan() => FlutterBluePlus.stopScan();

  Future<bool> checkPermissions() async {
    final isGranted = await _permissionsService.requestPermissions([
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ]);

    return isGranted;
  }

  void _onScanResult(List<ScanResult> results) => _scanResult.add(results);
}

extension ScanResultX on ScanResult {
  LedgerDeviceModel? getLedgerDeviceModel() {
    return ledgerDevices.firstWhereOrNull(
      (d) => advertisementData.serviceUuids.contains(
        Guid.fromString(d.bluetoothSpec.serviceUuid),
      ),
    );
  }
}
