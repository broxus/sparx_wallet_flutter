import 'package:app/feature/browser/widgets/bottomsheets/book/widgets/tab_data.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserBookTabBar extends StatelessWidget {
  const BrowserBookTabBar({
    required this.tabBarState,
    required this.onPressedTab,
    super.key,
  });

  final ListenableState<BrowserBookTabBarValue> tabBarState;
  final ValueChanged<BrowserBookTabBarValue> onPressedTab;

  static const height = DimensSizeV2.d48;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d24),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
            color: colors.background2,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DimensSizeV2.d4,
              horizontal: DimensSizeV2.d2,
            ),
            child: StateNotifierBuilder(
              listenableState: tabBarState,
              builder: (_, BrowserBookTabBarValue? selectedValue) {
                return Row(
                  children: [
                    for (final value in BrowserBookTabBarValue.values)
                      Expanded(
                        key: ValueKey(value),
                        child: _Item(
                          title: value.title,
                          icon: value.icon,
                          isActive: value == selectedValue,
                          onPressed: () => onPressedTab(value),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.title,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;

  static const _duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final textStyles = theme.textStyles;
    final colors = theme.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d2),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: SizedBox(
          height: double.infinity,
          child: AnimatedContainer(
            duration: _duration,
            decoration: BoxDecoration(
              color: isActive ? ColorsResV2.midnightBlue : colors.background2,
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: DimensSizeV2.d8),
                  child: Icon(
                    icon,
                    size: DimensSizeV2.d20,
                    color: isActive ? colors.primaryA : colors.border1,
                  ),
                ),
                AnimatedDefaultTextStyle(
                  duration: _duration,
                  style: textStyles.labelSmall.copyWith(
                    color: isActive ? colors.primaryA : colors.border1,
                  ),
                  child: Text(title),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
