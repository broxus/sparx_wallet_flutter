import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/browser_text_button.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserTabsListActionBar extends StatelessWidget {
  const BrowserTabsListActionBar({
    required this.viewTabsState,
    required this.onCloseAllPressed,
    required this.onGroupsMenuPressed,
    required this.onPlusPressed,
    required this.onDonePressed,
    super.key,
  });

  final ListenableState<List<BrowserTab>?> viewTabsState;
  final VoidCallback onCloseAllPressed;
  final VoidCallback onGroupsMenuPressed;
  final VoidCallback onPlusPressed;
  final VoidCallback onDonePressed;

  static const height = DimensSizeV2.d48;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return SizedBox(
      height: height,
      child: StateNotifierBuilder<List<BrowserTab>?>(
        listenableState: viewTabsState,
        builder: (_, List<BrowserTab>? tabs) {
          final isEmpty = tabs?.isEmpty ?? true;
          return ColoredBox(
            color: colors.background1,
            child: SizedBox(
              height: DimensSizeV2.d48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isEmpty)
                    const SizedBox.shrink()
                  else
                    BrowserTextButton(
                      title: LocaleKeys.browserCloseAll.tr(),
                      alignment: Alignment.centerLeft,
                      onPressed: onCloseAllPressed,
                    ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onGroupsMenuPressed,
                    child: SizedBox(
                      width: DimensSizeV2.d32,
                      height: double.infinity,
                      child: Icon(
                        LucideIcons.menu,
                        size: DimensSizeV2.d16,
                        color: colors.content3,
                      ),
                    ),
                  ),
                  // удалить
                  SizedBox(
                    width: DimensSizeV2.d32,
                    height: double.infinity,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onPlusPressed,
                      child: Icon(
                        LucideIcons.plus,
                        size: DimensSizeV2.d16,
                        color: colors.content3,
                      ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: isEmpty,
                    child: Opacity(
                      opacity: isEmpty ? .7 : 1,
                      child: BrowserTextButton(
                        title: LocaleKeys.done.tr(),
                        alignment: Alignment.centerRight,
                        onPressed: onDonePressed,
                      ),
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
