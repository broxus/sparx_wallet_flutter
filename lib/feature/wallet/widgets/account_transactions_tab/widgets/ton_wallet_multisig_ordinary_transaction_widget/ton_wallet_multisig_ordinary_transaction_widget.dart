import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_ordinary_transaction_widget/ton_wallet_multisig_ordinary_transaction_widget_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class TonWalletMultisigOrdinaryTransactionWidget
    extends
        InjectedElementaryParametrizedWidget<
          TonWalletMultisigOrdinaryTransactionWidgetWidgetModel,
          TonWalletMultisigOrdinaryTransactionParams
        > {
  TonWalletMultisigOrdinaryTransactionWidget({
    required TonWalletMultisigOrdinaryTransaction transaction,
    required Fixed price,
    required bool isFirst,
    required bool isLast,
    required KeyAccount account,
    super.key,
  }) : super(
         wmFactoryParam: TonWalletMultisigOrdinaryTransactionParams(
           transaction: transaction,
           price: price,
           isFirst: isFirst,
           isLast: isLast,
           account: account,
         ),
       );

  @override
  Widget build(TonWalletMultisigOrdinaryTransactionWidgetWidgetModel wm) {
    return TonWalletTransactionWidget(
      icon: !wm.transaction.isOutgoing
          ? LucideIcons.arrowDownLeft
          : LucideIcons.arrowUpRight,
      isFirst: wm.isFirst,
      isLast: wm.isLast,
      onPressed: wm.onPressed,
      address: wm.transaction.address,
      isIncoming: !wm.transaction.isOutgoing,
      status: TonWalletTransactionStatus.completed,
      transactionFee: wm.transactionFee,
      transactionDateTime: wm.transaction.date,
      transactionValue: wm.transactionValue,
    );
  }
}
