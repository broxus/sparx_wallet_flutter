import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/view/approvals_listener_widget.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/pages_list.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list.dart';
import 'package:flutter/material.dart';

class BrowserMainScreen
    extends InjectedElementaryWidget<BrowserMainScreenWidgetModel> {
  const BrowserMainScreen({super.key});

  @override
  Widget build(BrowserMainScreenWidgetModel wm) {
    return SafeArea(
      child: ApprovalsListenerWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                BrowserTabsList(
                  key: wm.keys.tabListKey,
                  selectedGroupIdState: wm.tabs.selectedGroupIdState,
                  tabListScrollController: wm.tabs.tabListScrollController,
                  renderManager: wm.renderManager,
                  onPressedTabMenu: wm.tabMenu.showTabMenu,
                  onPressedGroup: wm.tabs.onPressedGroup,
                  onPressedTab: wm.onPressedTab,
                  onPressedCreateNewGroup: wm.onPressedCreateNewGroup,
                ),
                Positioned.fill(
                  child: Listener(
                    onPointerDown: wm.page.onPointerDown,
                    onPointerUp: wm.page.onPointerUp,
                    onPointerMove: wm.page.onPointerMove,
                    onPointerCancel: wm.page.onPointerCancel,
                    child: BrowserPagesView(
                      width: wm.sizes.screenWidth,
                      viewVisibleState: wm.viewVisibleState,
                      tabsState: wm.tabs.viewTabsState,
                      viewTabScrollController:
                          wm.pageSlider.viewTabScrollController,
                      paddingPageAnimation: wm.animations.paddingPageAnimation,
                      onLoadingProgressChanged:
                          wm.progressIndicator.onProgressChanged,
                      onCreateWebViewController: wm.onCreateWebViewController,
                      onWebPageScrollChanged: wm.page.onWebPageScrollChanged,
                      onDispose: wm.onDisposeWebController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
