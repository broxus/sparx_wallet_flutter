import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/tabs/widgets/menu/browser_tabs_menu_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserTabsMenu extends ElementaryWidget<BrowserTabsMenuWidgetModel> {
  const BrowserTabsMenu({
    Key? key,
    WidgetModelFactory<BrowserTabsMenuWidgetModel> wmFactory =
        defaultBrowserTabsMenuWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(BrowserTabsMenuWidgetModel wm) {
    return StateNotifierBuilder<BrowserTabsData>(
      listenableState: wm.tabsState,
      builder: (_, BrowserTabsData? data) {
        return ColoredBox(
          color: wm.colors.background1,
          child: SizedBox(
            height: DimensSizeV2.d48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _TextButton(
                    title: LocaleKeys.browserCloseAll.tr(),
                    onPressed: data?.tabs.isEmpty ?? true
                        ? null
                        : wm.onCloseAllPressed,
                    color: wm.colors.contentNegative,
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: wm.onPlusPressed,
                  child: SvgPicture.asset(
                    Assets.images.plusCircled.path,
                  ),
                ),
                Expanded(
                  child: _TextButton(
                    title: LocaleKeys.browserDone.tr(),
                    onPressed: wm.onDonePressed,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    required this.title,
    this.onPressed,
    this.color,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Text(
          title,
          // TODO(knightforce): check style from designer
          style: themeStyle.textStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
            height: 1,
          ),
        ),
      ),
    );
  }
}
