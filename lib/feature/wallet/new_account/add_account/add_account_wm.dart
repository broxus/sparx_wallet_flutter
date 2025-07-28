import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/wallet/new_account/add_account/add_account_model.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_new_account_confirm_sheet.dart';
import 'package:app/feature/wallet/new_account/add_external_account/route.dart';
import 'package:app/feature/wallet/new_account/screen/route.dart';
import 'package:app/feature/wallet/new_account/select_seed/route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

AddAccountWidgetModel defaultAddAccountWidgetModelFactory(
  BuildContext context,
) =>
    AddAccountWidgetModel(
      AddAccountModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class AddAccountWidgetModel
    extends CustomWidgetModel<ElementaryWidget, AddAccountModel>
    with BleAvailabilityWmMixin {
  AddAccountWidgetModel(super.model);

  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _list = createNotifierFromStream(model.seedWithAccounts);

  ListenableState<List<Seed>> get list => _list;

  ListenableState<Seed?> get currentAccount => _currentAccount;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onSelect() async {
    if ((list.value?.length ?? 0) > 1) {
      contextSafe?.compassContinue(const SelectSeedRouteData());
      return;
    }

    final seed = _currentAccount.value;

    if (contextSafe == null || seed == null) {
      return;
    }

    if (seed.masterKey.isLegacy) {
      contextSafe?.compassContinue(
        NewAccountRouteData(
          publicKey: seed.publicKey.publicKey,
        ),
      );
      return;
    }

    if (seed.masterKey.isLedger) {
      final isAvailable = await checkBluetoothAvailability();
      if (!isAvailable) return;

      contextSafe?.compassContinue(
        NewAccountRouteData(
          publicKey: seed.publicKey.publicKey,
        ),
      );
      return;
    }

    final result = await showAddAccountConfirmSheet(
      context: contextSafe!,
      publicKey: seed.publicKey,
      seedName: seed.name,
    );

    if (contextSafe != null && result != null) {
      contextSafe?.compassContinue(
        NewAccountRouteData(
          publicKey: result.$1.publicKey,
          password: result.$2,
        ),
      );
    }
  }

  void onAddExternalAccount() {
    contextSafe?.compassContinue(const NewExternalAccountRouteData());
  }
}
