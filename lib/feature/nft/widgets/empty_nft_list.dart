import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EmptyNftList extends StatelessWidget {
  const EmptyNftList({
    required this.marketplaceUrlState,
    required this.onAddNftPressed,
    required this.onMarketplaceUrlPressed,
    super.key,
  });

  final ListenableState<String?> marketplaceUrlState;
  final VoidCallback onAddNftPressed;
  final ValueChanged<String> onMarketplaceUrlPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d48),
          child: Assets.images.nftEmptyList.image(),
        ),
        const SizedBox(height: DimensSize.d8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: DimensSize.d8,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSize.d16,
                ),
                child: Text(
                  LocaleKeys.nftEmptyListTitle.tr(),
                  style: theme.textStyles.headingXLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSize.d16,
                ),
                child: StateNotifierBuilder(
                  listenableState: marketplaceUrlState,
                  builder: (_, marketplaceUrl) {
                    return Text(
                      (marketplaceUrl?.isNotEmpty ?? false)
                          ? LocaleKeys.nftEmptyListSubtitle.tr()
                          : LocaleKeys.nftEmptyListSubtitleNoMarket.tr(),
                      style: theme.textStyles.paragraphSmall.copyWith(
                        color: theme.colors.content1,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
              StateNotifierBuilder(
                listenableState: marketplaceUrlState,
                builder: (_, marketplaceUrl) {
                  if (marketplaceUrl != null && marketplaceUrl.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: DimensSize.d16),
                      child: AccentButton(
                        buttonShape: ButtonShape.pill,
                        onPressed: () {
                          onMarketplaceUrlPressed(marketplaceUrl);
                        },
                        title: LocaleKeys.visitMarketplace.tr(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),

              PrimaryButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.addNFT.tr(),
                onPressed: onAddNftPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
