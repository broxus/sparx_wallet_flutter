// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/connection_service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/new_account/add_account.dart';
import 'package:app/feature/wallet/new_account/new_account_type/new_account_type_model.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

NewAccountTypeWidgetModel defaultNewAccountTypeWidgetModelFactory(
  BuildContext context,
) =>
    NewAccountTypeWidgetModel(
      NewAccountTypeModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
      ),
    );

class NewAccountTypeWidgetModel
    extends CustomWidgetModel<NewAccountTypeWidget, NewAccountTypeModel> {
  NewAccountTypeWidgetModel(super.model);

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

  late final _loading = createNotifier(false);
  late final _selected = createNotifier(defaultType);
  late final _showDeprecated = createNotifier(false);

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

  ListenableState<bool> get loading => _loading;

  ListenableState<WalletType> get selected => _selected;

  ListenableState<bool> get showDeprecated => _showDeprecated;

  ThemeStyleV2 get theme => context.themeStyleV2;

  // Hamster & TON network workaround
  bool get isHmstr => model.transport.isHmstr;
  bool get isDeprecatedVisible =>
      model.transport.isEverscale ||
      model.transport.isHmstr ||
      model.transport.isTon;

  Set<WalletType> get disabledWalletTypes => widget.password == null
      ? model.getCreatedAccountTypes(widget.publicKey).toSet()
      : {};

  String getWalletName(WalletType walletType) =>
      model.transport.defaultAccountName(walletType);

  void onSelect(WalletType walletType) => _selected.accept(walletType);

  // ignore: avoid_positional_boolean_parameters
  void onShowDeprecatedChanged(bool value) => _showDeprecated.accept(value);

  Future<void> onSubmit() async {
    final walletType = selected.value!;
    final name = controller.text;

    if (disabledWalletTypes.contains(walletType)) return;

    try {
      _loading.accept(true);

      final accountAddress = await model.createAccount(
        walletType: walletType,
        publicKey: widget.publicKey,
        name: name.isEmpty ? null : name,
        password: widget.password,
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
      model.showError(context, e.toString());
    } finally {
      _loading.accept(false);
    }
  }
}
