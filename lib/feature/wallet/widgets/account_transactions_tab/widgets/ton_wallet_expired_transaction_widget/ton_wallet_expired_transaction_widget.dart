import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_expired_transaction_widget/ton_wallet_expired_transaction_widget_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays expired transaction for ton wallet
class TonWalletExpiredTransactionWidget
    extends
        InjectedElementaryParametrizedWidget<
          TonWalletExpiredTransactionWidgetWidgetModel,
          TonWalletExpiredTransactionParams
        > {
  TonWalletExpiredTransactionWidget({
    required TonWalletExpiredTransaction transaction,
    required bool isFirst,
    required bool isLast,
    super.key,
  }) : super(
         wmFactoryParam: TonWalletExpiredTransactionParams(
           transaction: transaction,
           isFirst: isFirst,
           isLast: isLast,
         ),
       );

  @override
  Widget build(TonWalletExpiredTransactionWidgetWidgetModel wm) {
    return TonWalletTransactionWidget(
      icon: LucideIcons.x,
      isFirst: wm.isFirst,
      isLast: wm.isLast,
      // ignore: no-empty-block
      onPressed: () {},
      address: wm.transaction.address,
      isIncoming: wm.transaction.isIncoming,
      status: TonWalletTransactionStatus.expired,
      transactionFee: null,
      transactionDateTime: wm.transaction.date,
      transactionValue: wm.transactionValue,
    );
  }
}
