import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions_state.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/token_wallet_transactions/token_wallet_transactions_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/scroll_controller_preload_listener.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that allows load transaction for [TokenWallet] and map them into
/// pretty ui.
class TokenWalletTransactionsWidget
    extends
        InjectedElementaryParametrizedWidget<
          TokenWalletTransactionsWidgetModel,
          TokenWalletTransactionsParams
        > {
  TokenWalletTransactionsWidget({
    required Address owner,
    required Address rootTokenContract,
    required this.scrollController,
    super.key,
  }) : super(
         wmFactoryParam: TokenWalletTransactionsParams(
           owner: owner,
           rootTokenContract: rootTokenContract,
         ),
       );

  final ScrollController scrollController;

  @override
  Widget build(TokenWalletTransactionsWidgetModel wm) {
    return StateNotifierBuilder<TokenWalletTransactionsState>(
      listenableState: wm.walletTransactionsState,
      builder: (context, state) {
        final theme = context.themeStyleV2;
        return switch (state!) {
          TokenWalletTransactionsStateEmpty() => SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: DimensSize.d24),
              child: SeparatedColumn(
                spacing: DimensSize.d12,
                children: [
                  Assets.images.lightning.svg(
                    colorFilter: theme.colors.content3.colorFilter,
                    width: DimensSize.d56,
                    height: DimensSize.d56,
                  ),
                  Text(
                    LocaleKeys.emptyHistoryTitle.tr(),
                    style: theme.textStyles.paragraphSmall.copyWith(
                      color: theme.colors.content1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TokenWalletTransactionsStateLoading() => const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: DimensSize.d16),
              child: Center(child: CommonCircularProgressIndicator()),
            ),
          ),
          TokenWalletTransactionsStateTransactions(
            :final transactions,
            :final tokenCurrency,
            :final isLoading,
            :final tokenCustomCurrency,
          ) =>
            ScrollControllerPreloadListener(
              preloadAction: wm.tryPreloadTransactions,
              scrollController: scrollController,
              child: SliverList.builder(
                itemCount: transactions.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == transactions.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: DimensSize.d16),
                      child: Center(child: CommonCircularProgressIndicator()),
                    );
                  }

                  final prev = index == 0 ? null : transactions[index - 1];
                  final trans = transactions[index];
                  final next = index == transactions.length - 1
                      ? null
                      : transactions[index + 1];
                  final isFirst =
                      prev == null || !prev.date.isSameDay(trans.date);
                  final isLast =
                      next == null || !next.date.isSameDay(trans.date);

                  final ticker = inject<NekotonRepository>()
                      .currentTransport
                      .nativeTokenTicker;

                  return TokenWalletTransactionWidget(
                    transaction: trans,
                    isFirst: isFirst,
                    isLast: isLast,
                    transactionFee: Money.fromBigIntWithCurrency(
                      trans.fees,
                      Currencies()[ticker]!,
                    ),
                    transactionValue: Money.fromBigIntWithCurrency(
                      trans.value,
                      tokenCurrency,
                    ),
                    price: Fixed.parse(tokenCustomCurrency?.price ?? '0'),
                    rootTokenContract: wm.rootTokenContract,
                  );
                },
              ),
            ),
        };
      },
    );
  }
}
