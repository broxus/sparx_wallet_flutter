import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/browser.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/custodians_settings/route.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings_model.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AccountSettingsWmParams {
  const AccountSettingsWmParams({
    required this.account,
    required this.custodians,
  });

  final KeyAccount account;
  final List<PublicKey>? custodians;
}

@injectable
class AccountSettingsWidgetModel extends CustomWidgetModelParametrized<
    AccountSettingsWidget, AccountSettingsModel, AccountSettingsWmParams> {
  AccountSettingsWidgetModel(
    super.model,
  );

  late final _displayAccounts = createNotifierFromStream(model.displayAccounts);

  late final accountState = createWmParamsNotifier<KeyAccount>(
    (it) => it.account,
  );

  late final custodiansState = createWmParamsNotifier<List<PublicKey>?>(
    (it) => it.custodians,
  );
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
    model.openBrowserUrl(
      model.getAccountExplorerLink(accountState.value.address),
    );
  }

  void onRename() {
    Navigator.of(context)
      ..pop()
      ..push(getRenameAccountSheet(context, accountState.value.address));
  }

  void onCopyAddress() {
    model.copyAddress(context, accountState.value.address);
  }

  void onHideAccount() {
    Navigator.of(context).pop();
    model.hideAccount(accountState.value.address);
  }
}
