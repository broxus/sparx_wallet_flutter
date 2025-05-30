import 'package:app/feature/nft/nft.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NftCollectionsList extends StatelessWidget {
  const NftCollectionsList({
    required this.collections,
    required this.displayMode,
    required this.onNftCollectionPressed,
    super.key,
  });

  final List<NftCollection> collections;
  final NftDisplayMode displayMode;
  final ValueChanged<NftCollection> onNftCollectionPressed;

  @override
  Widget build(BuildContext context) {
    return switch (displayMode) {
      NftDisplayMode.grid => _buildGridView(context),
      NftDisplayMode.list => _buildListView(context),
    };
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: DimensSizeV2.d8,
      crossAxisSpacing: DimensSizeV2.d8,
      childAspectRatio: 168 / 196,
      children: [
        for (final collection in collections)
          _Item(
            key: ValueKey(collection.address),
            displayMode: displayMode,
            collection: collection,
            onTap: () => onNftCollectionPressed(collection),
          ),
      ],
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.separated(
      itemCount: collections.length,
      separatorBuilder: (_, index) => const SizedBox(height: DimensSizeV2.d8),
      itemBuilder: (_, index) {
        final collection = collections[index];
        return _Item(
          key: ValueKey(collection.address),
          displayMode: displayMode,
          collection: collection,
          onTap: () => onNftCollectionPressed(collection),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.displayMode,
    required this.collection,
    required this.onTap,
    super.key,
  });

  final NftDisplayMode displayMode;
  final NftCollection collection;
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
      child: PrimaryCard(
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
                child: NftImage(imageUrl: collection.imageUrl),
              ),
            ),
            Text(
              collection.name,
              style: theme.textStyles.labelMedium,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            ),
          ],
        ),
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
                child: NftImage(imageUrl: collection.imageUrl),
              ),
            ),
            Expanded(
              child: Text(
                collection.name,
                style: theme.textStyles.labelMedium,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
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
