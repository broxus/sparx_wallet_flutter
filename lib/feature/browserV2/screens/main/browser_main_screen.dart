import 'package:app/feature/browserV2/screens/main/browser_main_screen_wm.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/tab_list.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tabs_view/tabs_view.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class BrowserMainScreen extends ElementaryWidget<BrowserMainScreenWidgetModel> {
  const BrowserMainScreen({
    Key? key,
    WidgetModelFactory<BrowserMainScreenWidgetModel> wmFactory =
        defaultBrowserMainScreenWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(BrowserMainScreenWidgetModel wm) {
    return SafeArea(
      child: Stack(
        children: [
          BrowserTabsList(
            key: wm.tabListKey,
            tabsState: wm.tabsState,
            onChangeTab: wm.onChangeTab,
            onCloseTab: wm.onCloseTab,
          ),
          Listener(
            onPointerDown: wm.onPointerDown,
            onPointerUp: wm.onPointerUp,
            child: BrowserTabsView(
              width: wm.screenWidth,
              viewVisibleState: wm.viewVisibleState,
              tabsState: wm.tabsState,
              scrollController: wm.viewTabScrollController,
              onCreate: wm.onCreateController,
              onScrollChanged: wm.onScrollChanged,
              onDispose: wm.onDisposeController,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BrowserBottomMenu(
              menuState: wm.menuState,
              tabsState: wm.tabsState,
              activeTabState: wm.activeTabState,
              screenHeight: wm.screenHeight,
              menuUrlPanelWidth: wm.screenWidth,
              urlWidth: wm.urlWidth,
              onCloseAllPressed: wm.onCloseAllPressed,
              onPlusPressed: wm.onPlusPressed,
              onDonePressed: wm.onDonePressed,
              onPressedBackPressed: wm.onPressedBackPressed,
              onPressedForwardPressed: wm.onPressedForwardPressed,
              onPressedDotsPressed: wm.onPressedDotsPressed,
              onPressedBook: wm.onPressedBook,
              onPressedTabs: wm.onPressedTabs,
              onPressedUrlMenu: wm.onPressedUrlMenu,
              onPressedRefresh: wm.onPressedRefresh,
              onPressedMenuUrl: wm.onPressedMenuUrl,
              onEditingCompleteUrl: wm.onEditingCompleteUrl,
              urlSliderController: wm.urlSliderController,
            ),
          ),
        ],
      ),
    );
  }
}
