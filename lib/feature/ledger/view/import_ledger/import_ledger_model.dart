import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class ImportLedgerModel extends ElementaryModel with BleAvailabilityModelMixin {
  ImportLedgerModel(
    ErrorHandler errorHandler,
    this._ledgerService,
    this._ledgerBleScanner,
    this._currentKeyService,
    this._nekotonRepository,
    this._connectionsStorageService,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final LedgerService _ledgerService;
  final LedgerBleScanner _ledgerBleScanner;
  final CurrentKeyService _currentKeyService;
  final NekotonRepository _nekotonRepository;
  final ConnectionsStorageService _connectionsStorageService;
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
    final currentWorkchainId = _connectionsStorageService.currentWorkchainId;

    if (currentWorkchainId == null) {
      throw Exception(LocaleKeys.ledgerImportError.tr());
    }

    final masterKey = await _nekotonRepository.addLedgerKey(
      accountId: 0,
      name: name,
      workchainId: currentWorkchainId,
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
