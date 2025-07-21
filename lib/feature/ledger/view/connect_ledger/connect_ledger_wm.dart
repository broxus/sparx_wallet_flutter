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

ConnectLedgerWidgetModel defaultConnectLedgerWidgetModelFactory(
  BuildContext context,
) =>
    ConnectLedgerWidgetModel(
      ConnectLedgerModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class ConnectLedgerWidgetModel
    extends CustomWidgetModel<ConnectLedgerWidget, ConnectLedgerModel>
    with BleAvailabilityMixin {
  ConnectLedgerWidgetModel(super.model);

  late final _scanResultState = createNotifierFromStream(model.scanResult);
  late final _bluetoothState = createNotifierFromStream(
    model.adapterState.map(
      (state) => switch (state) {
        BluetoothAdapterState.on => true,
        _ => false,
      },
    ),
  );
  late final _selectedState = createNotifier(false);
  late final _connectedState = createNotifier(false);
  late final _initializedState = createNotifier(false);
  late final _loadingState = createNotifier(false);

  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  LedgerAppInterface? _appInterface;
  CancelableOperation<bool>? _operation;

  ListenableState<List<ScanResult>> get scanResult => _scanResultState;

  ListenableState<bool> get isSelected => _selectedState;

  ListenableState<bool> get isConnected => _connectedState;

  ListenableState<bool> get isInitialized => _initializedState;

  ListenableState<bool> get isBluetoothEnabled => _bluetoothState;

  ListenableState<bool> get isLoading => _loadingState;

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
      _loadingState.accept(true);

      await model.addConnectedLedger(
        device: appInterface.device,
        deviceModelId: appInterface.deviceModel.id,
      );

      contextSafe?.let((context) {
        model.showMessage(
          Message.successful(
            message: LocaleKeys.ledgerConnectedSuccessfully.tr(),
          ),
        );
        Navigator.of(context).pop(true);
      });
    } catch (e) {
      model.showMessage(Message.error(message: e.toString()));
    } finally {
      _loadingState.accept(false);
    }
  }

  Future<void> onScanResultSelected(ScanResult item) async {
    try {
      _selectedState.accept(true);

      _appInterface = await model.getAppInterface(item);
      _connectedState.accept(true);

      _operation = _appInterface!.waitForApp();
      final result = await _operation!.valueOrCancellation(false);

      if (result ?? false) {
        _initializedState.accept(true);
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
