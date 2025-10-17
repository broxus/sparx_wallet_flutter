import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_pending_transaction_widget/ton_wallet_multisig_pending_transaction_widget_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

class TonWalletMultisigPendingTransactionWidget
    extends
        InjectedElementaryParametrizedWidget<
          TonWalletMultisigPendingTransactionWidgetWidgetModel,
          TonWalletMultisigPendingTransactionParams
        > {
  TonWalletMultisigPendingTransactionWidget({
    required TonWalletMultisigPendingTransaction transaction,
    required bool isFirst,
    required bool isLast,
    required Fixed price,
    required KeyAccount account,
    super.key,
  }) : super(
         wmFactoryParam: TonWalletMultisigPendingTransactionParams(
           transaction: transaction,
           isFirst: isFirst,
           isLast: isLast,
           price: price,
           account: account,
         ),
       );

  @override
  Widget build(TonWalletMultisigPendingTransactionWidgetWidgetModel wm) {
    return TonWalletTransactionWidget(
      isFirst: wm.isFirst,
      isLast: wm.isLast,
      onPressed: wm.onPressed,
      address: wm.transaction.address,
      isIncoming: !wm.transaction.isOutgoing,
      status: TonWalletTransactionStatus.waitingConfirmation,
      transactionFee: wm.transactionFee,
      transactionDateTime: wm.transaction.date,
      transactionValue: wm.transactionValue,
      additionalInformation: Padding(
        padding: const EdgeInsets.only(bottom: DimensSizeV2.d3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              LocaleKeys.confirmedCustodians.tr(
                args: [
                  wm.transaction.signsReceived.toString(),
                  wm.transaction.signsRequired.toString(),
                ],
              ),
              style: wm.theme.textStyles.labelXSmall.copyWith(
                color: wm.theme.colors.warning,
              ),
            ),
            Text(
              LocaleKeys.expiresInCustodians.tr(
                args: [wm.expireAtFormat.format(wm.transaction.expireAt)],
              ),
              style: wm.theme.textStyles.labelXSmall.copyWith(
                color: wm.theme.colors.content3,
              ),
            ),
          ],
        ),
      ),
      icon: LucideIcons.timer,
    );
  }
}
