import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/manage_seeds_accounts/view/manage_seeds_accounts_page_wm.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/profile/seed_detail/route.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Root widget for manage seeds and accounts feature
class ManageSeedsAccountsPage
    extends InjectedElementaryWidget<ManageSeedsAccountsPageWidgetModel> {
  const ManageSeedsAccountsPage({super.key});

  @override
  Widget build(ManageSeedsAccountsPageWidgetModel wm) {
    final theme = wm.theme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DefaultAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d12,
          horizontal: DimensSizeV2.d16,
        ),
        child: SeparatedColumn(
          spacing: DimensSizeV2.d16,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d40,
              ),
              child: Text(
                LocaleKeys.manageSeedsAndAccounts.tr(),
                style: theme.textStyles.headingLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: DoubleSourceBuilder(
                  firstSource: wm.currentSeed,
                  secondSource: wm.seeds,
                  builder: (_, current, seeds) {
                    final list = seeds ?? [];

                    return ShapedContainerColumn(
                      color: theme.colors.background1,
                      margin: EdgeInsets.zero,
                      separator: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: DimensSizeV2.d4),
                        child: CommonDivider(),
                      ),
                      titleText: LocaleKeys.seedPhrases.tr(),
                      children: [
                        for (final seed in list)
                          _SeedTitle(
                            key: ValueKey(seed.publicKey),
                            seed: seed,
                            isActive: current?.publicKey == seed.publicKey,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: DimensSizeV2.d8),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              postfixIcon: LucideIcons.plus,
              title: LocaleKeys.addSeedPhrase.tr(),
              onPressed: wm.onAddSeedPhrase,
            ),
          ],
        ),
      ),
    );
  }
}

class _SeedTitle extends StatelessWidget {
  const _SeedTitle({
    required this.seed,
    required this.isActive,
    super.key,
  });

  final Seed seed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return CommonListTile(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.compassContinue(
              SeedDetailRouteData(
                publicKey: seed.publicKey,
              ),
            );
          },
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.sparxLogoSmall.path,
            backgroundColor: theme.colors.backgroundAlpha,
            useDefaultColor: false,
          ),
          titleText: seed.name,
          subtitleText: LocaleKeys.publicKeysWithData.plural(
            seed.allKeys.length,
            args: ['${seed.allKeys.length}'],
          ),
          trailing: SeparatedRow(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isActive)
                CommonIconWidget.svg(
                  svg: Assets.images.check.path,
                  color: theme.colors.content0,
                ),
              CommonIconButton.svg(
                color: theme.colors.content0,
                svg: Assets.images.settings.path,
                buttonType: EverButtonType.ghost,
                size: CommonIconButtonSize.xsmall,
                onPressed: () => showSeedSettingsSheet(context, seed.publicKey),
              ),
            ],
          ),
        );
      },
    );
  }
}
