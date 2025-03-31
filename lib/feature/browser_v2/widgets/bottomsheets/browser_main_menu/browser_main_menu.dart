import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu_wm.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/data/browser_main_menu_data.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

Future<void> showBrowserMainMenu(BuildContext context) {
  return showPrimaryBottomSheet(
    context: context,
    barrierColor: Colors.black.withOpacity(.8),
    padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d21),
    content: const BrowserMainMenu(),
  );
}

class BrowserMainMenu extends ElementaryWidget<BrowserMainMenuWidgetModel> {
  const BrowserMainMenu({
    super.key,
    WidgetModelFactory<BrowserMainMenuWidgetModel> wmFactory =
        defaultBrowserMainMenuWidgetModelFactory,
  }) : super(wmFactory);

  @override
  Widget build(BrowserMainMenuWidgetModel wm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryShapedContainerColumn(
          children: [
            _Item(
              BrowserMainMenuData.clearHistory,
              onPressed: wm.onPressedItem,
            ),
          ],
        ),
        const SizedBox(height: DimensSizeV2.d16),
        PrimaryShapedContainerColumn(
          children: [
            _Item(
              BrowserMainMenuData.newTab,
              onPressed: wm.onPressedItem,
            ),
            _Item(
              BrowserMainMenuData.reload,
              onPressed: wm.onPressedItem,
            ),
            // TODO(knightforce): not ready
            // _Item(
            //   BrowserMainMenuData.translatePage,
            //   onPressed: wm.onPressedItem,
            // ),
            _Item(
              BrowserMainMenuData.addBookmark,
              onPressed: wm.onPressedItem,
            ),
          ],
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(
    this.data, {
    required this.onPressed,
  });

  final BrowserMainMenuData data;
  final ValueChanged<BrowserMainMenuData> onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryShapedContainerItem(
      title: data.title,
      icon: data.icon,
      iconColor: switch (data) {
        BrowserMainMenuData.clearHistory =>
          // TODO(knightforce): move to colors
          const Color(0xFFFF2D55),
        _ => null
      },
      onPressed: () => onPressed(data),
    );
  }
}
