import 'package:app/feature/nft/nft.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show Address;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NftCollectionPageWidget
    extends ElementaryWidget<NftCollectionPageWidgetModel> {
  const NftCollectionPageWidget({
    required this.collection,
    Key? key,
    WidgetModelFactory wmFactory = defaultNftCollectionPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Address collection;

  @override
  Widget build(NftCollectionPageWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.collection,
      builder: (_, collection) {
        if (collection == null) return const SizedBox.shrink();

        return Scaffold(
          appBar: DefaultAppBar(
            actions: [
              FloatButton(
                buttonShape: ButtonShape.circle,
                icon: LucideIcons.cog,
                buttonSize: ButtonSize.medium,
                title: collection.name,
                onPressed: wm.onSettings,
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DimensSizeV2.d12,
                children: [
                  if (collection.description != null)
                    ExpandableText(
                      text: collection.description!,
                      expandText: LocaleKeys.showMore.tr(),
                      textStyle: wm.theme.textStyles.paragraphMedium.copyWith(
                        color: wm.theme.colors.content1,
                      ),
                      expandTextStyle: wm.theme.textStyles.labelMedium.copyWith(
                        color: wm.theme.colors.content0,
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: DimensSizeV2.d8,
                    children: [
                      Text(
                        LocaleKeys.nftMyNfts.tr(),
                        style: wm.theme.textStyles.headingMedium,
                      ),
                      StateNotifierBuilder(
                        listenableState: wm.displayMode,
                        builder: (_, displayMode) {
                          return DisplayModeSwitch(
                            mode: displayMode ?? NftDisplayMode.grid,
                            onModeChanged: wm.setDisplayMode,
                          );
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: StateNotifierBuilder(
                      listenableState: wm.displayMode,
                      builder: (_, displayMode) {
                        return Nftist(
                          controller: wm.controller,
                          displayMode: displayMode ?? NftDisplayMode.grid,
                          pending: wm.pending,
                          onNftPressed: wm.onNftPressed,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
