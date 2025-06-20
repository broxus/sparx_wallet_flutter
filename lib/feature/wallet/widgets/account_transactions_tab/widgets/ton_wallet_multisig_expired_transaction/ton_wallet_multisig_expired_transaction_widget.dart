import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_widget_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TonWalletMultisigExpiredTransactionWidget
    extends InjectedElementaryWidget<
        TonWalletMultisigExpiredTransactionWidgetModel> {
  TonWalletMultisigExpiredTransactionWidget({
    required TonWalletMultisigExpiredTransaction transaction,
    required Fixed price,
    required bool isFirst,
    required bool isLast,
    required KeyAccount account,
    super.key,
  }) : super(
          param1: TonWalletMultisigExpiredTransactionWmParams(
            transaction: transaction,
            price: price,
            isFirst: isFirst,
            isLast: isLast,
            account: account,
          ),
        );

  @override
  Widget build(TonWalletMultisigExpiredTransactionWidgetModel wm) {
    return TonWalletTransactionWidget(
      icon: LucideIcons.x,
      isFirst: wm.isFirst,
      isLast: wm.isLast,
      onPressed: wm.onPressedDetailed,
      address: wm.transaction.address,
      isIncoming: !wm.transaction.isOutgoing,
      status: TonWalletTransactionStatus.expired,
      transactionFee: wm.transactionFee,
      transactionDateTime: wm.transaction.date,
      transactionValue: wm.transactionValue,
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
            wm.transactionText,
            style: wm.textStyles.labelXSmall.copyWith(
              color: wm.colors.content3,
            ),
          ),
          const SizedBox(height: DimensSizeV2.d6),
        ],
      ),
    );
  }
}
