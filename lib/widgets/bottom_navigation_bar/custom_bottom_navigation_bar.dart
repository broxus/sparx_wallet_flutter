import 'package:app/feature/root/view/root_tab.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CustomBottomNavigationBar
    extends ElementaryWidget<CustomBottomNavigationBarWidgetModel> {
  const CustomBottomNavigationBar({
    Key? key,
    WidgetModelFactory<CustomBottomNavigationBarWidgetModel> wmFactory =
        defaultCustomBottomNavigationBarWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(CustomBottomNavigationBarWidgetModel wm) {
    return StateNotifierBuilder<bool>(
      listenableState: wm.visibleState,
      builder: (_, bool? isVisible) {
        isVisible ??= false;

        return AnimatedSlide(
          duration: defaultAnimationDuration,
          offset: Offset(0, isVisible ? 0 : 1.0),
          child: Theme(
            data: wm.themeData,
            child: SafeArea(
              child: SizedBox(
                height: DimensSizeV2.d48,
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
                        ),
                        foregroundDecoration: BoxDecoration(
                          border: Border(
                            top: switch (tab) {
                              RootTab.browser => const BorderSide(
                                  // TODO(knightforce): add to color palette
                                  color: Color(0xff353960),
                                ),
                              _ => BorderSide.none,
                            },
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
