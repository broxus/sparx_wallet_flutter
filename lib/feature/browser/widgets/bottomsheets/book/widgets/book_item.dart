import 'package:app/feature/browser/widgets/favicon_view/favicon_view.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BookmarkListItem extends StatelessWidget {
  const BookmarkListItem({
    required this.index,
    required this.editState,
    required this.onPressed,
    required this.onPressedRemove,
    this.title,
    this.subTitle,
    this.uri,
    super.key,
  });

  final int index;
  final String? title;
  final String? subTitle;
  final Uri? uri;
  final ListenableState<bool> editState;
  final VoidCallback onPressed;
  final VoidCallback onPressedRemove;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: editState,
      builder: (_, bool? editValue) {
        editValue ??= false;

        return _Content(
          title: title,
          subTitle: subTitle,
          uri: uri,
          prefix: Padding(
            padding: const EdgeInsets.only(right: DimensSizeV2.d16),
            child: _CrossAnimation(
              first: _RemoveLabel(onPressed: onPressedRemove),
              second: const SizedBox.shrink(),
              isShowFirst: editValue,
            ),
          ),
          suffix: Padding(
            padding: const EdgeInsets.only(left: DimensSizeV2.d16),
            child: _CrossAnimation(
              first: ReorderableDragStartListener(
                index: index,
                child: const _DragLabel(),
              ),
              second: const SizedBox.shrink(),
              isShowFirst: editValue,
            ),
          ),
          onPressed: !editValue ? onPressed : null,
        );
      },
    );
  }
}

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({
    required this.editState,
    required this.onPressed,
    required this.onPressedRemove,
    this.uri,
    this.title,
    this.subTitle,
    super.key,
  });

  final Uri? uri;
  final String? title;
  final String? subTitle;
  final ListenableState<bool> editState;
  final VoidCallback onPressed;
  final VoidCallback onPressedRemove;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: editState,
      builder: (_, bool? isEdit) {
        isEdit ??= false;

        return _Content(
          title: title,
          subTitle: subTitle,
          uri: uri,
          prefix: Padding(
            padding: const EdgeInsets.only(right: DimensSizeV2.d16),
            child: _CrossAnimation(
              first: _RemoveLabel(onPressed: onPressedRemove),
              second: const SizedBox.shrink(),
              isShowFirst: isEdit,
            ),
          ),
          suffix: const SizedBox(width: DimensSizeV2.d16),
          onPressed: isEdit ? null : onPressed,
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    this.title,
    this.subTitle,
    this.uri,
    this.prefix,
    this.suffix,
    this.onPressed,
  });

  final String? title;
  final String? subTitle;
  final Uri? uri;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final colors = theme.colors;
    final textStyles = theme.textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(
          left: DimensSizeV2.d24,
          right: DimensSizeV2.d24,
          bottom: DimensSizeV2.d8,
        ),
        child: SizedBox(
          width: double.infinity,
          height: DimensSizeV2.d58,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.background2,
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (prefix != null) prefix!,
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: DimensSizeV2.d8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(DimensSize.d32),
                          child: FaviconView(
                            uri: uri,
                            height: DimensSize.d32,
                            width: DimensSize.d32,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: DimensSizeV2.d4,
                                ),
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
                      const Padding(
                        padding: EdgeInsets.only(left: DimensSizeV2.d20),
                        child: Icon(
                          LucideIcons.chevronRight,
                          weight: DimensSizeV2.d20,
                        ),
                      ),
                    ],
                  ),
                ),
                if (suffix != null) suffix!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RemoveLabel extends StatelessWidget {
  const _RemoveLabel({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        width: DimensSizeV2.d64,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: context.themeStyleV2.colors.content3.withValues(
                  alpha: .2,
                ),
              ),
            ),
          ),
          child: const Center(
            child: Icon(
              LucideIcons.trash2,
              size: DimensSizeV2.d16,
              color: ColorsResV2.vibrantStrawberry,
            ),
          ),
        ),
      ),
    );
  }
}

class _DragLabel extends StatelessWidget {
  const _DragLabel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DimensSizeV2.d64,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: context.themeStyleV2.colors.content3.withValues(alpha: .2),
            ),
          ),
        ),
        child: const Center(
          child: Icon(LucideIcons.equal, size: DimensSizeV2.d16),
        ),
      ),
    );
  }
}

class _CrossAnimation extends StatelessWidget {
  const _CrossAnimation({
    required this.first,
    required this.second,
    required this.isShowFirst,
  });

  final Widget first;
  final Widget second;
  final bool isShowFirst;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      crossFadeState: isShowFirst
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 250),
    );
  }
}
