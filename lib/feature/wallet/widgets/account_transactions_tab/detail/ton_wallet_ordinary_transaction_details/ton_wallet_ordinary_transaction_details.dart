import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details_wm.dart';
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
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';
import 'package:ui_components_lib/v2/widgets/buttons/primary_button.dart';

class TonWalletOrdinaryTransactionDetails
    extends ElementaryWidget<TonWalletOrdinaryTransactionDetailsWidgetModel> {
  TonWalletOrdinaryTransactionDetails({
    required TonWalletOrdinaryTransaction transaction,
    required Fixed price,
    super.key,
    WidgetModelFactory<TonWalletOrdinaryTransactionDetailsWidgetModel>?
        wmFactory,
  }) : super(
          wmFactory ??
              (context) =>
                  defaultTonWalletOrdinaryTransactionDetailsWidgetModelFactory(
                    context,
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SeparatedColumn(
                spacing: DimensSize.d16,
                children: [
                  WalletTransactionDetailsDefaultBody(
                    date: wm.date,
                    isIncoming: wm.isIncoming,
                    status: TonWalletTransactionStatus.completed,
                    fee: wm.transactionFee,
                    value: wm.transactionValue,
                    hash: wm.transactionHash,
                    recipientOrSender: wm.transactionAddress,
                    comment: wm.transactionComment,
                    info: wm.transactionInfo,
                    type: LocaleKeys.ordinaryWord.tr(),
                    tonIconPath: wm.tonIconPath,
                    tokenIconPath: wm.tonIconPath,
                    price: wm.price,
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
        ],
      ),
    );
  }
}
