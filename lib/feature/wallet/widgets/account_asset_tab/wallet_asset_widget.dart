import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Default widget that displays information about Ton/Token wallet and allows
/// interacting with it.
class WalletAssetWidget extends StatelessWidget {
  const WalletAssetWidget({
    required this.name,
    required this.tokenBalance,
    required this.fiatBalance,
    required this.icon,
    required this.error,
    required this.isRetryLoading,
    required this.onPressed,
    this.onRetryPressed,
    super.key,
  });

  /// Token name
  final String name;

  final Widget icon;

  /// Balance of token
  final ListenableState<Money> tokenBalance;

  /// Balance of token in real-world currency
  final ListenableState<Money> fiatBalance;

  /// The error that happened during wallet subscription
  final ListenableState<Object> error;

  /// If [onRetryPressed] was called and retry action in progress
  final ListenableState<bool> isRetryLoading;

  /// Callback that helps retry subscribe process
  final VoidCallback? onRetryPressed;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: SeparatedRow(
        spacing: DimensSizeV2.d12,
        children: [
          const SizedBox(width: DimensSizeV2.d4),
          icon,
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StateNotifierBuilder(
                  listenableState: tokenBalance,
                  builder: (_, tokenBalance) {
                    if (tokenBalance == null) {
                      return ProgressIndicatorWidget(
                        size: DimensSizeV2.d18,
                        color: theme.colors.content3,
                      );
                    }
                    return AmountWidget.fromMoney(
                      amount: tokenBalance,
                      includeSymbol: false,
                      style: theme.textStyles.labelSmall,
                    );
                  },
                ),
                Text(
                  name,
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: StateNotifierBuilder(
              listenableState: fiatBalance,
              builder: (_, fiatBalance) {
                if (fiatBalance == null) {
                  return Center(
                    child: ProgressIndicatorWidget(
                      size: DimensSizeV2.d16,
                      color: theme.colors.content0,
                    ),
                  );
                }

                return AmountWidget.dollars(
                  mainAxisAlignment: MainAxisAlignment.end,
                  amount: fiatBalance,
                  style: theme.textStyles.headingXSmall,
                );
              },
            ),
          ),
          DoubleSourceBuilder(
            firstSource: error,
            secondSource: isRetryLoading,
            builder: (_, error, isRetryLoading) {
              if (error == null || onRetryPressed == null) {
                return const SizedBox.shrink();
              }

              return GhostButton(
                buttonShape: ButtonShape.circle,
                buttonSize: ButtonSize.small,
                icon: LucideIcons.refreshCw,
                isLoading: isRetryLoading ?? false,
                onPressed: onRetryPressed,
              );
            },
          ),
          const SizedBox(width: DimensSizeV2.d4),
        ],
      ),
    );
  }
}
