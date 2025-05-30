import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

void showNftCollectionSettionsSheet({
  required BuildContext context,
  required VoidCallback onViewInExplorer,
  required VoidCallback onHideCollection,
}) {
  showCommonBottomSheet<void>(
    context: context,
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    body: (_, __) => _NftCollectionSettingsSheet(
      onViewInExplorer: onViewInExplorer,
      onHideCollection: onHideCollection,
    ),
  );
}

class _NftCollectionSettingsSheet extends StatelessWidget {
  const _NftCollectionSettingsSheet({
    required this.onViewInExplorer,
    required this.onHideCollection,
  });

  final VoidCallback onViewInExplorer;
  final VoidCallback onHideCollection;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return ShapedContainerColumn(
      color: theme.colors.background2,
      margin: EdgeInsets.zero,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      children: [
        CommonListTile(
          titleText: LocaleKeys.nftViewInExplorer.tr(),
          trailing: Icon(
            LucideIcons.globe,
            size: DimensSizeV2.d20,
            color: theme.colors.content0,
          ),
          onPressed: onViewInExplorer,
        ),
        CommonListTile(
          titleText: LocaleKeys.nftHideCollection.tr(),
          trailing: Icon(
            LucideIcons.eyeOff,
            size: DimensSizeV2.d20,
            color: theme.colors.negative,
          ),
          contentColor: theme.colors.negative,
          onPressed: onHideCollection,
        ),
      ],
    );
  }
}
