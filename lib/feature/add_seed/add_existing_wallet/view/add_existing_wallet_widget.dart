import 'package:app/feature/add_seed/add_seed.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddExistingWalletWidget
    extends ElementaryWidget<AddExistingWalletWidgetModel> {
  const AddExistingWalletWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultAddExistingWalletWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(AddExistingWalletWidgetModel wm) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          children: [
            const Spacer(),
            Text(
              LocaleKeys.addExistingWalletTitle.tr(),
              style: wm.theme.textStyles.headingLarge,
            ),
            const SizedBox(height: DimensSizeV2.d8),
            PrimaryText(LocaleKeys.addExistingWalletSubtitle.tr()),
            const Spacer(),
            _Button(
              icon: LucideIcons.keyRound,
              title: LocaleKeys.importWalletButtonTitle.tr(),
              subtitle: LocaleKeys.importWalletButtonSubtitle.tr(),
              onPressed: wm.onImport,
            ),
            const SizedBox(height: DimensSizeV2.d12),
            _Button(
              icon: LucideIcons.bluetooth,
              title: LocaleKeys.pairLedgerButtonTitle.tr(),
              subtitle: LocaleKeys.pairLedgerButtonSubtitle.tr(),
              onPressed: wm.onLedger,
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onPressed,
      child: PrimaryCard(
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        padding: const EdgeInsets.all(DimensSizeV2.d16),
        child: Row(
          spacing: DimensSizeV2.d8,
          children: [
            CommonBackgroundedIconWidget.icon(
              icon: icon,
              iconColor: theme.colors.content0,
              backgroundColor: theme.colors.background3,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DimensSizeV2.d4,
                children: [
                  Text(title, style: theme.textStyles.button),
                  Text(
                    subtitle,
                    style: theme.textStyles.labelXSmall.copyWith(
                      color: ColorsRes.grey898989,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: DimensSizeV2.d20,
              color: context.themeStyleV2.colors.primaryA,
            ),
          ],
        ),
      ),
    );
  }
}
