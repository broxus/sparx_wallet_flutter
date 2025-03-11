import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/header/tab_list_header_wm.dart';
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
    return StateNotifierBuilder(
      listenableState: wm.tabsState,
      builder: (_, BrowserTabsCollection? data) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TextButton(
              onPressed: wm.onPressedBookmarks,
              text: LocaleKeys.browserBookmarks.tr(),
            ),
            _GroupItem(
              name: LocaleKeys.allTabs.tr(),
              count: data?.countText,
            ),
            _TextButton(
              onPressed: wm.onPressedCreateNewGroup,
              text: LocaleKeys.newGroup.tr(),
            ),
          ],
        );
      },
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final colors = theme.colors;

    final styles = theme.textStyles;

    return GhostButton(
      onPressed: onPressed,
      buttonShape: ButtonShape.rectangle,
      child: Text(
        text,
        style: styles.labelSmall.copyWith(
          color: colors.content2,
        ),
      ),
    );
  }
}

class _GroupItem extends StatelessWidget {
  const _GroupItem({
    required this.name,
    this.count,
  });

  final String name;
  final String? count;

  @override
  Widget build(BuildContext context) {
    final styles = context.themeStyleV2.textStyles;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: styles.labelMedium,
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
    );
  }
}
