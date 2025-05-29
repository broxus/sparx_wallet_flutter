import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/data/menu_data.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/animation_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/browser_keys_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/group_menu_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/page_slide_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/past_go_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/progress_indicator_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/scroll_page_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/size_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/tab_menu_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/tabs_and_groups_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/navigation_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/url_action_sheet.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:app/utils/common_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [BrowserMainScreenWidgetModel]
BrowserMainScreenWidgetModel defaultBrowserMainScreenWidgetModelFactory(
  BuildContext context,
) {
  return BrowserMainScreenWidgetModel(
    BrowserMainScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserMainScreen]
class BrowserMainScreenWidgetModel
    extends CustomWidgetModel<BrowserMainScreen, BrowserMainScreenModel>
    with TickerProviderWidgetModelMixin {
  BrowserMainScreenWidgetModel(
    super.model,
  );

  final keys = BrowserKeysDelegate();

  late final sizes = BrowserSizesDelegate(context);

  final _renderManager = BrowserRenderManager();

  late final _animationDelegate = BrowserAnimationDelegate(this);

  late final _pageDelegate = BrowserPageScrollDelegate(
    onPageScrollChange: (bool isToTop) {
      Future(() {
        _menuState.accept(isToTop ? MenuType.view : MenuType.url);
        _visibleNavigationBarState.accept(isToTop);
      });
    },
  );

  late final _progressIndicatorDelegate =
      BrowserProgressIndicatorDelegate(this);

  late final _tabMenuDelegate = BrowserTabMenuDelegate(
    model,
    context,
    renderManager: _renderManager,
    onShowMenu: () => callWithDelay(() => _menuState.accept(null)),
    onHideMenu: () => callWithDelay(() => _menuState.accept(MenuType.list)),
    createGroup: (String tabId) => _tabsDelegate.createGroup(
      context,
      tabId: tabId,
    ),
  );

  late final _groupMenuDelegate = BrowserGroupMenuDelegate();

  final _pastGoDelegate = BrowserPastGoDelegate();

  late final _pageSlideDelegate = BrowserPageSlideDelegate(
    screenWidth: sizes.screenWidth,
    urlWidth: sizes.urlWidth,
    onChangeSlideIndex: (int tabIndex) {
      if (!_viewVisibleState.value) {
        return;
      }

      Future(() {
        final group = model.activeGroupState.value;

        if (group == null) {
          return;
        }

        final tabId = _tabsDelegate.getIdByIndex(
          groupId: group.id,
          index: tabIndex,
        );

        if (tabId == null || model.activeTabId == tabId) {
          return;
        }

        model.setActiveTab(tabId);

        callWithDelay(() {
          _progressIndicatorDelegate.reset();
          _updatePastGo();
        });
      });
    },
  );

  late final _tabsDelegate = BrowserTabsAndGroupsDelegate(
    context,
    model,
    renderManager: _renderManager,
    onEmptyTabs: _onEmptyTabs,
    onChangeTab: () => callWithDelay(() => _menuState.accept(MenuType.view)),
    onUpdateActiveTab: () {
      callWithDelay(() {
        _progressIndicatorDelegate.reset();
        _updatePastGo();
      });
    },
    scrollToTab: _scrollToTab,
    checkIsVisiblePages: () => _viewVisibleState.value,
  );

  late final _viewVisibleState = createNotNullNotifier<bool>(
    model.activeTabId != null,
  );

  late final _menuState = createNotifier<MenuType>(
    model.activeTabId != null ? MenuType.view : MenuType.list,
  );

  late final _navigationScrollModeState =
      createNotifier<NavigationUrlPhysicMode>(
    NavigationUrlPhysicMode.none,
  );

  late final _visibleNavigationBarState = createNotifier<bool>(true);

  BrowserPageSlideUi get pageSlider => _pageSlideDelegate;

  BrowserTabsAndGroupsUi get tabs => _tabsDelegate;

  BrowserPastGoUi get pastGo => _pastGoDelegate;

  BrowserAnimationUi get animations => _animationDelegate;

  BrowserProgressIndicatorUi get progressIndicator =>
      _progressIndicatorDelegate;

  BrowserTabMenuUi get tabMenu => _tabMenuDelegate;

  BrowserPageScrollDelegate get page => _pageDelegate;

  RenderManager<String> get renderManager => _renderManager;

  ListenableState<MenuType> get menuState => _menuState;

  ListenableState<bool> get viewVisibleState => _viewVisibleState;

  ListenableState<BrowserTab?> get activeTabState => model.activeTabState;

  ListenableState<NavigationUrlPhysicMode> get navigationScrollModeState =>
      _navigationScrollModeState;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    _menuState.addListener(_handleMenuState);
    _viewVisibleState.addListener(_handleViewVisibleState);
    _visibleNavigationBarState.addListener(_handleVisibleNavigationBar);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final groupId = model.activeGroupState.value?.id;
      final tabId = _tabsDelegate.activeTabId;
      if (groupId != null && tabId != null) {
        _scrollToTab(
          groupId: groupId,
          tabId: tabId,
        );
      }
    });

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _tabsDelegate.dispose();
    model.closeAllControllers();
    _menuState.removeListener(_handleMenuState);
    _progressIndicatorDelegate.dispose();
    _animationDelegate.dispose();
    _renderManager.dispose();
    _pastGoDelegate.dispose();
    _pageSlideDelegate.dispose();
    super.dispose();
  }

  void onCreateWebViewController(
    String tabId,
    CustomWebViewController controller,
  ) {
    model.setController(tabId, controller);
  }

  void onDisposeWebController(String tabId) {
    model.removeController(tabId);
  }

  void onDonePressed() {
    _tabsDelegate.animateShowView();
    _menuState.accept(MenuType.view);
  }

  void onPressedTabs() {
    _tabsDelegate.animateShowTabs();
    _menuState.accept(MenuType.list);
  }

  void onGroupsMenuPressed() {
    _groupMenuDelegate.showMenu(context);
  }

  Future<void> onPressedCurrentUrlMenu(String tabId) async {
    final result = await showUrlActionSheet(context);

    if (result == null) {
      return;
    }

    switch (result) {
      case BrowserUrlActionValue.copyUrl:
        model.copyTabUrl(tabId);
      case BrowserUrlActionValue.addBookmark:
        model.addUrlToBookmark(tabId);
      case BrowserUrlActionValue.clearFromHistory:
        model.clearUrlFromHistory(tabId);
    }
  }

  void onPressedRefresh(String tabId) {
    model.refresh(tabId);
  }

  void onPressedViewUrlPanel() {
    _menuState.accept(MenuType.view);
    _visibleNavigationBarState.accept(true);
  }

  void onPastGoPressed() => _pastGoDelegate.onPastGoPressed(
        onSuccess: (String text) => model.requestUrl(
          _tabsDelegate.activeTabId,
          text,
        ),
      );

  void onEditingCompleteUrl(String tabId, String text) {
    model.requestUrl(tabId, text);
  }

  void onTabAnimationStart() => _tabsDelegate.onTabAnimationStart(
        _onTabAnimationComplete,
      );

  void onTabAnimationEnd(TabAnimationType? animationType) {
    _tabsDelegate.onTabAnimationEnd(
      _onTabAnimationComplete,
    );

    if (animationType is ShowViewAnimationType) {
      _navigationScrollModeState.accept(
        NavigationUrlPhysicMode.snap,
      );
    }
  }

  void onPressedDotsPressed() {
    final groupId = tabs.selectedGroupIdState.value;

    if (groupId == null) {
      return;
    }

    showBrowserMainMenu(
      context,
      groupId: groupId,
    );
  }

  Future<void> onPressedTab(String tabId) async {
    final groupId = tabs.selectedGroupIdState.value;

    if (groupId == null) {
      return;
    }

    _navigationScrollModeState.accept(
      NavigationUrlPhysicMode.none,
    );

    tabs.changeTab(
      groupId: groupId,
      tabId: tabId,
    );
  }

  void onPressedCreateNewGroup() {
    _tabsDelegate.createGroup(context);
  }

  void _onEmptyTabs() {
    callWithDelay(() {
      _pageDelegate.reset();
      _pageSlideDelegate.slideTo(0);
    });
  }

  void _onTabAnimationComplete(bool isVisible) {
    _viewVisibleState.accept(isVisible);
  }

  void _handleViewVisibleState() {
    _updatePastGo();
  }

  void _handleVisibleNavigationBar() {
    primaryBus.fire(
      _visibleNavigationBarState.value ?? true
          ? RevertNavigationEvent()
          : HideNavigationEvent(),
    );
  }

  Future<bool> _scrollToTab({
    required String groupId,
    required String tabId,
  }) async {
    return Future.delayed(const Duration(milliseconds: 10), () {
      final index = _tabsDelegate.getTabIndexById(
        groupId: groupId,
        tabId: tabId,
      );

      if (index != null && index > -1) {
        _pageSlideDelegate.slideTo(sizes.urlWidth * index + 50);

        _pageDelegate.reset();
      }

      return index != null && index > -1;
    });
  }

  void _handleMenuState() {
    _animationDelegate.handleMenuType(
      _menuState.value,
      duration: Duration.zero,
    );
  }

  Future<void> _updatePastGo() async {
    _pastGoDelegate.updateVisible(
      (_viewVisibleState.value) &&
          (_tabsDelegate.isEmptyActiveTabUrl) &&
          await checkExistClipBoardData(),
    );
  }
}
