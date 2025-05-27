import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/wallet_app_bar_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NftPageWidget extends ElementaryWidget<NftPageWidgetModel> {
  const NftPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultNftPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(NftPageWidgetModel wm) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const WalletAppBarWidget(),
            StateNotifierBuilder(
              listenableState: wm.collections,
              builder: (_, collections) {
                if (collections == null || collections.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: EmptyNftList(onAddNftPressed: wm.onAddNftPressed),
                    ),
                  );
                }

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSizeV2.d16,
                    ),
                    child: Column(
                      spacing: DimensSizeV2.d12,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: DimensSizeV2.d12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: DimensSizeV2.d8,
                            children: [
                              Text(
                                LocaleKeys.nftMyCollections.tr(),
                                style: wm.theme.textStyles.headingMedium,
                              ),
                              StateNotifierBuilder(
                                listenableState: wm.displayMode,
                                builder: (_, displayMode) {
                                  return DisplayModeSwitch(
                                    mode: displayMode,
                                    onModeChanged: wm.setDisplayMode,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: NftCollectionsList(
                            displayMode: NftDisplayMode.grid,
                            collections: collections,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: DimensSizeV2.d12,
                          ),
                          child: AccentButton(
                            buttonShape: ButtonShape.pill,
                            title: LocaleKeys.addNFT.tr(),
                            onPressed: wm.onAddNftPressed,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
