import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:async/async.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

ImportLedgerWidgetModel defaultImportLedgerWidgetModelFactory(
  BuildContext context,
) =>
    ImportLedgerWidgetModel(
      ImportLedgerModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class ImportLedgerWidgetModel
    extends CustomWidgetModel<ImportLedgerWidget, ImportLedgerModel>
    with BleAvailabilityWmMixin {
  ImportLedgerWidgetModel(super.model);

  late final _scanResultState = createNotifierFromStream(model.scanResult);
  late final _isBluetoothEnabledState = createNotifierFromStream(
    model.adapterState.map(
      (state) => switch (state) {
        BluetoothAdapterState.on => true,
        _ => false,
      },
    ),
  );
  late final _isSelectedState = createNotifier(false);
  late final _isConnectedState = createNotifier(false);
  late final _isInitializedState = createNotifier(false);
  late final _isLoadingState = createNotifier(false);

  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  LedgerAppInterface? _appInterface;
  CancelableOperation<bool>? _operation;

  ListenableState<List<ScanResult>> get scanResultState => _scanResultState;

  ListenableState<bool> get isSelectedState => _isSelectedState;

  ListenableState<bool> get isConnectedState => _isConnectedState;

  ListenableState<bool> get isInitializedState => _isInitializedState;

  ListenableState<bool> get isBluetoothEnabledState => _isBluetoothEnabledState;

  ListenableState<bool> get isLoadingState => _isLoadingState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  @override
  void dispose() {
    _adapterStateSubscription?.cancel();
    _operation?.cancel();
    _appInterface?.dispose();
    model.stopScan();
    super.dispose();
  }

  void onCancel() => Navigator.of(context).pop();

  Future<void> onContinue() async {
    final appInterface = _appInterface;
    if (appInterface == null) return;

    try {
      _isLoadingState.accept(true);

      final masterKey = await model.addConnectedLedger(
        device: appInterface.device,
        deviceModelId: appInterface.deviceModel.id,
        name: widget.name,
      );

      contextSafe?.let((context) {
        model.showMessage(
          Message.successful(
            message: LocaleKeys.ledgerConnectedSuccessfully.tr(),
          ),
        );
        Navigator.of(context).pop(masterKey);
      });
    } catch (e) {
      model.showMessage(Message.error(message: e.toString()));
    } finally {
      _isLoadingState.accept(false);
    }
  }

  Future<void> onScanResultSelected(ScanResult item) async {
    try {
      _isSelectedState.accept(true);

      _appInterface = await model.getAppInterface(item);
      _isConnectedState.accept(true);

      _operation = _appInterface!.waitForApp();
      final result = await _operation!.valueOrCancellation(false);

      if (result ?? false) {
        _isInitializedState.accept(true);
      }
    } catch (e) {
      model.showMessage(Message.error(message: e.toString()));
    }
  }

  Future<void> _init() async {
    final hasPermissions = await checkBluetoothPermissions();

    if (!hasPermissions) {
      contextSafe?.let((context) => Navigator.of(context).pop());
      return;
    }

    await checkBluetoothAdapter();

    _adapterStateSubscription =
        model.adapterState.distinct().listen((state) async {
      if (state == BluetoothAdapterState.on) {
        await model.startScan();
      } else if (state == BluetoothAdapterState.off) {
        await model.stopScan();
      }
    });
  }
}
