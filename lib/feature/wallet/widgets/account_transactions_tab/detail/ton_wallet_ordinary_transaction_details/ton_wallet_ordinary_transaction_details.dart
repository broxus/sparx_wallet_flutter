import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details_wm.dart';
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

class TonWalletOrdinaryTransactionDetails
    extends InjectedElementaryParametrizedWidget<
        TonWalletOrdinaryTransactionDetailsWidgetModel,
        TonWalletOrdinaryTransactionDetailsWmParams> {
  TonWalletOrdinaryTransactionDetails({
    required TonWalletOrdinaryTransaction transaction,
    required Fixed price,
    super.key,
  }) : super(
          wmFactoryParam: TonWalletOrdinaryTransactionDetailsWmParams(
            transaction: transaction,
            price: price,
          ),
        );

  @override
  Widget build(TonWalletOrdinaryTransactionDetailsWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleWidget: Text(
          LocaleKeys.detailedInfo.tr(),
          style: wm.textStyles.headingMedium,
        ),
      ),
      backgroundColor: wm.colors.background0,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SeparatedColumn(
                  spacing: DimensSize.d16,
                  children: [
                    MultiListenerRebuilder(
                      listenableList: [
                        wm.date,
                        wm.isIncoming,
                        wm.transactionFee,
                        wm.transactionValue,
                        wm.transactionHash,
                        wm.transactionAddress,
                        wm.transactionComment,
                        wm.transactionInfo,
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
                        final info = wm.transactionInfo.value;
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
                          type: LocaleKeys.ordinaryWord.tr(),
                          tonIconPath: tonIconPath,
                          tokenIconPath: tonIconPath,
                          price: price,
                        );
                      },
                    ),
                  ],
                ),
              ),
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
            SizedBox(height: wm.bottomPadding),
          ],
        ),
      ),
    );
  }
}
