import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/custodians_settings/route.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings_model.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class AccountSettingsWidgetModel
    extends
        CustomWidgetModelParametrized<
          AccountSettingsWidget,
          AccountSettingsModel,
          KeyAccount
        > {
  AccountSettingsWidgetModel(super.model);

  late final _displayAccountsState = createNotifierFromStream(
    model.displayAccounts,
  );
  late final _custodiansState = createNotifierFromStream(
    model.getCustodians(account.address),
  );

  ListenableState<List<PublicKey>?> get custodiansState => _custodiansState;

  ListenableState<List<KeyAccount>> get displayAccountsState =>
      _displayAccountsState;

  KeyAccount get account => wmParams.value;

  void onCustodiansSettings() {
    Navigator.of(context).pop();

    context.compassContinue(
      CustodiansSettingsRouteData(address: account.address),
    );
  }

  void onViewInExplorer() {
    Navigator.of(context).pop();
    model.openBrowserUrl(model.getAccountExplorerLink(account.address));
  }

  void onRename() {
    Navigator.of(context)
      ..pop()
      ..push(getRenameAccountSheet(context, account.address));
  }

  void onCopyAddress() {
    model.copyAddress(context, account.address);
  }

  void onHideAccount() {
    Navigator.of(context).pop();
    model.hideAccount(account.address);
  }

  void onVerify() {
    Navigator.of(context)
      ..pop()
      ..push(showVerifyLedgerSheet(account));
  }
}
