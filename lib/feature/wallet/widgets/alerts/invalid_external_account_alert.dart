import 'package:app/feature/wallet/widgets/alerts/alert_icon_block.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class InvalidExternalAccountAlert extends StatelessWidget {
  const InvalidExternalAccountAlert({required this.onSwitchAccount, super.key});

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
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Text(
                  LocaleKeys.invalidExternalAccountAlertTitle.tr(),
                  style: theme.textStyles.headingXSmall,
                ),
                Text(
                  LocaleKeys.invalidExternalAccountAlertDescription.tr(),
                  style: theme.textStyles.paragraphXSmall.copyWith(
                    color: ColorsResV2.n80.withAlpha(128),
                  ),
                ),
              ],
            ),
          ),
          const AlertIconBlock(),
        ],
      ),
    );
  }
}
