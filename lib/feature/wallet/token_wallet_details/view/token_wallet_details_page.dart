import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/token_wallet_details/view/token_wallet_details_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Details page of the [TokenWallet], that is used to look though transactions
/// history and to send/receive tokens.
class TokenWalletDetailsPage extends InjectedElementaryParametrizedWidget<
    TokenWalletDetailsWidgetModel, TokenWalletDetailsWmParams> {
  TokenWalletDetailsPage({
    required Address owner,
    required Address rootTokenContract,
    super.key,
  }) : super(
          wmFactoryParam: TokenWalletDetailsWmParams(
            owner: owner,
            rootTokenContract: rootTokenContract,
          ),
        );

  @override
  Widget build(TokenWalletDetailsWidgetModel wm) {
    return ColoredBox(
      color: wm.theme.colors.background0,
      child: _Body(
        owner: wm.owner,
        rootTokenContract: wm.rootTokenContract,
        contractName: wm.contractNameState,
        tokenBalance: wm.tokenBalanceState,
        fiatBalance: wm.fiatBalanceState,
        canSend: wm.canSendState,
        error: wm.errorState,
        isLoadingError: wm.loadingErrorState,
        controller: wm.scrollController,
        onRetry: wm.onRetry,
        onSend: wm.onSend,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.owner,
    required this.rootTokenContract,
    required this.contractName,
    required this.controller,
    required this.tokenBalance,
    required this.fiatBalance,
    required this.canSend,
    required this.error,
    required this.isLoadingError,
    required this.onRetry,
    required this.onSend,
  });

  final Address owner;
  final Address rootTokenContract;
  final ValueListenable<String> contractName;
  final ListenableState<Money> tokenBalance;
  final ListenableState<Money> fiatBalance;
  final ListenableState<bool> canSend;
  final ListenableState<Object> error;
  final ListenableState<bool> isLoadingError;
  final ScrollController controller;
  final VoidCallback onRetry;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).systemGestureInsets.bottom;
    final theme = context.themeStyleV2;

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              const _Background(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DefaultAppBar(),
                  ValueListenableBuilder(
                    valueListenable: contractName,
                    builder: (_, contractName, __) => Text(
                      contractName,
                      style: theme.textStyles.labelSmall.copyWith(
                        color: theme.colors.content3,
                      ),
                    ),
                  ),
                  const SizedBox(height: DimensSizeV2.d12),
                  StateNotifierBuilder(
                    listenableState: tokenBalance,
                    builder: (_, tokenBalance) {
                      if (tokenBalance == null) return const SizedBox.shrink();
                      return AmountWidget.fromMoney(
                        amount: tokenBalance,
                        includeSymbol: false,
                        style: theme.textStyles.headingXLarge,
                      );
                    },
                  ),
                  const SizedBox(height: DimensSizeV2.d4),
                  StateNotifierBuilder(
                    listenableState: fiatBalance,
                    builder: (_, fiatBalance) {
                      if (fiatBalance == null) return const SizedBox.shrink();
                      return AmountWidget.dollars(
                        amount: fiatBalance,
                        style: theme.textStyles.labelXSmall,
                      );
                    },
                  ),
                  const SizedBox(height: DimensSizeV2.d16),
                  SizedBox(
                    height: DimensSizeV2.d74,
                    child: SeparatedRow(
                      separator: VerticalDivider(
                        width: DimensStroke.small,
                        thickness: DimensStroke.small,
                        color: theme.colors.borderAlpha,
                      ),
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: DimensSizeV2.d90,
                            child: WalletActionButton(
                              label: LocaleKeys.receiveWord.tr(),
                              icon: LucideIcons.arrowDown,
                              onPressed: () =>
                                  showReceiveFundsSheet(context, owner),
                            ),
                          ),
                        ),
                        DoubleSourceBuilder(
                          firstSource: canSend,
                          secondSource: tokenBalance,
                          builder: (_, canSend, tokenBalance) {
                            if (canSend != true || tokenBalance == null) {
                              return const SizedBox.shrink();
                            }

                            return Flexible(
                              child: SizedBox(
                                width: DimensSizeV2.d90,
                                child: WalletActionButton(
                                  label: LocaleKeys.sendWord.tr(),
                                  icon: LucideIcons.arrowUp,
                                  onPressed: onSend,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: DimensSizeV2.d48),
                ],
              ),
            ],
          ),
        ),
        DecoratedSliver(
          decoration: BoxDecoration(
            color: theme.colors.background0,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(DimensRadiusV2.radius24),
            ),
          ),
          sliver: StateNotifierBuilder(
            listenableState: error,
            builder: (_, error) => SliverPadding(
              padding: EdgeInsets.only(
                top: DimensSizeV2.d16,
                bottom: bottomPadding + DimensSizeV2.d16,
                left: DimensSizeV2.d16,
                right: DimensSizeV2.d16,
              ),
              sliver: error == null
                  ? TokenWalletTransactionsWidget(
                      rootTokenContract: rootTokenContract,
                      owner: owner,
                      scrollController: controller,
                    )
                  : null,
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: DoubleSourceBuilder(
            firstSource: error,
            secondSource: isLoadingError,
            builder: (_, error, isLoadingError) => Container(
              color: theme.colors.background0,
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
              ),
              child: error?.let(
                (error) => Center(
                  child: WalletSubscribeErrorWidget(
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
