import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class UnsupportedWalletTypeAlert extends StatelessWidget {
  const UnsupportedWalletTypeAlert({
    required this.onSwitchAccount,
    super.key,
  });

  final VoidCallback onSwitchAccount;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Container(
      height: DimensSizeV2.d124,
      padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
      decoration: BoxDecoration(
        color: ColorsResV2.e15,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      ),
      child: Row(
        spacing: DimensSizeV2.d14,
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
                const SizedBox(height: DimensSizeV2.d8),
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
      width: DimensSizeV2.d92,
      height: DimensSizeV2.d92,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d7),
        child: Container(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(DimensSizeV2.d7),
            child: Container(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  LucideIcons.triangleAlert,
                  color: theme.colors.borderNegative,
                  size: DimensSizeV2.d38,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
