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
    return Stack(
      children: [
        BrowserTabsList(
          key: wm.tabListKey,
          tabsState: wm.tabsState,
          activeTabState: wm.activeTabState,
          onChangeTab: wm.onChangeTab,
          onCloseTab: wm.onCloseTab,
        ),
        BrowserTabsView(
          viewVisibleState: wm.viewVisibleState,
          tabsState: wm.tabsState,
          onCreate: wm.onCreateController,
          onDispose: wm.onDisposeController,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BrowserBottomMenu(
            viewVisibleState: wm.viewVisibleState,
            tabsState: wm.tabsState,
            onCloseAllPressed: wm.onCloseAllPressed,
            onPlusPressed: wm.onPlusPressed,
            onDonePressed: wm.onDonePressed,
            onPressedBackPressed: wm.onPressedBackPressed,
            onPressedForwardPressed: wm.onPressedForwardPressed,
            onPressedDotsPressed: wm.onPressedDotsPressed,
            onPressedBook: wm.onPressedBook,
            onPressedTabs: wm.onPressedTabs,
          ),
        ),
      ],
    );
  }
}
