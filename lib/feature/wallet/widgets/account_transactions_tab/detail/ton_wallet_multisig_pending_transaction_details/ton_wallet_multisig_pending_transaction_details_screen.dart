import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_custodians.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/ton_wallet_multisig_pending_transaction_details_screen_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/container/separated_column.dart';
import 'package:ui_components_lib/components/common/default_app_bar.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/accent_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';

class TonWalletMultisigPendingTransactionDetailsScreen extends ElementaryWidget<
    TonWalletMultisigPendingTransactionDetailsScreenWidgetModel> {
  TonWalletMultisigPendingTransactionDetailsScreen({
    required TonWalletMultisigPendingTransaction transaction,
    required Fixed price,
    required KeyAccount account,
    super.key,
    WidgetModelFactory<
            TonWalletMultisigPendingTransactionDetailsScreenWidgetModel>?
        wmFactory,
  }) : super(
          wmFactory ??
              (context) =>
                  defaultTonWalletMultisigPendingTransactionDetailsScreenWidgetModelFactory(
                    context,
                    transaction: transaction,
                    price: price,
                    account: account,
                  ),
        );

  @override
  Widget build(TonWalletMultisigPendingTransactionDetailsScreenWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleWidget: Text(
          LocaleKeys.detailedInfo.tr(),
          style: wm.textStyles.headingMedium,
        ),
      ),
      backgroundColor: wm.colors.background0,
      body: SingleChildScrollView(
        child: SeparatedColumn(
          separatorSize: DimensSize.d12,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
              child: AccountInfo(account: wm.account),
            ),
            WalletTransactionDetailsDefaultBody(
              date: wm.date,
              isIncoming: wm.isIncoming,
              status: TonWalletTransactionStatus.waitingConfirmation,
              fee: wm.transactionFee,
              value: wm.transactionValue,
              hash: wm.transactionHash,
              recipientOrSender: wm.transactionAddress,
              comment: wm.transactionComment,
              info: wm.info,
              type: LocaleKeys.multisigWord.tr(),
              tonIconPath: wm.tonIconPath,
              tokenIconPath: wm.tonIconPath,
              price: wm.price,
              expiresAt: wm.expiresAt,
              transactionId: wm.safeHexString,
            ),
            TonWalletTransactionCustodiansDetails(
              confirmations: wm.confirmations,
              requiredConfirmations: wm.requiredConfirmations,
              custodians: wm.custodians,
              initiator: wm.initiator,
            ),
            const SizedBox.shrink(),
            if (wm.isCanConfirm)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSizeV2.d16,
                ),
                child: AccentButton(
                  buttonShape: ButtonShape.pill,
                  onPressed: wm.onPressedConfirm,
                  title: LocaleKeys.confirmTransaction.tr(),
                  icon: LucideIcons.check,
                ),
              ),
            const SizedBox(height: DimensSizeV2.d24),
          ],
        ),
      ),
    );
  }
}
