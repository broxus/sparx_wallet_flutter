import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/account_info/account_info_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AccountInfoWidget extends InjectedElementaryParametrizedWidget<
    AccountInfoWidgetModel, Address> {
  const AccountInfoWidget({
    required Address account,
    super.key,
  }) : super(
          wmFactoryParam: account,
        );

  @override
  Widget build(AccountInfoWidgetModel wm) {
    return ValueListenableBuilder(
      valueListenable: wm.accountAddress,
      builder: (_, account, __) {
        if (account == null) return const SizedBox.shrink();

        return AccountInfo(
          account: account,
          color: wm.color,
        );
      },
    );
  }
}
