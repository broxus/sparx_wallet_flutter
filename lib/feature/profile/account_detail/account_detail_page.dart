import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Entry point for screen with information about account
class AccountDetailPage extends InjectedElementaryParametrizedWidget<
    AccountDetailWidgetModel, Address> {
  const AccountDetailPage({
    required Address address,
    super.key,
  }) : super(wmFactoryParam: address);

  @override
  Widget build(AccountDetailWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        actions: [
          FloatButton(
            buttonShape: ButtonShape.circle,
            icon: LucideIcons.cog,
            buttonSize: ButtonSize.medium,
            onPressed: wm.openSettings,
          ),
        ],
      ),
      body: MultiListenerRebuilder(
        listenableList: [
          wm.accountState,
          wm.balanceState,
          wm.custodiansState,
        ],
        builder: (_) {
          final account = wm.accountState.value;
          final balance = wm.balanceState.value;
          final custodians = wm.custodiansState.value;

          if (account == null || balance == null) {
            return const SizedBox.shrink();
          }

          return AccountDetailView(
            account: account,
            balance: balance,
            custodians: custodians ?? [],
          );
        },
      ),
    );
  }
}
