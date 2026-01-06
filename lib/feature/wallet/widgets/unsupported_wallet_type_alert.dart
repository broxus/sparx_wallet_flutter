import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class UnsupportedWalletTypeAlert extends StatelessWidget {
  const UnsupportedWalletTypeAlert({required this.onSwitchAccount, super.key});

  final VoidCallback onSwitchAccount;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Container(
      height: DimensSize.d124,
      padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
      decoration: BoxDecoration(
        color: ColorsResV2.e15,
        borderRadius: BorderRadius.circular(DimensRadius.radius16),
      ),
      child: Row(
        spacing: DimensSize.d14,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.unsupportedWalletTypeAlertTitle.tr(),
                  style: theme.textStyles.headingXSmall,
                ),
                Text(
                  LocaleKeys.unsupportedWalletTypeAlertDescription.tr(),
                  style: theme.textStyles.paragraphXSmall.copyWith(
                    color: ColorsResV2.n80.withAlpha(128),
                  ),
                ),
                const SizedBox(height: DimensSize.d8),
                TransparentButton(
                  isFullWidth: false,
                  title: LocaleKeys.unsupportedWalletTypeAlertButtonLabel.tr(),
                  buttonShape: ButtonShape.pill,
                  buttonSize: ButtonSize.small,
                  onPressed: onSwitchAccount,
                ),
              ],
            ),
          ),
          const _AlertIconBlock(),
        ],
      ),
    );
  }
}

class _AlertIconBlock extends StatelessWidget {
  const _AlertIconBlock();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final color = theme.colors.borderNegative.withAlpha(51);

    return Container(
      width: DimensSize.d92,
      height: DimensSize.d92,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(DimensSize.d7),
        child: Container(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(DimensSize.d7),
            child: Container(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  LucideIcons.triangleAlert,
                  color: theme.colors.borderNegative,
                  size: DimensSize.d38,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
