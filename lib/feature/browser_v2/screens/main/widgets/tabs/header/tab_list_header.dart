import 'package:app/feature/browser_v2/screens/main/widgets/tabs/header/tab_list_header_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/header/ui_models/tab_list_ui_models.dart';
import 'package:app/generated/generated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TabListHeader extends ElementaryWidget<TabListHeaderWidgetModel> {
  const TabListHeader({
    Key? key,
    WidgetModelFactory<TabListHeaderWidgetModel> wmFactory =
        defaultTabListHeaderWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(TabListHeaderWidgetModel wm) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final itemWidth = constraints.maxWidth / 3;
        return SizedBox(
          height: DimensSizeV2.d41,
          child: StateNotifierBuilder(
            listenableState: wm.uiState,
            builder: (_, List<TabListHeaderUiModel>? uiModels) {
              if (uiModels == null) {
                return const SizedBox.shrink();
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: uiModels.length,
                physics: const ClampingScrollPhysics(),
                // padEnds: false,
                // controller: wm.pageController,
                itemBuilder: (_, int index) {
                  return switch (uiModels[index]) {
                    TabListHeaderBookmarksUiModel() => _TextButton(
                        key: ObjectKey(uiModels[index]),
                        width: itemWidth,
                        onPressed: wm.onPressedBookmarks,
                        text: LocaleKeys.browserBookmarks.tr(),
                        alignment: Alignment.centerLeft,
                      ),
                    TabListHeaderGroupUiModel(
                      :final id,
                      :final tabsCountText,
                      :final title,
                      :final isSelected,
                    ) =>
                      _GroupItem(
                        key: ValueKey(id),
                        width: itemWidth,
                        onPressed: () => wm.onPressedGroup(id),
                        name: title ?? '',
                        count: tabsCountText,
                        isSelected: isSelected,
                      ),
                    TabListHeaderNewGroupUiModel() => _TextButton(
                        key: ObjectKey(uiModels[index]),
                        width: itemWidth,
                        onPressed: wm.onPressedCreateNewGroup,
                        text: LocaleKeys.newGroup.tr(),
                        alignment: Alignment.centerRight,
                      ),
                  };
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    required this.width,
    required this.text,
    required this.alignment,
    required this.onPressed,
    super.key,
  });

  final double width;
  final String text;
  final Alignment alignment;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final colors = theme.colors;

    final styles = theme.textStyles;

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: Align(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
            child: Center(
              child: Text(
                text,
                style: styles.labelSmall.copyWith(
                  color: colors.content2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GroupItem extends StatelessWidget {
  const _GroupItem({
    required this.width,
    required this.name,
    required this.isSelected,
    required this.onPressed,
    this.count,
    super.key,
  });

  final double width;
  final String name;
  final bool isSelected;
  final String? count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final colors = theme.colors;

    final styles = theme.textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: isSelected
                  ? styles.labelMedium
                  : styles.labelSmall.copyWith(
                      color: colors.content2,
                    ),
            ),
            if (count != null)
              Padding(
                padding: const EdgeInsets.only(left: DimensSizeV2.d4),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // TODO(knightforce): add to color palette
                    color: Color(0xff353960),
                  ),
                  child: SizedBox(
                    width: DimensSizeV2.d20,
                    height: DimensSizeV2.d20,
                    child: Center(
                      child: AutoSizeText(
                        count!,
                        minFontSize: 1,
                        style: styles.labelXSmall,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
