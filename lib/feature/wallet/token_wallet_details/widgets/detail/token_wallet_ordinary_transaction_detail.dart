import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/v2/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/common.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

/// Page that displays information about ordinary transaction for TonWallet
class TokenWalletOrdinaryTransactionDetailsPage extends StatelessWidget {
  const TokenWalletOrdinaryTransactionDetailsPage({
    required this.transaction,
    required this.tokenCurrency,
    required this.price,
    super.key,
  });

  final TokenWalletOrdinaryTransaction transaction;
  final Currency tokenCurrency;
  final Fixed price;

  @override
  Widget build(BuildContext context) {
    // TODO(malochka): move it in widget_model or model, old implementation
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    final theme = context.themeStyleV2;

    return Scaffold(
      appBar: DefaultAppBar(
        titleWidget: Text(
          LocaleKeys.detailedInfo.tr(),
          style: theme.textStyles.headingMedium,
        ),
      ),
      backgroundColor: theme.colors.background0,
      body: WalletTransactionDetailsBodyWithExplorerButton(
        transactionHash: transaction.hash,
        body: SeparatedColumn(
          separatorSize: DimensSize.d16,
          children: [
            WalletTransactionDetailsDefaultBody(
              date: transaction.date,
              isIncoming: !transaction.isOutgoing,
              status: TonWalletTransactionStatus.completed,
              fee: Money.fromBigIntWithCurrency(
                transaction.fees,
                Currencies()[ticker]!,
              ),
              value: Money.fromBigIntWithCurrency(
                transaction.value,
                tokenCurrency,
              ),
              hash: transaction.hash,
              recipientOrSender: transaction.address,
              type: LocaleKeys.ordinaryWord.tr(),
              price: price,
            ),
          ],
        ),
      ),
    );
  }
}
