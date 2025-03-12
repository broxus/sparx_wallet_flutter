import 'package:app/feature/browserV2/screens/main/browser_main_screen_wm.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_progress_indicator.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/menu_tab_list.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/menu_view_tab/menu_url.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/menu_view_tab/menu_view_tab.dart';
import 'package:app/feature/browserV2/screens/main/widgets/pages_view/pages_view.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/tab_list.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class BrowserMainScreen extends ElementaryWidget<BrowserMainScreenWidgetModel> {
  const BrowserMainScreen({
    super.key,
    WidgetModelFactory<BrowserMainScreenWidgetModel> wmFactory =
        defaultBrowserMainScreenWidgetModelFactory,
  }) : super(wmFactory);

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
            child: BrowserPagesView(
              width: wm.screenWidth,
              viewVisibleState: wm.viewVisibleState,
              tabsState: wm.tabsState,
              scrollController: wm.viewTabScrollController,
              progressController: wm.progressController,
              onCreate: wm.onCreateController,
              onScrollChanged: wm.onScrollChanged,
              onDispose: wm.onDisposeController,
            ),
          ),
          _ItemPosition(
            child: _MenuAnimation(
              controller: wm.animation.listMenuAnimation,
              offsetAnimation: wm.animation.listMenuOffsetAnimation,
              opacityAnimation: wm.animation.listMenuOpacityAnimation,
              child: BrowserTabListMenu(
                key: wm.listKey,
                tabsState: wm.tabsState,
                onCloseAllPressed: wm.onCloseAllPressed,
                onPlusPressed: wm.onPlusPressed,
                onDonePressed: wm.onDonePressed,
              ),
            ),
          ),
          _ItemPosition(
            child: _MenuAnimation(
              controller: wm.animation.viewMenuAnimation,
              offsetAnimation: wm.animation.viewMenuOffsetAnimation,
              opacityAnimation: wm.animation.viewMenuOpacityAnimation,
              child: BrowserTabViewMenu(
                key: wm.viewKey,
                menuUrlPanelWidth: wm.screenWidth,
                urlWidth: wm.urlWidth,
                onPressedTabs: wm.onPressedTabs,
                onPressedUrlMenu: wm.onPressedUrlMenu,
                onPressedRefresh: wm.onPressedRefresh,
                onEditingCompleteUrl: wm.onEditingCompleteUrl,
                urlSliderController: wm.urlSliderController,
                tabsState: wm.tabsState,
              ),
            ),
          ),
          _ItemPosition(
            child: _MenuAnimation(
              controller: wm.animation.urlMenuAnimation,
              offsetAnimation: wm.animation.urlMenuOffsetAnimation,
              opacityAnimation: wm.animation.urlMenuOpacityAnimation,
              child: MenuRawUrl(
                wm.activeTabState,
                key: wm.urlKey,
                onPressed: wm.onPressedMenuUrl,
              ),
            ),
          ),

          // TODO(knightforce): optimize render
          _ItemPosition(
            child: BrowserProgressIndicator(
              animation: wm.progressController,
              menuState: wm.menuState,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemPosition extends Positioned {
  const _ItemPosition({
    required super.child,
  }) : super(
          bottom: 0,
          left: 0,
          right: 0,
        );
}

class _MenuAnimation extends StatelessWidget {
  const _MenuAnimation({
    required this.child,
    required this.controller,
    required this.offsetAnimation,
    required this.opacityAnimation,
  });

  final Animation<double> controller;
  final Animation<Offset> offsetAnimation;
  final Animation<double> opacityAnimation;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: offsetAnimation.value,
          child: Opacity(
            opacity: opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
