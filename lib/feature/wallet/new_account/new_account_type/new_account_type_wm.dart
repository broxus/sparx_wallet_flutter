// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/connection_service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/feature/wallet/new_account/add_account.dart';
import 'package:app/feature/wallet/new_account/new_account_type/new_account_type_model.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NewAccountTypeWmParams {
  NewAccountTypeWmParams({
    required this.publicKey,
    required this.password,
  });

  final PublicKey publicKey;
  final String? password;
}

@injectable
class NewAccountTypeWidgetModel extends CustomWidgetModelParametrized<
    NewAccountTypeWidget,
    NewAccountTypeModel,
    NewAccountTypeWmParams> with BleAvailabilityWmMixin {
  NewAccountTypeWidgetModel(
    super.model,
  );

  late final controller = createTextEditingController();
  late final availableTypes = List<WalletType>.from(
    model.transport.availableWalletTypes,
  );
  late final defaultType = model.transport.defaultWalletType;
  late final defaultMultisigType = availableTypes.firstWhereOrNull(
    (item) => item == const WalletType.multisig(MultisigType.multisig2_1),
  );
  late final deprecatedTypes = availableTypes.where(
    (item) => !_standardTypes.contains(item),
  );

  late final _loadingState = createNotifier(false);
  late final _selectedState = createNotifier(defaultType);
  late final _showDeprecatedState = createNotifier(false);

  // Hamster network workaround
  late final Set<WalletType> _standardTypes = isHmstr
      ? {
          const WalletType.walletV5R1(),
          defaultType,
          if (defaultMultisigType != null) defaultMultisigType!,
        }
      : {
          defaultType,
          if (defaultMultisigType != null) defaultMultisigType!,
        };

  ListenableState<bool> get loadingState => _loadingState;

  ListenableState<WalletType> get selectedState => _selectedState;

  ListenableState<bool> get showDeprecatedState => _showDeprecatedState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  // Hamster & TON network workaround
  bool get isHmstr => model.transport.isHmstr;
  bool get isDeprecatedVisible =>
      model.transport.isEverscale ||
      model.transport.isHmstr ||
      model.transport.isTon;

  Set<WalletType> getDisabledWalletTypes() {
    if (wmParams.value.password == null) {
      final key = model.getMasterKey(wmParams.value.publicKey);

      if (key?.isLegacy ?? false) {
        return model.getCreatedAccountTypes(wmParams.value.publicKey).toSet();
      }
    }

    return {};
  }

  String getWalletName(WalletType walletType) =>
      model.transport.defaultAccountName(walletType);

  void onSelect(WalletType walletType) => _selectedState.accept(walletType);

  // ignore: avoid_positional_boolean_parameters
  void onShowDeprecatedChanged(bool value) =>
      _showDeprecatedState.accept(value);

  Future<void> onSubmit() async {
    final walletType = selectedState.value!;
    final name = controller.text;
    final key = model.getMasterKey(wmParams.value.publicKey);

    if (getDisabledWalletTypes().contains(walletType)) return;
    if (key == null) return;

    try {
      _loadingState.accept(true);

      if (key.isLedger) {
        final isAvailable = await checkBluetoothAvailability();
        if (!isAvailable) return;
      }

      final accountAddress = await model.createAccount(
        walletType: walletType,
        publicKey: wmParams.value.publicKey,
        name: name.isEmpty ? null : name,
        password: wmParams.value.password,
      );

      if (contextSafe != null) {
        await showNewAccountResultSheet(
          context: contextSafe!,
          address: accountAddress,
        );
        context.compassPointNamed(
          const WalletRouteData(),
        );
      }
    } on Exception catch (e) {
      model.showMessage(Message.error(message: e.toString()));
    } finally {
      _loadingState.accept(false);
    }
  }
}
