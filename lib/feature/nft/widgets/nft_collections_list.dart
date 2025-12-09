import 'package:app/feature/nft/nft.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _aspectRatio = 168 / 196;

class NftCollectionsList extends StatelessWidget {
  const NftCollectionsList({
    required this.collections,
    required this.displayModeState,
    required this.pendingState,
    required this.onNftCollectionPressed,
    super.key,
  });

  final ListenableState<NftDisplayMode?> displayModeState;
  final ListenableState<Map<Address, List<PendingNft>>> pendingState;
  final List<NftCollection> collections;
  final ValueChanged<NftCollection> onNftCollectionPressed;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: displayModeState,
      builder: (_, displayMode) => switch (displayMode) {
        NftDisplayMode.grid || null => GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: DimensSizeV2.d8,
          crossAxisSpacing: DimensSizeV2.d8,
          childAspectRatio: _aspectRatio,
          children: [
            for (final collection in collections)
              _GridItem(
                key: ValueKey(collection.address),
                collection: collection,
                pendingState: pendingState,
                onTap: () => onNftCollectionPressed(collection),
              ),
          ],
        ),
        NftDisplayMode.list => ListView.separated(
          itemCount: collections.length,
          separatorBuilder: (_, index) =>
              const SizedBox(height: DimensSizeV2.d8),
          itemBuilder: (_, index) {
            final collection = collections[index];
            return _ListItem(
              key: ValueKey(collection.address),
              collection: collection,

              pendingState: pendingState,
              onTap: () => onNftCollectionPressed(collection),
            );
          },
        ),
      },
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({
    required this.pendingState,
    required this.collection,
    required this.onTap,
    super.key,
  });

  final ListenableState<Map<Address, List<PendingNft>>> pendingState;

  final NftCollection collection;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onTap,
      child: PrimaryCard(
        padding: const EdgeInsets.all(DimensSizeV2.d8),
        color: theme.colors.background1,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DimensSizeV2.d8,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: NftImage(imageUrl: collection.imageUrl),
                  ),
                ),
                Text(
                  collection.name ?? LocaleKeys.unknown.tr(),
                  style: theme.textStyles.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                ),
              ],
            ),
            StateNotifierBuilder(
              listenableState: pendingState,
              builder: (_, pending) {
                final count = pending?[collection.address]?.length ?? 0;

                if (count <= 0) {
                  return const SizedBox.shrink();
                }

                return Positioned(
                  top: DimensSizeV2.d6,
                  right: DimensSizeV2.d6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      DimensRadiusV2.radius10,
                    ),
                    child: Container(
                      width: DimensSizeV2.d20,
                      height: DimensSizeV2.d20,
                      color: theme.colors.backgroundAccent,
                      child: Center(
                        child: Text(
                          count.toString(),
                          style: theme.textStyles.labelXSmall,
                        ),
                      ),
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

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.pendingState,
    required this.collection,
    required this.onTap,
    super.key,
  });

  final ListenableState<Map<Address, List<PendingNft>>> pendingState;

  final NftCollection collection;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onTap,
      child: PrimaryCard(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d16,
          vertical: DimensSizeV2.d8,
        ),
        color: theme.colors.background1,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
        child: Row(
          spacing: DimensSizeV2.d8,
          children: [
            SizedBox(
              width: DimensSizeV2.d40,
              height: DimensSizeV2.d40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DimensRadiusV2.radius20),
                child: NftImage(imageUrl: collection.imageUrl),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: DimensSizeV2.d4,
                children: [
                  Text(
                    collection.name ?? LocaleKeys.unknown.tr(),
                    style: theme.textStyles.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                  StateNotifierBuilder(
                    listenableState: pendingState,
                    builder: (_, pending) {
                      final count = pending?[collection.address]?.length ?? 0;

                      if (count <= 0) {
                        return const SizedBox.shrink();
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(
                          DimensRadiusV2.radius10,
                        ),
                        child: Container(
                          width: DimensSizeV2.d20,
                          height: DimensSizeV2.d20,
                          color: theme.colors.backgroundAccent,
                          child: Center(
                            child: Text(
                              count.toString(),
                              style: theme.textStyles.labelXSmall,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
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
