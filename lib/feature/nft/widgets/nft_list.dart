import 'package:app/feature/nft/nft.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _indicator = Center(
  child: ProgressIndicatorWidget(
    size: DimensSizeV2.d24,
  ),
);

class Nftist extends StatelessWidget {
  const Nftist({
    required this.controller,
    required this.displayMode,
    required this.pending,
    required this.onNftPressed,
    super.key,
  });

  final PagingController<String, NftItem> controller;
  final NftDisplayMode displayMode;
  final Set<String> pending;
  final ValueChanged<NftItem> onNftPressed;

  @override
  Widget build(BuildContext context) {
    return PagingListener<String, NftItem>(
      controller: controller,
      builder: switch (displayMode) {
        NftDisplayMode.grid => _gridViewBuilder,
        NftDisplayMode.list => _listViewBuilder,
      },
    );
  }

  Widget _gridViewBuilder(
    BuildContext context,
    PagingState<String, NftItem> state,
    VoidCallback fetchNextPage,
  ) {
    return PagedGridView<String, NftItem>(
      state: state,
      fetchNextPage: fetchNextPage,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: DimensSizeV2.d8,
        crossAxisSpacing: DimensSizeV2.d8,
        childAspectRatio: 168 / 196,
      ),
      builderDelegate: PagedChildBuilderDelegate(
        invisibleItemsThreshold: 1,
        firstPageProgressIndicatorBuilder: (_) => _indicator,
        newPageProgressIndicatorBuilder: (_) => _indicator,
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget _listViewBuilder(
    BuildContext context,
    PagingState<String, NftItem> state,
    VoidCallback fetchNextPage,
  ) {
    return PagedListView<String, NftItem>.separated(
      state: state,
      fetchNextPage: fetchNextPage,
      separatorBuilder: (_, index) => const SizedBox(height: DimensSizeV2.d8),
      builderDelegate: PagedChildBuilderDelegate(
        invisibleItemsThreshold: 1,
        firstPageProgressIndicatorBuilder: (_) => _indicator,
        newPageProgressIndicatorBuilder: (_) => _indicator,
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget _itemBuilder(BuildContext _, NftItem item, int __) => _Item(
        key: ValueKey(item.nft.address),
        item: item,
        displayMode: displayMode,
        isPending: pending.contains(item.nft.id),
        onTap: () => onNftPressed(item),
      );
}

class _Item extends StatelessWidget {
  const _Item({
    required this.displayMode,
    required this.item,
    required this.isPending,
    required this.onTap,
    super.key,
  });

  final NftDisplayMode displayMode;
  final NftItem item;
  final bool isPending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return switch (displayMode) {
      NftDisplayMode.grid => _buildGridItem(context),
      NftDisplayMode.list => _buildListItem(context),
    };
  }

  Widget _buildGridItem(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          PrimaryCard(
            padding: const EdgeInsets.all(DimensSizeV2.d8),
            color: theme.colors.background1,
            borderRadius: BorderRadius.circular(
              DimensRadiusV2.radius12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DimensSizeV2.d8,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: NftImage(imageUrl: item.nft.previewUrl),
                  ),
                ),
                Text(
                  item.nft.name ?? LocaleKeys.unknown.tr(),
                  style: theme.textStyles.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          if (item.wallet != null || isPending)
            Positioned(
              top: DimensSizeV2.d0,
              left: DimensSizeV2.d0,
              right: DimensSizeV2.d0,
              child: Align(
                alignment: Alignment.centerRight,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: Padding(
                    padding: const EdgeInsets.all(DimensSizeV2.d14),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: DimensSizeV2.d4,
                      children: [
                        if (item.wallet != null)
                          Flexible(
                            child: _Badge(
                              balance: item.wallet!.balance,
                              supply: item.nft.supply ?? BigInt.zero,
                            ),
                          ),
                        if (isPending)
                          Container(
                            width: DimensSizeV2.d10,
                            height: DimensSizeV2.d10,
                            decoration: BoxDecoration(
                              color: theme.colors.backgroundAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onTap,
      child: PrimaryCard(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d16,
          vertical: DimensSizeV2.d8,
        ),
        color: theme.colors.background1,
        borderRadius: BorderRadius.circular(
          DimensRadiusV2.radius12,
        ),
        child: Row(
          spacing: DimensSizeV2.d8,
          children: [
            SizedBox(
              width: DimensSizeV2.d40,
              height: DimensSizeV2.d40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DimensRadiusV2.radius20),
                child: NftImage(imageUrl: item.nft.previewUrl),
              ),
            ),
            Expanded(
              child: Text(
                item.nft.name ?? LocaleKeys.unknown.tr(),
                style: theme.textStyles.labelMedium,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
            ),
            if (item.wallet != null)
              _Badge(
                balance: item.wallet!.balance,
                supply: item.nft.supply ?? BigInt.zero,
              ),
            if (isPending)
              Container(
                width: DimensSizeV2.d10,
                height: DimensSizeV2.d10,
                decoration: BoxDecoration(
                  color: theme.colors.backgroundAccent,
                  shape: BoxShape.circle,
                ),
              ),
            Icon(
              LucideIcons.chevronRight,
              size: DimensSizeV2.d20,
              color: theme.colors.primaryA,
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.balance,
    required this.supply,
  });

  final BigInt balance;
  final BigInt supply;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d4,
        vertical: DimensSizeV2.d2,
      ),
      color: theme.colors.background2,
      borderRadius: BorderRadius.circular(
        DimensRadiusV2.radius6,
      ),
      child: Text(
        '$balance/$supply',
        style: theme.textStyles.labelXSmall,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        maxLines: 1,
      ),
    );
  }
}
