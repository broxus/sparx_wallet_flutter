import 'package:app/feature/browser_v1/approvals_listener/view/approvals_listener_widget.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/browser_progress_indicator.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/host_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/page_control_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/tabs_list_action_bar.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/pages_list.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tab_list/tab_list.dart';
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
                tabsState: wm.tabsState,
                renderManager: wm.renderManager,
                onPressedTabMenu: wm.onPressedTabMenu,
                onChangeTab: wm.onChangeTab,
                onCloseTab: wm.onCloseTab,
              ),
              Positioned.fill(
                child: Listener(
                  onPointerDown: wm.onPointerDown,
                  onPointerUp: wm.onPointerUp,
                  onPointerCancel: wm.onPointerCancel,
                  child: BrowserPagesView(
                    width: wm.sizes.screenWidth,
                    viewVisibleState: wm.viewVisibleState,
                    tabsState: wm.tabsState,
                    scrollController: wm.viewTabScrollController,
                    progressController: wm.progressController,
                    onCreateWebViewController: wm.onCreateWebViewController,
                    onWebPageScrollChanged: wm.onWebPageScrollChanged,
                    onOverScrolled: wm.onOverScrolled,
                    onDispose: wm.onDisposeWebController,
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
              TabAnimatedView(
                onAnimationStart: wm.onTabAnimationStart,
                onAnimationEnd: wm.onTabAnimationEnd,
                showAnimationState: wm.showAnimationState,
              ),
              _ItemPosition(
                child: _MenuAnimation(
                  controller: wm.animation.listMenuAnimation,
                  offsetAnimation: wm.animation.listMenuOffsetAnimation,
                  opacityAnimation: wm.animation.listMenuOpacityAnimation,
                  child: BrowserTabsListActionBar(
                    key: wm.keys.listKey,
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
                  child: NotificationListener<ScrollNotification>(
                    onNotification: wm.onScrollNotification,
                    child: BrowserPageControlPanel(
                      key: wm.keys.viewKey,
                      menuUrlPanelWidth: wm.sizes.screenWidth,
                      urlWidth: wm.sizes.urlWidth,
                      onPressedTabs: wm.onPressedTabs,
                      onPressedCurrentUrlMenu: wm.onPressedCurrentUrlMenu,
                      onPressedRefresh: wm.onPressedRefresh,
                      onEditingCompleteUrl: wm.onEditingCompleteUrl,
                      urlSliderController: wm.urlSliderController,
                      tabsState: wm.tabsState,
                    ),
                  ),
                ),
              ),
              _ItemPosition(
                child: _MenuAnimation(
                  controller: wm.animation.urlMenuAnimation,
                  offsetAnimation: wm.animation.urlMenuOffsetAnimation,
                  opacityAnimation: wm.animation.urlMenuOpacityAnimation,
                  child: HostPanel(
                    wm.activeTabState,
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
                  showState: wm.showPastGoState,
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
