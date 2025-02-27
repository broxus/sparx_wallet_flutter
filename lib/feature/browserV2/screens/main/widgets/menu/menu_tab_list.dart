import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserTabListMenu extends StatelessWidget {
  const BrowserTabListMenu({
    required this.tabsState,
    required this.onCloseAllPressed,
    required this.onPlusPressed,
    required this.onDonePressed,
    super.key,
  });

  final ListenableState<BrowserTabsCollection> tabsState;
  final VoidCallback onCloseAllPressed;
  final VoidCallback onPlusPressed;
  final VoidCallback onDonePressed;

  static const height = DimensSizeV2.d48;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return SizedBox(
      height: height,
      child: StateNotifierBuilder<BrowserTabsCollection>(
        listenableState: tabsState,
        builder: (_, BrowserTabsCollection? data) {
          return ColoredBox(
            color: colors.background1,
            child: SizedBox(
              height: DimensSizeV2.d48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _TextButton(
                      title: LocaleKeys.browserCloseAll.tr(),
                      onPressed:
                          data?.list.isEmpty ?? true ? null : onCloseAllPressed,
                      color: colors.contentNegative,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onPlusPressed,
                    child: SvgPicture.asset(
                      Assets.images.plusCircled.path,
                    ),
                  ),
                  Expanded(
                    child: _TextButton(
                      title: LocaleKeys.browserDone.tr(),
                      onPressed: onDonePressed,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
