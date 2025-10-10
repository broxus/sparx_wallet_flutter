import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/default_sliver_app_bar.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Details page of the [TonWallet], that is used to look though transactions
/// history and to send tokens.
class TonWalletDetailsPage
    extends
        InjectedElementaryParametrizedWidget<
          TonWalletDetailsPageWidgetModel,
          Address
        > {
  const TonWalletDetailsPage({required Address address, super.key})
    : super(wmFactoryParam: address);

  @override
  Widget build(TonWalletDetailsPageWidgetModel wm) {
    return ColoredBox(
      color: wm.theme.colors.background0,
      child: DoubleSourceBuilder(
        firstSource: wm.accountState,
        secondSource: wm.errorState,
        builder: (_, account, error) {
          if (account == null) return const SizedBox.shrink();

          return _Body(
            symbol: wm.symbol,
            account: account,
            tokenBalanceState: wm.tokenBalanceState,
            fiatBalanceState: wm.fiatBalanceState,
            error: error,
            loadingErrorState: wm.loadingErrorState,
            controller: wm.scrollController,
            onRetry: wm.retry,
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.account,
    required this.symbol,
    required this.controller,
    required this.tokenBalanceState,
    required this.fiatBalanceState,
    required this.loadingErrorState,
    this.error,
    this.onRetry,
  });

  final KeyAccount account;
  final String symbol;
  final ListenableState<Money> tokenBalanceState;
  final ListenableState<Money> fiatBalanceState;
  final ListenableState<bool> loadingErrorState;
  final Object? error;
  final ScrollController controller;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).systemGestureInsets.bottom;
    final theme = context.themeStyleV2;

    return CustomScrollView(
      controller: controller,
      slivers: [
        DefaultSliverAppBar(
          title: symbol,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                const _Background(),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 72),
                      Text(
                        symbol,
                        style: theme.textStyles.labelSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                      const SizedBox(height: DimensSizeV2.d12),
                      StateNotifierBuilder(
                        listenableState: tokenBalanceState,
                        builder: (_, tokenBalance) {
                          if (tokenBalance == null) {
                            return const SizedBox.shrink();
                          }
                          return AmountWidget.fromMoney(
                            amount: tokenBalance,
                            includeSymbol: false,
                            style: theme.textStyles.headingXLarge,
                          );
                        },
                      ),
                      const SizedBox(height: DimensSizeV2.d4),
                      StateNotifierBuilder(
                        listenableState: fiatBalanceState,
                        builder: (_, fiatBalance) {
                          if (fiatBalance == null) {
                            return const SizedBox.shrink();
                          }
                          return AmountWidget.dollars(
                            amount: fiatBalance,
                            style: theme.textStyles.labelXSmall,
                          );
                        },
                      ),
                      const SizedBox(height: DimensSizeV2.d16),
                      if (error == null)
                        WalletAccountActions(
                          account: account,
                          allowStake: false,
                          sendSpecified: true,
                          padding: EdgeInsets.zero,
                        ),
                      const SizedBox(height: DimensSizeV2.d48),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        DecoratedSliver(
          decoration: BoxDecoration(
            color: theme.colors.background0,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(DimensRadiusV2.radius24),
            ),
          ),
          sliver: SliverPadding(
            padding: EdgeInsets.only(
              top: DimensSizeV2.d16,
              bottom: bottomPadding + DimensSizeV2.d16,
              left: DimensSizeV2.d16,
              right: DimensSizeV2.d16,
            ),
            sliver: error == null
                ? AccountTransactionsTab(
                    account: account,
                    scrollController: controller,
                  )
                : null,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            color: theme.colors.background0,
            padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
            child: error?.let(
              (error) => Center(
                child: StateNotifierBuilder(
                  listenableState: loadingErrorState,
                  builder: (_, isLoadingError) => WalletSubscribeErrorWidget(
                    error: error,
                    isLoadingError: isLoadingError ?? false,
                    onRetryPressed: onRetry,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) => Positioned.fill(
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d28),
        child: Image.asset(
          Assets.images.walletBg.walletBg.path,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
