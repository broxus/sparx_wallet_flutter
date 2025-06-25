import 'package:app/core/wm/custom_wm.dart';
import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar_wm.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CustomBottomNavigationBar
    extends InjectedElementaryWidget<CustomBottomNavigationBarWidgetModel> {
  const CustomBottomNavigationBar({
    super.key,
  });

  static const height = DimensSizeV2.d48;
  static const animateDuration = Duration(milliseconds: 150);

  @override
  Widget build(CustomBottomNavigationBarWidgetModel wm) {
    final bottomPadding = wm.bottomPadding;

    return StateNotifierBuilder<BottomBarState>(
      listenableState: wm.visibleState,
      builder: (_, BottomBarState? visibleState) {
        visibleState ??= BottomBarState.hidden;

        return AnimatedOpacity(
          duration: animateDuration,
          opacity: visibleState == BottomBarState.expanded ? 1.0 : 0.0,
          child: AnimatedSize(
            duration: animateDuration,
            child: SizedBox(
              height: switch (visibleState) {
                BottomBarState.expanded => height + bottomPadding,
                BottomBarState.collapsed => bottomPadding,
                BottomBarState.hidden => 0,
              },
              child: Theme(
                data: wm.themeData,
                child: OverflowBox(
                  maxHeight: double.infinity,
                  alignment: Alignment.topCenter,
                  child: StateNotifierBuilder<RootTab>(
                    listenableState: wm.tabState,
                    builder: (_, RootTab? tab) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensSizeV2.d48,
                        ),
                        decoration: BoxDecoration(
                          color: wm.colors.background1,
                          borderRadius: switch (tab) {
                            RootTab.browser => null,
                            _ => const BorderRadius.vertical(
                                top: Radius.circular(DimensSizeV2.d16),
                              ),
                          },
                          border: Border(
                            top: BorderSide(
                              color: switch (tab) {
                                // TODO(knightforce): add to color palette
                                RootTab.browser => const Color(0xff353960),
                                _ => wm.colors.background1,
                              },
                            ),
                          ),
                        ),
                        child: BottomNavigationBar(
                          landscapeLayout:
                              BottomNavigationBarLandscapeLayout.centered,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          elevation: DimensSizeV2.d0,
                          type: BottomNavigationBarType.fixed,
                          backgroundColor: wm.colors.background1,
                          selectedItemColor: wm.colors.content0,
                          unselectedItemColor: wm.colors.content3,
                          items: wm.items,
                          currentIndex: tab?.index ?? 0,
                          onTap: wm.onTap,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
