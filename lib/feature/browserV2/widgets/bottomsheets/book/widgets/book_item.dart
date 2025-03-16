import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BookmarkListItem extends StatelessWidget {
  const BookmarkListItem({
    required this.onPressed,
    this.title,
    this.subTitle,
    this.url,
    this.prefix,
    this.suffix,
    super.key,
  });

  final String? title;
  final String? subTitle;
  final String? url;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return _Content(
      title: title,
      subTitle: subTitle,
      url: url,
      prefix: prefix,
      suffix: suffix,
      onPressed: onPressed,
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.onPressed,
    this.title,
    this.subTitle,
    this.url,
    this.prefix,
    this.suffix,
  });

  final String? title;
  final String? subTitle;
  final String? url;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final colors = theme.colors;
    final textStyles = theme.textStyles;

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
        child: SizedBox(
          width: double.infinity,
          height: DimensSizeV2.d58,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.background2,
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (prefix != null) prefix!,
                        Padding(
                          padding:
                              const EdgeInsets.only(right: DimensSizeV2.d8),
                          child: CachedNetworkImage(
                            height: DimensSize.d32,
                            width: DimensSize.d32,
                            imageUrl: url ?? '',
                            placeholder: (_, __) =>
                                const CommonCircularProgressIndicator(),
                            errorWidget: (_, __, ___) => CommonIconWidget.svg(
                              svg: Assets.images.web.path,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: DimensSizeV2.d4),
                                  child: Text(
                                    title ?? '',
                                    style: textStyles.labelMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  subTitle ?? '',
                                  style: textStyles.labelXSmall.copyWith(
                                    color: colors.content3,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: DimensSizeV2.d20),
                        child: Icon(
                          LucideIcons.chevronRight,
                          weight: DimensSizeV2.d20,
                        ),
                      ),
                      if (suffix != null) suffix!,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
