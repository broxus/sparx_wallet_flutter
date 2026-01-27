import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/wallet_app_bar_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NftPageWidget extends InjectedElementaryWidget<NftPageWidgetModel> {
  const NftPageWidget({super.key});

  @override
  Widget build(NftPageWidgetModel wm) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const WalletAppBarWidget(),
            Expanded(
              child: DoubleSourceBuilder(
                firstSource: wm.loadingState,
                secondSource: wm.collectionsState,
                builder: (_, isLoading, collections) {
                  if (isLoading ?? false) {
                    return const Center(
                      child: ProgressIndicatorWidget(size: DimensSize.d32),
                    );
                  }

                  if (collections == null || collections.isEmpty) {
                    return Center(
                      child: EmptyNftList(
                        marketplaceUrlState: wm.marketplaceUrlState,
                        onAddNftPressed: wm.onAddNftPressed,
                        onMarketplaceUrlPressed: wm.onMarketplaceUrlPressed,
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSize.d16,
                    ),
                    child: Column(
                      spacing: DimensSize.d12,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: DimensSize.d12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: DimensSize.d8,
                            children: [
                              Text(
                                LocaleKeys.nftMyCollections.tr(),
                                style: wm.theme.textStyles.headingMedium,
                              ),
                              DisplayModeSwitch(
                                displayModeState: wm.displayModeState,
                                onModeChanged: wm.setDisplayMode,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: NftCollectionsList(
                            displayModeState: wm.displayModeState,
                            pendingState: wm.pendingState,
                            collections: collections,
                            onNftCollectionPressed: wm.onNftCollectionPressed,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: DimensSize.d12,
                          ),
                          child: AccentButton(
                            buttonShape: ButtonShape.pill,
                            title: LocaleKeys.addNFT.tr(),
                            onPressed: wm.onAddNftPressed,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
