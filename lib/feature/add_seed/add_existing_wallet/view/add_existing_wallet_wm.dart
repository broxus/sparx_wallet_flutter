import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/add_seed/add_seed.dart';
import 'package:app/feature/add_seed/import_wallet/route.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

AddExistingWalletWidgetModel defaultAddExistingWalletWidgetModelFactory(
  BuildContext context,
) =>
    AddExistingWalletWidgetModel(
      AddExistingWalletModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class AddExistingWalletWidgetModel
    extends CustomWidgetModel<AddExistingWalletWidget, AddExistingWalletModel>
    with BleAvailabilityMixin {
  AddExistingWalletWidgetModel(super.model);

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onImport() => context.compassContinue(const ImportWalletRouteData());

  Future<void> onLedger() async {
    final hasPermissions = await checkBluetoothPermissions();

    if (contextSafe == null || !hasPermissions) return;

    final result = await showImportLedgerSheet(contextSafe!);
    if (result != null) {
      contextSafe?.let((context) {
        context.compassPointNamed(const WalletRouteData());
      });
    }
  }
}
