import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

LedgerTestPageWidgetModel defaultLedgerTestPageWidgetModelFactory(
  BuildContext context,
) =>
    LedgerTestPageWidgetModel(
      LedgerTestPageModel(
        createPrimaryErrorHandler(context),
      ),
    );

class LedgerTestPageWidgetModel
    extends CustomWidgetModel<LedgerTestPageWidget, LedgerTestPageModel> {
  LedgerTestPageWidgetModel(super.model);

  late final LedgerService _ledgerService = inject();
  late final LedgerBleScanner _ledgerBleScanner = inject();
  late final NekotonRepository _nekotonRepository = inject();

  late final scanResult = createNotifierFromStream(
    _ledgerBleScanner.scanResult,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _ledgerBleScanner.startScan();
  }

  @override
  void dispose() {
    _ledgerBleScanner.stopScan();
    super.dispose();
  }

  Future<void> connect(ScanResult item) async {
    final app = await _ledgerService.getAppInterface(
      device: item.device,
      deviceModelId: item.getLedgerDeviceModel()!.id,
    );
    await _ledgerService.initLedgerConnection(app);

    // final masterKey = await _nekotonRepository.addLedgerKey(accountId: 0);

    // await _ledgerService.connect(
    //   masterKey: masterKey,
    //   device: item.device,
    //   deviceModelId: item.getLedgerDeviceModel()!.id,
    // );
  }
}
