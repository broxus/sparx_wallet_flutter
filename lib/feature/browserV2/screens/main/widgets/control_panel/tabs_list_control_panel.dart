import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserTabsListControlPanel extends StatelessWidget {
  const BrowserTabsListControlPanel({
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: data?.list.isEmpty ?? true
                        ? const SizedBox.shrink()
                        : _TextButton(
                            title: LocaleKeys.browserCloseAll.tr(),
                            alignment: Alignment.centerLeft,
                            onPressed: onCloseAllPressed,
                          ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onPlusPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimensSizeV2.d32,
                      ),
                      child: SvgPicture.asset(
                        Assets.images.plusCircled.path,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _TextButton(
                      title: LocaleKeys.browserDone.tr(),
                      alignment: Alignment.centerRight,
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
    required this.alignment,
    this.onPressed,
  });

  final String title;
  final Alignment alignment;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Align(
        alignment: alignment,
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimensSizeV2.d32,
            ),
            child: Text(
              title,
              // TODO(knightforce): check style from designer
              style: themeStyle.textStyles.labelSmall.copyWith(
                fontWeight: FontWeight.w600,
                color: themeStyle.colors.content2,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
