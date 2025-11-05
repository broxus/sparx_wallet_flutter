import 'package:app/feature/browser_v2/widgets/favicon_view/favicon_view.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class HistoryTip extends StatelessWidget {
  const HistoryTip({required this.title, required this.onPressed, super.key});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return _Body(
      backgroundColor: theme.colors.background2,
      borderRadius: BorderRadius.circular(DimensSizeV2.d12),
      onPressed: onPressed,
      icon: const Icon(LucideIcons.history, size: DimensSizeV2.d20),
      description: Text(
        title,
        style: theme.textStyles.paragraphXMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class BookmarkTip extends StatelessWidget {
  const BookmarkTip({
    required this.title,
    required this.uri,
    required this.onPressed,
    super.key,
  });

  final String title;
  final Uri uri;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return _Body(
      backgroundColor: theme.colors.background1,
      borderRadius: BorderRadius.circular(DimensSizeV2.d16),
      crossAxisAlignment: CrossAxisAlignment.start,
      onPressed: onPressed,
      icon: FaviconView(
        uri: uri,
        height: DimensSizeV2.d40,
        width: DimensSizeV2.d40,
      ),
      description: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DimensSizeV2.d4,
        children: [
          Text(
            title,
            style: theme.textStyles.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            uri.host,
            style: theme.textStyles.labelXSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.icon,
    required this.description,
    required this.backgroundColor,
    required this.borderRadius,
    required this.onPressed,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final Widget icon;
  final Widget description;
  final CrossAxisAlignment crossAxisAlignment;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: DimensSizeV2.d8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DimensSizeV2.d12,
              horizontal: DimensSizeV2.d16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: crossAxisAlignment,
                    spacing: DimensSizeV2.d8,
                    children: [
                      icon,
                      Flexible(child: description),
                    ],
                  ),
                ),
                const Icon(LucideIcons.chevronRight, size: DimensSizeV2.d20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
