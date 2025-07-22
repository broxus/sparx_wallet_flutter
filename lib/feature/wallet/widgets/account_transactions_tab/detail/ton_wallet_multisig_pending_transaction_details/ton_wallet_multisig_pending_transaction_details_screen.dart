import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_custodians.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/ton_wallet_multisig_pending_transaction_details_screen_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/container/separated_column.dart';
import 'package:ui_components_lib/components/common/default_app_bar.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/accent_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';

class TonWalletMultisigPendingTransactionDetailsScreen
    extends InjectedElementaryParametrizedWidget<
        TonWalletMultisigPendingTransactionDetailsScreenWidgetModel,
        TonWalletMultisigPendingTransactionDetailsWmParams> {
  TonWalletMultisigPendingTransactionDetailsScreen({
    required TonWalletMultisigPendingTransaction transaction,
    required Fixed price,
    required KeyAccount account,
    super.key,
  }) : super(
          wmFactoryParam: TonWalletMultisigPendingTransactionDetailsWmParams(
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
          spacing: DimensSize.d12,
          children: [
            ValueListenableBuilder(
              valueListenable: wm.account,
              builder: (_, account, __) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensSizeV2.d16,
                  ),
                  child: AccountInfo(account: account),
                );
              },
            ),
            MultiListenerRebuilder(
              listenableList: [
                wm.date,
                wm.isIncoming,
                wm.transactionFee,
                wm.transactionValue,
                wm.transactionHash,
                wm.transactionAddress,
                wm.transactionComment,
                wm.info,
                wm.tonIconPath,
                wm.price,
                wm.expiresAt,
                wm.safeHexString,
              ],
              builder: (context) {
                final date = wm.date.value;
                final isIncoming = wm.isIncoming.value;
                final fee = wm.transactionFee.value;
                final value = wm.transactionValue.value;
                final hash = wm.transactionHash.value;
                final address = wm.transactionAddress.value;
                final comment = wm.transactionComment.value;
                final info = wm.info.value;
                final tonIconPath = wm.tonIconPath.value;
                final price = wm.price.value;
                final expiresAt = wm.expiresAt.value;
                final safeHexString = wm.safeHexString.value;

                return WalletTransactionDetailsDefaultBody(
                  date: date,
                  isIncoming: isIncoming,
                  status: TonWalletTransactionStatus.waitingConfirmation,
                  fee: fee,
                  value: value,
                  hash: hash,
                  recipientOrSender: address,
                  comment: comment,
                  info: info,
                  type: LocaleKeys.multisigWord.tr(),
                  tonIconPath: tonIconPath,
                  tokenIconPath: tonIconPath,
                  price: price,
                  expiresAt: expiresAt,
                  transactionId: safeHexString,
                );
              },
            ),
            MultiListenerRebuilder(
              listenableList: [
                wm.confirmations,
                wm.requiredConfirmations,
                wm.custodians,
                wm.initiator,
              ],
              builder: (context) {
                final confirmations = wm.confirmations.value;
                final requiredConfirmations = wm.requiredConfirmations.value;
                final custodians = wm.custodians.value;
                final initiator = wm.initiator.value;

                return TonWalletTransactionCustodiansDetails(
                  confirmations: confirmations,
                  requiredConfirmations: requiredConfirmations,
                  custodians: custodians,
                  initiator: initiator,
                );
              },
            ),
            const SizedBox.shrink(),
            ValueListenableBuilder(
              valueListenable: wm.isCanConfirm,
              builder: (_, isCanConfirm, __) => isCanConfirm == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimensSizeV2.d16,
                      ),
                      child: AccentButton(
                        buttonShape: ButtonShape.pill,
                        onPressed: wm.onPressedConfirm,
                        title: LocaleKeys.confirmTransaction.tr(),
                        icon: LucideIcons.check,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: DimensSizeV2.d24),
          ],
        ),
      ),
    );
  }
}
