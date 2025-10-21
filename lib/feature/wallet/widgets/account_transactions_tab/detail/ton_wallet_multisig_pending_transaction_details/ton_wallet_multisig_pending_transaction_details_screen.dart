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
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/container/separated_column.dart';
import 'package:ui_components_lib/components/common/default_app_bar.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/accent_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';

class TonWalletMultisigPendingTransactionDetailsScreen
    extends
        InjectedElementaryParametrizedWidget<
          TonWalletMultisigPendingTransactionDetailsScreenWidgetModel,
          TonWalletMultisigPendingTransactionDetailsWmParams
        > {
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
              valueListenable: wm.accountState,
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
                wm.dateState,
                wm.isIncomingState,
                wm.transactionFeeState,
                wm.transactionValueState,
                wm.transactionHashState,
                wm.transactionAddressState,
                wm.transactionCommentState,
                wm.infoState,
                wm.tonIconPathState,
                wm.priceState,
                wm.expiresAtState,
                wm.safeHexStringState,
              ],
              builder: (context) {
                final date = wm.dateState.value;
                final isIncoming = wm.isIncomingState.value;
                final fee = wm.transactionFeeState.value;
                final value = wm.transactionValueState.value;
                final hash = wm.transactionHashState.value;
                final address = wm.transactionAddressState.value;
                final comment = wm.transactionCommentState.value;
                final info = wm.infoState.value;
                final tonIconPath = wm.tonIconPathState.value;
                final price = wm.priceState.value;
                final expiresAt = wm.expiresAtState.value;
                final safeHexString = wm.safeHexStringState.value;

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
                wm.confirmationsState,
                wm.requiredConfirmationsState,
                wm.custodiansState,
                wm.initiatorState,
              ],
              builder: (context) {
                final confirmations = wm.confirmationsState.value;
                final requiredConfirmations =
                    wm.requiredConfirmationsState.value;
                final custodians = wm.custodiansState.value;
                final initiator = wm.initiatorState.value;

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
              valueListenable: wm.isCanConfirmState,
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
            SizedBox(height: wm.bottomPadding),
          ],
        ),
      ),
    );
  }
}
