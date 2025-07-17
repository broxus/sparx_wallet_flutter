import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class ConnectLedgerModel extends LedgerBaseModel {
  ConnectLedgerModel(
    ErrorHandler errorHandler,
    MessengerService messengerService,
    AppPermissionsService permissionsService,
    this._ledgerService,
    this._ledgerBleScanner,
    this._currentKeyService,
    this._nekotonRepository,
  ) : super(
          errorHandler: errorHandler,
          ledgerService: _ledgerService,
          permissionsService: permissionsService,
          messengerService: messengerService,
        );

  final LedgerService _ledgerService;
  final LedgerBleScanner _ledgerBleScanner;
  final CurrentKeyService _currentKeyService;
  final NekotonRepository _nekotonRepository;

  Stream<List<ScanResult>> get scanResult => _ledgerBleScanner.scanResult;

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

  Future<void> addConnectedLedger({
    required BluetoothDevice device,
    required DeviceModelId deviceModelId,
  }) async {
    final masterKey = await _nekotonRepository.addLedgerKey(accountId: 0);

    await _ledgerService.connect(
      masterKey: masterKey,
      device: device,
      deviceModelId: deviceModelId,
    );

    _currentKeyService.changeCurrentKey(masterKey);
  }
}
