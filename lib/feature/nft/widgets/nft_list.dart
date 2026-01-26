import 'package:app/feature/nft/nft.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
        mainAxisSpacing: DimensSize.d8,
        crossAxisSpacing: DimensSize.d8,
        childAspectRatio: 168 / 196,
      ),
      builderDelegate: PagedChildBuilderDelegate(
        invisibleItemsThreshold: 1,
        firstPageProgressIndicatorBuilder: (_) => const _Indicator(),
        newPageProgressIndicatorBuilder: (_) => const _Indicator(),
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
      separatorBuilder: (_, index) => const SizedBox(height: DimensSize.d8),
      builderDelegate: PagedChildBuilderDelegate(
        invisibleItemsThreshold: 1,
        firstPageProgressIndicatorBuilder: (_) => const _Indicator(),
        newPageProgressIndicatorBuilder: (_) => const _Indicator(),
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

  String? get _previewUrl =>
      item.nft.previewUrl ?? item.nft.json.preview?.source;

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
            padding: const EdgeInsets.all(DimensSize.d8),
            color: theme.colors.background1,
            borderRadius: BorderRadius.circular(DimensRadius.radius12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DimensSize.d8,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(DimensRadius.radius8),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: NftImage(imageUrl: _previewUrl),
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
              top: DimensSize.d0,
              left: DimensSize.d0,
              right: DimensSize.d0,
              child: Align(
                alignment: Alignment.centerRight,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: Padding(
                    padding: const EdgeInsets.all(DimensSize.d14),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: DimensSize.d4,
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
                            width: DimensSize.d10,
                            height: DimensSize.d10,
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
          horizontal: DimensSize.d16,
          vertical: DimensSize.d8,
        ),
        color: theme.colors.background1,
        borderRadius: BorderRadius.circular(DimensRadius.radius12),
        child: Row(
          spacing: DimensSize.d8,
          children: [
            SizedBox(
              width: DimensSize.d40,
              height: DimensSize.d40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DimensRadius.radius20),
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
                width: DimensSize.d10,
                height: DimensSize.d10,
                decoration: BoxDecoration(
                  color: theme.colors.backgroundAccent,
                  shape: BoxShape.circle,
                ),
              ),
            Icon(
              LucideIcons.chevronRight,
              size: DimensSize.d20,
              color: theme.colors.primaryA,
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.balance, required this.supply});

  final BigInt balance;
  final BigInt supply;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSize.d4,
        vertical: DimensSize.d2,
      ),
      color: theme.colors.background2,
      borderRadius: BorderRadius.circular(DimensRadius.radius6),
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

class _Indicator extends StatelessWidget {
  const _Indicator();

  @override
  Widget build(BuildContext context) {
    return const Center(child: ProgressIndicatorWidget(size: DimensSize.d24));
  }
}
