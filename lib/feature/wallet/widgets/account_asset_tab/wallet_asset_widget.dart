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
    required this.onPressed,
    this.isRetryLoading = false,
    this.onRetryPressed,
    this.error,
    super.key,
  });

  /// Token name
  final String name;

  /// Balance of token
  final Money? tokenBalance;

  /// Balance of token in real-world currency
  final Money? fiatBalance;

  final Widget icon;
  final VoidCallback onPressed;

  /// The error that happened during wallet subscription
  final Object? error;

  /// Callback that helps retry subscribe process
  final ValueChanged<BuildContext>? onRetryPressed;

  /// If [onRetryPressed] was called and retry action in progress
  final bool isRetryLoading;

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
                if (tokenBalance == null)
                  ProgressIndicatorWidget(
                    size: DimensSizeV2.d18,
                    color: theme.colors.content3,
                  )
                else
                  AmountWidget.fromMoney(
                    amount: tokenBalance!,
                    includeSymbol: false,
                    style: theme.textStyles.labelSmall,
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
            child: fiatBalance == null
                ? Center(
                    child: ProgressIndicatorWidget(
                      size: DimensSizeV2.d16,
                      color: theme.colors.content0,
                    ),
                  )
                : AmountWidget.dollars(
                    mainAxisAlignment: MainAxisAlignment.end,
                    amount: fiatBalance!,
                    style: theme.textStyles.headingXSmall,
                  ),
          ),
          if (error != null && onRetryPressed != null)
            GhostButton(
              buttonShape: ButtonShape.circle,
              buttonSize: ButtonSize.small,
              icon: LucideIcons.refreshCw,
              isLoading: isRetryLoading,
              onPressed: () => onRetryPressed!(context),
            ),
          const SizedBox(width: DimensSizeV2.d4),
        ],
      ),
    );
  }
}
