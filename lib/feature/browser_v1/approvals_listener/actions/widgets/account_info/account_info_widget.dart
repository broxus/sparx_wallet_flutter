import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/account_info/account_info_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AccountInfoWidget
    extends InjectedElementaryWidget<AccountInfoWidgetModel> {
  const AccountInfoWidget({
    required Address account,
    super.key,
  }) : super(
          param1: account,
        );

  @override
  Widget build(AccountInfoWidgetModel wm) =>
      wm.account?.let(
        (account) => AccountInfo(account: account, color: wm.color),
      ) ??
      const SizedBox.shrink();
}
