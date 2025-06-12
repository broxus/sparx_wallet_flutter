import 'package:app/feature/browser_v2/screens/main/widgets/browser_text_button.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserTabsListActionBar extends StatelessWidget {
  const BrowserTabsListActionBar({
    required this.allTabsIdsState,
    required this.activeTabIdState,
    required this.onCloseAllPressed,
    required this.onGroupsMenuPressed,
    required this.onPlusPressed,
    required this.onDonePressed,
    super.key,
  });

  final ListenableState<List<String>?> allTabsIdsState;
  final ListenableState<String?> activeTabIdState;
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
      child: ColoredBox(
        color: colors.background1,
        child: SizedBox(
          height: DimensSizeV2.d48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StateNotifierBuilder<List<String>?>(
                listenableState: allTabsIdsState,
                builder: (_, List<String>? ids) {
                  return _Button(
                    onPressed: onCloseAllPressed,
                    title: LocaleKeys.browserCloseAll.tr(),
                    alignment: Alignment.centerLeft,
                    isActive: ids?.isNotEmpty ?? false,
                  );
                },
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onGroupsMenuPressed,
                child: SizedBox(
                  width: DimensSizeV2.d32,
                  height: double.infinity,
                  child: Icon(
                    LucideIcons.menu,
                    size: DimensSizeV2.d20,
                    color: colors.content3,
                  ),
                ),
              ),
              SizedBox(
                width: DimensSizeV2.d32,
                height: double.infinity,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onPlusPressed,
                  child: Icon(
                    LucideIcons.plus,
                    size: DimensSizeV2.d20,
                    color: colors.content3,
                  ),
                ),
              ),
              StateNotifierBuilder<String?>(
                listenableState: activeTabIdState,
                builder: (_, String? id) {
                  return _Button(
                    title: LocaleKeys.done.tr(),
                    alignment: Alignment.centerRight,
                    onPressed: onDonePressed,
                    isActive: id != null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.alignment,
    required this.onPressed,
    required this.isActive,
  });

  final String title;
  final Alignment alignment;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isActive,
      child: Opacity(
        opacity: isActive ? 1 : .5,
        child: BrowserTextButton(
          title: title,
          alignment: alignment,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
