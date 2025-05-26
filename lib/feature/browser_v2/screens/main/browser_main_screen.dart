import 'package:app/feature/browser_v1/approvals_listener/view/approvals_listener_widget.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/browser_progress_indicator.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/host_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/page_control_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/tabs_list_action_bar.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/pages_list.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list.dart';
import 'package:app/feature/browser_v2/widgets/past_go.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class BrowserMainScreen extends ElementaryWidget<BrowserMainScreenWidgetModel> {
  const BrowserMainScreen({
    super.key,
    WidgetModelFactory<BrowserMainScreenWidgetModel> wmFactory =
        defaultBrowserMainScreenWidgetModelFactory,
  }) : super(wmFactory);

  @override
  Widget build(BrowserMainScreenWidgetModel wm) {
    return ApprovalsListenerWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              BrowserTabsList(
                key: wm.keys.tabListKey,
                // selectedTabsState: wm.tabs.selectedGroupTabsState,
                selectedGroupIdState: wm.tabs.selectedGroupIdState,
                renderManager: wm.renderManager,
                onPressedTabMenu: wm.tabMenu.showTabMenu,
                onPressedGroup: wm.tabs.onPressedGroup,
                onPressedTab: wm.onPressedTab,
                // onCloseTab: wm.tabs.onCloseTab,
                onPressedCreateNewGroup: wm.onPressedCreateNewGroup,
                // onPressedGroup: wm.tabs.onPressedGroup,
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
                    tabsState: wm.tabs.tabsState,
                    scrollController: wm.pageSlider.viewTabScrollController,
                    paddingPageAnimation: wm.animations.paddingPageAnimation,
                    onLoadingProgressChanged:
                        wm.progressIndicator.onProgressChanged,
                    onCreateWebViewController: wm.onCreateWebViewController,
                    onWebPageScrollChanged: wm.page.onWebPageScrollChanged,
                    onDispose: wm.onDisposeWebController,
                  ),
                ),
              ),
              // // TODO(knightforce): optimize render
              _ItemPosition(
                child: BrowserProgressIndicator(
                  animation: wm.progressIndicator.animation,
                  menuState: wm.menuState,
                ),
              ),
              TabAnimatedView(
                onAnimationStart: wm.onTabAnimationStart,
                onAnimationEnd: wm.onTabAnimationEnd,
                tabAnimationTypeState: wm.tabs.tabAnimationTypeState,
              ),
              _ItemPosition(
                child: _MenuAnimation(
                  controller: wm.animations.listMenuAnimation,
                  offsetAnimation: wm.animations.listMenuOffsetAnimation,
                  opacityAnimation: wm.animations.listMenuOpacityAnimation,
                  child: BrowserTabsListActionBar(
                    key: wm.keys.listKey,
                    tabsState: wm.tabs.tabsState,
                    onCloseAllPressed: wm.tabs.onCloseAllPressed,
                    onPlusPressed: wm.tabs.addTab,
                    onDonePressed: wm.onDonePressed,
                  ),
                ),
              ),
              _ItemPosition(
                child: _MenuAnimation(
                  controller: wm.animations.viewMenuAnimation,
                  offsetAnimation: wm.animations.viewMenuOffsetAnimation,
                  opacityAnimation: wm.animations.viewMenuOpacityAnimation,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: wm.pageSlider.onScrollNotification,
                    child: BrowserPageControlPanel(
                      key: wm.keys.viewKey,
                      menuUrlPanelWidth: wm.sizes.screenWidth,
                      urlWidth: wm.sizes.urlWidth,
                      onPressedDotsPressed: wm.onPressedDotsPressed,
                      onPressedTabs: wm.onPressedTabs,
                      onPressedCurrentUrlMenu: wm.onPressedCurrentUrlMenu,
                      onPressedRefresh: wm.onPressedRefresh,
                      onEditingCompleteUrl: wm.onEditingCompleteUrl,
                      urlSliderController: wm.pageSlider.urlSliderController,
                      tabsState: wm.tabs.tabsState,
                      navigationScrollModeState: wm.navigationScrollModeState,
                    ),
                  ),
                ),
              ),
              _ItemPosition(
                child: _MenuAnimation(
                  controller: wm.animations.urlMenuAnimation,
                  offsetAnimation: wm.animations.urlMenuOffsetAnimation,
                  opacityAnimation: wm.animations.urlMenuOpacityAnimation,
                  child: HostPanel(
                    wm.tabs.hostState,
                    key: wm.keys.urlKey,
                    onPressed: wm.onPressedViewUrlPanel,
                  ),
                ),
              ),
              Positioned(
                bottom: BrowserTabsListActionBar.height + 44,
                left: 0,
                right: 0,
                child: _PastGoView(
                  showState: wm.pastGo.showPastGoState,
                  onPressed: wm.onPastGoPressed,
                ),
              ),
            ],
          ),
        ),
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

class _PastGoView extends StatelessWidget {
  const _PastGoView({
    required this.showState,
    required this.onPressed,
  });

  final ListenableState<bool> showState;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: showState,
      builder: (_, bool? isShow) {
        isShow ??= false;

        return Transform.translate(
          offset: Offset(0, isShow ? 0 : 300),
          child: AnimatedOpacity(
            opacity: isShow ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: Center(
              child: PastGoButton(
                onPressed: onPressed,
              ),
            ),
          ),
        );
      },
    );
  }
}
