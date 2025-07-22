import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_custodians.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen_wm.dart';
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
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';
import 'package:ui_components_lib/v2/widgets/buttons/primary_button.dart';

class TonWalletMultisigOrdinaryTransactionDetailsScreen
    extends InjectedElementaryParametrizedWidget<
        TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel,
        TonWalletMultisigOrdinaryTransactionDetailsWmParams> {
  TonWalletMultisigOrdinaryTransactionDetailsScreen({
    required TonWalletMultisigOrdinaryTransaction transaction,
    required Fixed price,
    required KeyAccount account,
    super.key,
  }) : super(
          wmFactoryParam: TonWalletMultisigOrdinaryTransactionDetailsWmParams(
            transaction: transaction,
            price: price,
            account: account,
          ),
        );

  @override
  Widget build(
    TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel wm,
  ) {
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
          spacing: DimensSize.d16,
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

                return WalletTransactionDetailsDefaultBody(
                  date: date,
                  isIncoming: isIncoming,
                  status: TonWalletTransactionStatus.completed,
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
                );
              },
            ),
            MultiListenerRebuilder(
              listenableList: [
                wm.confirmations,
                wm.custodians,
                wm.initiator,
              ],
              builder: (_) {
                final confirmations = wm.confirmations.value;
                final custodians = wm.custodians.value;
                final initiator = wm.initiator.value;

                return TonWalletTransactionCustodiansDetails(
                  confirmations: confirmations,
                  custodians: custodians,
                  initiator: initiator,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
              ),
              child: PrimaryButton(
                title: LocaleKeys.seeInExplorer.tr(),
                icon: LucideIcons.globe,
                onPressed: wm.onPressedSeeInExplorer,
                buttonShape: ButtonShape.pill,
              ),
            ),
            const SizedBox(height: DimensSizeV2.d24),
          ],
        ),
      ),
    );
  }
}
