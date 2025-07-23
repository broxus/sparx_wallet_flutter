import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v1/browser.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/custodians_settings/route.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings_model.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

AccountSettingsWidgetModel defaultAccountSettingsWidgetModelFactory(
  BuildContext context,
) =>
    AccountSettingsWidgetModel(
      AccountSettingsModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class AccountSettingsWidgetModel
    extends CustomWidgetModel<AccountSettingsWidget, AccountSettingsModel> {
  AccountSettingsWidgetModel(super.model);

  late final _displayAccounts = createNotifierFromStream(model.displayAccounts);

  ListenableState<List<KeyAccount>> get displayAccounts => _displayAccounts;

  void onCustodiansSettings(List<PublicKey> custodians) {
    Navigator.of(context).pop();
    final publicKeys = <String>[];
    for (final custodian in custodians) {
      publicKeys.add(custodian.publicKey);
    }

    context.compassContinue(
      CustodiansSettingsRouteData(custodians: publicKeys),
    );
  }

  void onViewInExplorer() {
    Navigator.of(context).pop();
    openBrowserUrl(
      model.getAccountExplorerLink(widget.account.address),
    );
  }

  void onRename() {
    Navigator.of(context)
      ..pop()
      ..push(getRenameAccountSheet(context, widget.account.address));
  }

  void onCopyAddress() {
    model.copyAddress(context, widget.account.address);
  }

  void onHideAccount() {
    Navigator.of(context).pop();
    model.hideAccount(widget.account.address);
  }

  void onVerify() {
    Navigator.of(context)
      ..pop()
      ..push(showVerifyLedgerSheet(widget.account));
  }
}
