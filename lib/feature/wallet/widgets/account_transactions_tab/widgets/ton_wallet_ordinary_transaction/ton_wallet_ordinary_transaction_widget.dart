import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class TonWalletOrdinaryTransactionWidget
    extends InjectedElementaryParametrizedWidget<
        TonWalletOrdinaryTransactionWidgetWidgetModel,
        TonWalletOrdinaryTransactionWmParams> {
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
    return MultiListenerRebuilder(
      listenableList: [
        wm.isIncoming,
        wm.isFirst,
        wm.isLast,
        wm.address,
        wm.transactionFee,
        wm.date,
        wm.transactionValue,
      ],
      builder: (context) {
        final isIncoming = wm.isIncoming.value;
        final isFirst = wm.isFirst.value;
        final isLast = wm.isLast.value;
        final address = wm.address.value;
        final transactionFee = wm.transactionFee.value;
        final date = wm.date.value;
        final transactionValue = wm.transactionValue.value;

        return TonWalletTransactionWidget(
          icon:
              isIncoming ? LucideIcons.arrowDownLeft : LucideIcons.arrowUpRight,
          isFirst: isFirst,
          isLast: isLast,
          onPressed: wm.onPressed,
          address: address,
          isIncoming: isIncoming,
          status: TonWalletTransactionStatus.completed,
          transactionFee: transactionFee,
          transactionDateTime: date,
          transactionValue: transactionValue,
        );
      },
    );
  }
}
