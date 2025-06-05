import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/data/menu_data.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_animation_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_browser_keys_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_group_menu_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_page_slide_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_past_go_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_progress_indicator_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_scroll_page_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_size_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_tab_menu_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_tabs_and_groups_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/url_action_sheet.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu.dart';
import 'package:app/utils/clipboard_utils.dart';
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

  final keys = BrowserKeysUiDelegate();

  late final sizes = BrowserSizesUiDelegate(context);

  final _renderManager = BrowserRenderManager();

  late final _animationDelegate = BrowserAnimationUiDelegate(this);

  late final _pageDelegate = BrowserPageScrollUiDelegate(
    onPageScrollChange: (bool isToTop) {
      Future(() {
        _menuState.accept(isToTop ? MenuType.view : MenuType.url);
        model.updateInteractedState(isInteracted: !isToTop);
      });
    },
  );

  late final _progressIndicatorDelegate =
      BrowserProgressIndicatorUiDelegate(this);

  late final _tabMenuDelegate = BrowserTabMenuUiDelegate(
    model,
    context,
    renderManager: _renderManager,
    createGroup: (String tabId) => _tabsDelegate.createGroup(
      context,
      tabId: tabId,
      originalGroupId: tabs.selectedGroupIdState.value,
    ),
  );

  final _groupMenuDelegate = BrowserGroupMenuUiDelegate();

  final _pastGoDelegate = BrowserPastGoUiDelegate();

  late final _pageSlideDelegate = BrowserPageSlideUiDelegate(
    screenWidth: sizes.screenWidth,
    urlWidth: sizes.urlWidth,
    onChangeSlideIndex: (int tabIndex) {
      if (!_viewVisibleState.value) {
        return;
      }

      Future(() {
        final groupId = model.activeGroupIdState.value;

        if (groupId == null) {
          return;
        }

        final tabId = _tabsDelegate.getIdByIndex(
          groupId: groupId,
          index: tabIndex,
        );

        if (tabId == null || model.activeTabId == tabId) {
          return;
        }

        model.setActiveTab(tabId);

        _progressIndicatorDelegate.reset();
        _updatePastGo();
      });
    },
  );

  late final _tabsDelegate = BrowserTabsAndGroupsUiDelegate(
    context,
    model,
    renderManager: _renderManager,
    onEmptyTabs: _onEmptyTabs,
    onChangeTab: () => _menuState.accept(MenuType.view),
    onUpdateActiveTab: () {
      _progressIndicatorDelegate.reset();
      _updatePastGo();
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

  BrowserPageSlideUi get pageSlider => _pageSlideDelegate;

  BrowserTabsAndGroupsUi get tabs => _tabsDelegate;

  BrowserPastGoUi get pastGo => _pastGoDelegate;

  BrowserAnimationUi get animations => _animationDelegate;

  BrowserProgressIndicatorUi get progressIndicator =>
      _progressIndicatorDelegate;

  BrowserTabMenuUi get tabMenu => _tabMenuDelegate;

  BrowserPageScrollUi get page => _pageDelegate;

  RenderManager<String> get renderManager => _renderManager;

  ListenableState<MenuType> get menuState => _menuState;

  ListenableState<bool> get viewVisibleState => _viewVisibleState;

  ListenableState<List<String>?> get allTabsIdsState => model.allTabsIdsState;

  ListenableState<String?> get activeTabIdState => model.activeTabIdState;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    _menuState.addListener(_handleMenuState);
    _viewVisibleState.addListener(_handleViewVisibleState);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final groupId = model.activeGroupIdState.value;
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
    model.updateInteractedState(isInteracted: false);
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

    tabs.changeTab(
      groupId: groupId,
      tabId: tabId,
    );
  }

  void onPressedCreateNewGroup() {
    _tabsDelegate.createGroup(context);
  }

  void _onEmptyTabs() {
    _pageDelegate.reset();
    _pageSlideDelegate.slideToPage(0);
  }

  void _onTabAnimationComplete(bool isVisible) {
    _viewVisibleState.accept(isVisible);
  }

  void _handleViewVisibleState() {
    _updatePastGo();
  }

  Future<bool> _scrollToTab({
    required String groupId,
    required String tabId,
  }) async {
    final index = _tabsDelegate.getTabIndexById(
      groupId: groupId,
      tabId: tabId,
    );

    if (index != null && index > -1) {
      _pageSlideDelegate.slideToPage(index);

      _pageDelegate.reset();
    }

    return index != null && index > -1;
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
