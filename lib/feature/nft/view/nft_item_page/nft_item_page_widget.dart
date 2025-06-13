import 'package:app/feature/nft/nft.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NftItemPageWidget extends ElementaryWidget<NftItemPageWidgetModel> {
  const NftItemPageWidget({
    required this.address,
    required this.collection,
    Key? key,
    WidgetModelFactory wmFactory = defaultNftItemPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Address address;
  final Address collection;

  @override
  Widget build(NftItemPageWidgetModel wm) {
    return DoubleSourceBuilder(
      firstSource: wm.item,
      secondSource: wm.collection,
      builder: (_, item, collection) {
        if (item == null) return const SizedBox.shrink();

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: DefaultAppBar(
            backgroundColor: Colors.transparent,
            leading: PrimaryButton(
              buttonShape: ButtonShape.circle,
              icon: LucideIcons.arrowLeft,
              buttonSize: ButtonSize.medium,
              onPressed: wm.onBackPressed,
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: wm.topOffset),
              ClipRRect(
                borderRadius: BorderRadius.circular(DimensRadiusV2.radius20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                    onTap: item.nft.imageUrl?.let((_) => wm.openImageView),
                    child: Hero(
                      tag: NftItemImageView.tag,
                      child: NftImage(imageUrl: item.nft.imageUrl),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: DimensSizeV2.d16),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSizeV2.d16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.nft.name ?? LocaleKeys.unknown.tr(),
                          style: wm.theme.textStyles.headingLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: DimensSizeV2.d4),
                        Text(
                          collection?.name ?? '',
                          style: wm.theme.textStyles.labelSmall.copyWith(
                            color: wm.theme.colors.content1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (item.nft.description != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: DimensSizeV2.d8,
                            ),
                            child: Text(
                              item.nft.description!,
                              style: wm.theme.textStyles.paragraphMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const SizedBox(height: DimensSizeV2.d16),
                        _Info(
                          item: item,
                          onViewInExplorer: wm.onViewInExplorer,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSizeV2.d16,
                  vertical: DimensSizeV2.d12,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.wallet != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
                        child: AccentButton(
                          buttonShape: ButtonShape.pill,
                          title: LocaleKeys.transferTokens.tr(),
                          onPressed: wm.onTransferTokens,
                        ),
                      ),
                    StateNotifierBuilder(
                      listenableState: wm.currentAccount,
                      builder: (_, account) {
                        // cant transfer if not owner
                        if (account == null ||
                            item.nft.owner != account.address) {
                          return const SizedBox.shrink();
                        }

                        return AccentButton(
                          buttonShape: ButtonShape.pill,
                          title: LocaleKeys.transfer.tr(),
                          onPressed:
                              item.nft.canTransfer ? wm.onTransferNft : null,
                        );
                      },
                    ),
                    StateNotifierBuilder(
                      listenableState: wm.marketplaceUrl,
                      builder: (_, marketplaceUrl) {
                        if (marketplaceUrl == null) {
                          return const SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: DimensSizeV2.d8),
                          child: AccentButton(
                            buttonShape: ButtonShape.pill,
                            title: LocaleKeys.openInMarketplace.tr(),
                            onPressed: wm.onOpenInMarketplace,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: DimensSize.d16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    required this.item,
    required this.onViewInExplorer,
  });

  final NftItem item;
  final ValueChanged<Address> onViewInExplorer;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final labelStyle = theme.textStyles.labelMedium.copyWith(
      color: theme.colors.content3,
    );
    final textStyle = theme.textStyles.labelMedium;
    const padding = EdgeInsets.symmetric(
      vertical: DimensSizeV2.d12,
      horizontal: DimensSizeV2.d16,
    );

    return ShapedContainerColumn(
      color: theme.colors.background1,
      spacing: DimensSizeV2.d0,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      children: [
        if (item.wallet != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: padding,
                child: Row(
                  spacing: DimensSizeV2.d8,
                  children: [
                    Text(LocaleKeys.balanceWord.tr(), style: labelStyle),
                    Expanded(
                      child: Text(
                        '${item.wallet!.balance}/${item.nft.supply ?? '0'}',
                        style: textStyle,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const CommonDivider(),
            ],
          ),
        Padding(
          padding: padding,
          child: Row(
            spacing: DimensSizeV2.d4,
            children: [
              Text(LocaleKeys.contract.tr(), style: labelStyle),
              const Spacer(),
              GestureDetector(
                onTap: () => onViewInExplorer(item.nft.address),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: DimensSizeV2.d8,
                  children: [
                    Text(item.nft.address.toEllipseString(), style: textStyle),
                    Icon(
                      LucideIcons.arrowUpRight,
                      size: DimensSizeV2.d20,
                      color: theme.colors.content0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const CommonDivider(),
        Padding(
          padding: padding,
          child: Row(
            children: [
              Text(LocaleKeys.owner.tr(), style: labelStyle),
              const Spacer(),
              GestureDetector(
                onTap: () => onViewInExplorer(item.nft.owner),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: DimensSizeV2.d8,
                  children: [
                    Text(item.nft.owner.toEllipseString(), style: textStyle),
                    Icon(
                      LucideIcons.arrowUpRight,
                      size: DimensSizeV2.d20,
                      color: theme.colors.content0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const CommonDivider(),
        Padding(
          padding: padding,
          child: Row(
            children: [
              Text(LocaleKeys.manager.tr(), style: labelStyle),
              const Spacer(),
              GestureDetector(
                onTap: () => onViewInExplorer(item.nft.manager),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: DimensSizeV2.d8,
                  children: [
                    Text(item.nft.manager.toEllipseString(), style: textStyle),
                    Icon(
                      LucideIcons.arrowUpRight,
                      size: DimensSizeV2.d20,
                      color: theme.colors.content0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
