import 'package:app/app/router/app_route.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class EmptyNftList extends StatelessWidget {
  const EmptyNftList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d48),
          child: Assets.images.nftEmptyList.image(),
        ),
        const SizedBox(height: DimensSizeV2.d8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSizeV2.d16,
                ),
                child: Text(
                  LocaleKeys.nftEmptyListTitle.tr(),
                  style: theme.textStyles.headingXLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: DimensSizeV2.d8),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSizeV2.d16,
                ),
                child: Text(
                  LocaleKeys.nftEmptyListSubtitle.tr(),
                  style: theme.textStyles.paragraphSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: DimensSizeV2.d24),
              AccentButton(
                buttonShape: ButtonShape.pill,
                onPressed: () {},
                title: LocaleKeys.visitMarketplace.tr(),
              ),
              const SizedBox(height: DimensSizeV2.d8),
              PrimaryButton(
                buttonShape: ButtonShape.pill,
                onPressed: () {
                  context.goFurther(AppRoute.addNft.path);
                },
                title: LocaleKeys.addNFT.tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
