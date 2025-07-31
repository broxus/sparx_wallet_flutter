import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_body_with_see_explorer.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TokenWalletOrdinaryTransactionDetailsScreen
    extends InjectedElementaryParametrizedWidget<
        TokenWalletOrdinaryTransactionDetailsScreenWidgetModel,
        TokenWalletOrdinaryTransactionDetailsScreenWmParams> {
  TokenWalletOrdinaryTransactionDetailsScreen({
    required TokenWalletOrdinaryTransaction transaction,
    required Currency tokenCurrency,
    required Fixed price,
    required Address rootTokenContract,
    super.key,
  }) : super(
          wmFactoryParam: TokenWalletOrdinaryTransactionDetailsScreenWmParams(
            transaction: transaction,
            tokenCurrency: tokenCurrency,
            price: price,
            rootTokenContract: rootTokenContract,
          ),
        );

  @override
  Widget build(TokenWalletOrdinaryTransactionDetailsScreenWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleWidget: Text(
          LocaleKeys.detailedInfo.tr(),
          style: wm.theme.textStyles.headingMedium,
        ),
      ),
      backgroundColor: wm.theme.colors.background0,
      body: SafeArea(
        child: WalletTransactionDetailsBodyWithExplorerButton(
          transactionHash: wm.transaction.hash,
          body: SeparatedColumn(
            spacing: DimensSize.d16,
            children: [
              WalletTransactionDetailsDefaultBody(
                date: wm.transaction.date,
                isIncoming: !wm.transaction.isOutgoing,
                status: TonWalletTransactionStatus.completed,
                fee: wm.moneyFee,
                value: wm.moneyValue,
                hash: wm.transaction.hash,
                recipientOrSender: wm.transaction.address,
                type: LocaleKeys.ordinaryWord.tr(),
                price: wm.price,
                tonIconPath: wm.tonIconPath,
                tokenIconPath: wm.logoURI,
              ),
            ],
          ),
        ),
        onPressed: wm.onPressedDetails,
      ),
    );
  }
}
