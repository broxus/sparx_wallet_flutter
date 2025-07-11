import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class TonWalletOrdinaryTransactionWidget extends InjectedElementaryWidget<
    TonWalletOrdinaryTransactionWidgetWidgetModel> {
  TonWalletOrdinaryTransactionWidget({
    required TonWalletOrdinaryTransaction transaction,
    required bool isFirst,
    required bool isLast,
    required Fixed price,
    super.key,
  }) : super(
          wmFactoryParam: TonWalletOrdinaryTransactionWmParams(
            transaction: transaction,
            isFirst: isFirst,
            isLast: isLast,
            price: price,
          ),
        );

  @override
  Widget build(TonWalletOrdinaryTransactionWidgetWidgetModel wm) {
    return TonWalletTransactionWidget(
      icon:
          wm.isIncoming ? LucideIcons.arrowDownLeft : LucideIcons.arrowUpRight,
      isFirst: wm.isFirst,
      isLast: wm.isLast,
      onPressed: wm.onPressed,
      address: wm.address,
      isIncoming: wm.isIncoming,
      status: TonWalletTransactionStatus.completed,
      transactionFee: wm.transactionFee,
      transactionDateTime: wm.date,
      transactionValue: wm.transactionValue,
    );
  }
}
