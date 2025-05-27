import 'package:app/feature/nft/nft.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

final _placeholder = Image.asset(
  Assets.images.nftPlaceholder.nftPlaceholder.path,
  fit: BoxFit.cover,
);

class NftCollectionsList extends StatelessWidget {
  const NftCollectionsList({
    required this.collections,
    required this.displayMode,
    super.key,
  });

  final List<NftCollection> collections;
  final NftDisplayMode displayMode;

  @override
  Widget build(BuildContext context) {
    // TODO: list view
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: DimensSizeV2.d8,
      crossAxisSpacing: DimensSizeV2.d8,
      childAspectRatio: 168 / 196,
      children: [
        for (final collection in collections)
          _Item(
            collection: collection,
            onTap: () {},
          ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.collection,
    required this.onTap,
  });

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
        borderRadius: BorderRadius.circular(
          DimensRadiusV2.radius12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DimensSizeV2.d8,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  DimensRadiusV2.radius8,
                ),
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: collection.imageUrl?.let(
                      (url) => CachedNetworkImage(
                        imageUrl: url,
                        placeholder: (_, __) => _placeholder,
                        errorWidget: (_, __, ___) => _placeholder,
                      ),
                    ) ??
                    _placeholder,
              ),
            ),
            Text(
              collection.name,
              style: theme.textStyles.labelSmall,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
