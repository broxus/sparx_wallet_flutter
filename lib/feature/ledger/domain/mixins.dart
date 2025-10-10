import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

@singleton
class BleAvailabilityModelDelegate {
  BleAvailabilityModelDelegate({
    required LedgerService ledgerService,
    required MessengerService messengerService,
    required AppPermissionsService permissionsService,
  }) : _ledgerService = ledgerService,
       _messengerService = messengerService,
       _permissionsService = permissionsService;

  final LedgerService _ledgerService;
  final MessengerService _messengerService;
  final AppPermissionsService _permissionsService;

  Stream<BluetoothAdapterState> get adapterState => _ledgerService.adapterState;

  Future<bool> checkPermissions() => _ledgerService.checkPermissions();

  Future<void> openSettings() => _permissionsService.openSettings();

  void showMessage(Message message) => _messengerService.show(message);
}

mixin BleAvailabilityModelMixin on ElementaryModel {
  @protected
  BleAvailabilityModelDelegate get delegate;

  Stream<BluetoothAdapterState> get adapterState => delegate.adapterState;

  Future<bool> checkPermissions() => delegate.checkPermissions();

  Future<void> openSettings() => delegate.openSettings();

  void showMessage(Message message) => delegate.showMessage(message);
}

mixin BleAvailabilityWmMixin<
  W extends ElementaryWidget,
  M extends BleAvailabilityModelMixin
>
    on WidgetModel<W, M> {
  Future<bool> checkBluetoothAvailability() async {
    final hasPermissions = await checkBluetoothPermissions();
    if (!hasPermissions) return false;

    final isBluetoothEnabled = await checkBluetoothAdapter();
    if (!isBluetoothEnabled) return false;

    return true;
  }

  Future<bool> checkBluetoothPermissions() async {
    if (!await FlutterBluePlus.isSupported) {
      model.showMessage(
        Message.error(
          message: LocaleKeys.ledgerPermissionsError.tr(),
          actionText: LocaleKeys.giveWord.tr(),
          onAction: model.openSettings,
        ),
      );
      return false;
    }

    final hasPermissions = await model.checkPermissions();
    if (!hasPermissions) {
      model.showMessage(
        Message.error(
          message: LocaleKeys.ledgerPermissionsError.tr(),
          actionText: LocaleKeys.giveWord.tr(),
          onAction: model.openSettings,
        ),
      );
      return false;
    }

    return true;
  }

  Future<bool> checkBluetoothAdapter() async {
    final state = await model.adapterState.firstWhere(
      (e) => e != BluetoothAdapterState.unknown,
    );
    if (state != BluetoothAdapterState.on &&
        state != BluetoothAdapterState.turningOn) {
      model.showMessage(Message.error(message: LocaleKeys.bluetoothIsOff.tr()));
      return false;
    }

    return true;
  }
}
