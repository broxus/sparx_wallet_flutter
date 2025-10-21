import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class ImportLedgerModel extends ElementaryModel with BleAvailabilityModelMixin {
  ImportLedgerModel(
    ErrorHandler errorHandler,
    this._ledgerService,
    this._ledgerBleScanner,
    this._currentKeyService,
    this._nekotonRepository,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final LedgerService _ledgerService;
  final LedgerBleScanner _ledgerBleScanner;
  final CurrentKeyService _currentKeyService;
  final NekotonRepository _nekotonRepository;
  final BleAvailabilityModelDelegate _delegate;

  Stream<List<ScanResult>> get scanResult => _ledgerBleScanner.scanResult;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  @override
  void dispose() {
    super.dispose();
    _ledgerService.closeLedgerConnection();
  }

  Future<void> startScan() => _ledgerBleScanner.startScan();

  Future<void> stopScan() => _ledgerBleScanner.stopScan();

  Future<LedgerAppInterface> getAppInterface(ScanResult item) async {
    final app = await _ledgerService.getAppInterface(
      device: item.device,
      deviceModelId: item.getLedgerDeviceModel()!.id,
    );
    await _ledgerService.initLedgerConnection(app);

    return app;
  }

  Future<PublicKey> addConnectedLedger({
    required BluetoothDevice device,
    required DeviceModelId deviceModelId,
    String? name,
  }) async {
    final masterKey = await _nekotonRepository.addLedgerKey(
      accountId: 0,
      name: name,
      workchainId: 0,
    );

    await _ledgerService.connect(
      masterKey: masterKey,
      device: device,
      deviceModelId: deviceModelId,
    );

    if (_currentKeyService.currentKey == null) {
      _currentKeyService.changeCurrentKey(masterKey);
    }

    return masterKey;
  }
}
