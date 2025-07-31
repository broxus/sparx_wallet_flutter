import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_widget_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TonWalletMultisigExpiredTransactionWidget
    extends InjectedElementaryParametrizedWidget<
        TonWalletMultisigExpiredTransactionWidgetModel,
        TonWalletMultisigExpiredTransactionWmParams> {
  TonWalletMultisigExpiredTransactionWidget({
    required TonWalletMultisigExpiredTransaction transaction,
    required Fixed price,
    required bool isFirst,
    required bool isLast,
    required KeyAccount account,
    super.key,
  }) : super(
          wmFactoryParam: TonWalletMultisigExpiredTransactionWmParams(
            transaction: transaction,
            price: price,
            isFirst: isFirst,
            isLast: isLast,
            account: account,
          ),
        );

  @override
  Widget build(TonWalletMultisigExpiredTransactionWidgetModel wm) {
    return MultiListenerRebuilder(
      listenableList: [
        wm.transactionState,
        wm.isFirstState,
        wm.isLastState,
        wm.transactionFeeState,
        wm.transactionValueState,
        wm.transactionTextState,
      ],
      builder: (context) {
        final transaction = wm.transactionState.value;
        final isFirst = wm.isFirstState.value;
        final isLast = wm.isLastState.value;
        final transactionFee = wm.transactionFeeState.value;
        final transactionValue = wm.transactionValueState.value;
        final transactionText = wm.transactionTextState.value;

        return TonWalletTransactionWidget(
          icon: LucideIcons.x,
          isFirst: isFirst,
          isLast: isLast,
          onPressed: wm.onPressedDetailed,
          address: transaction.address,
          isIncoming: !transaction.isOutgoing,
          status: TonWalletTransactionStatus.expired,
          transactionFee: transactionFee,
          transactionDateTime: transaction.date,
          transactionValue: transactionValue,
          additionalInformation: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                LocaleKeys.transactionExpired.tr(),
                style: wm.textStyles.labelXSmall.copyWith(
                  color: wm.colors.content3,
                ),
              ),
              const SizedBox(height: DimensSizeV2.d4),
              Text(
                transactionText,
                style: wm.textStyles.labelXSmall.copyWith(
                  color: wm.colors.content3,
                ),
              ),
              const SizedBox(height: DimensSizeV2.d6),
            ],
          ),
        );
      },
    );
  }
}
