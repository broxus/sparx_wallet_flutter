import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/data/menu_data.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_animation_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_browser_keys_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_group_menu_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_overlay_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_page_slide_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_past_go_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_progress_indicator_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_scroll_page_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_size_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_tab_menu_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/ui_tabs_and_groups_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/browser_progress_indicator.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/host_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/url_action_sheet.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/page_control_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/tabs_list_action_bar.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/menu_animation.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/past_go.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:app/utils/common_utils.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// [WidgetModel] для [BrowserMainScreen]
@injectable
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
        resetFocus(contextSafe);
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

  late final _pastGoDelegate = BrowserPastGoUiDelegate(model);

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
    scrollToPage: _scrollToPage,
    checkIsVisiblePages: () => _viewVisibleState.value,
  );

  final _overlayDelegate = BrowserOverlayUiDelegate();

  late final _viewVisibleState = createNotNullNotifier<bool>(
    model.activeTabId != null,
  );

  late final _menuState = createNotifier<MenuType>(
    model.activeTabId != null ? MenuType.view : MenuType.list,
  );

  BrowserPageSlideUi get pageSlider => _pageSlideDelegate;

  BrowserTabsAndGroupsUi get tabs => _tabsDelegate;

  BrowserAnimationUi get animations => _animationDelegate;

  BrowserProgressIndicatorUi get progressIndicator =>
      _progressIndicatorDelegate;

  BrowserTabMenuUi get tabMenu => _tabMenuDelegate;

  BrowserPageScrollUi get page => _pageDelegate;

  RenderParametersManager<String> get renderManager => _renderManager;

  ListenableState<bool> get viewVisibleState => _viewVisibleState;

  ListenableState<List<String>?> get allTabsIdsState => model.allTabsIdsState;

  ListenableState<String?> get activeTabIdState => model.activeTabIdState;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _menuState.addListener(_handleMenuState);
    _viewVisibleState.addListener(_updatePastGo);
    model.activeTabUrlHostState.addListener(_updatePastGo);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final groupId = model.activeGroupIdState.value;
      final tabId = _tabsDelegate.activeTabId;

      _initOverlay();

      if (groupId != null && tabId != null) {
        _scrollToPage(
          groupId: groupId,
          tabId: tabId,
        );
      }
      _scrollToActiveTabInList(
        const Duration(milliseconds: 100),
      );
    });
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
    _overlayDelegate.dispose();
    model.activeTabUrlHostState.removeListener(_updatePastGo);
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
      onPressedCreateTab: _onPressedCreateTab,
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

  void _initOverlay() {
    _overlayDelegate.init(
      context,
      indicatorBuilder: (_) => BrowserProgressIndicator(
        animation: progressIndicator.animation,
        menuState: _menuState,
      ),
      menuListBuilder: (_) => MenuAnimation(
        controller: animations.listMenuAnimation,
        offsetAnimation: animations.listMenuOffsetAnimation,
        opacityAnimation: animations.listMenuOpacityAnimation,
        child: BrowserTabsListActionBar(
          key: keys.listKey,
          allTabsIdsState: allTabsIdsState,
          activeTabIdState: activeTabIdState,
          onCloseAllPressed: tabs.onCloseAllPressed,
          onGroupsMenuPressed: onGroupsMenuPressed,
          onPlusPressed: tabs.addTab,
          onDonePressed: onDonePressed,
        ),
      ),
      menuPageBuilder: (_) => MenuAnimation(
        controller: animations.viewMenuAnimation,
        offsetAnimation: animations.viewMenuOffsetAnimation,
        opacityAnimation: animations.viewMenuOpacityAnimation,
        child: NotificationListener<ScrollNotification>(
          onNotification: pageSlider.onScrollNotification,
          child: BrowserPageControlPanel(
            key: keys.viewKey,
            menuUrlPanelWidth: sizes.screenWidth,
            urlWidth: sizes.urlWidth,
            onPressedDotsPressed: onPressedDotsPressed,
            onPressedTabs: onPressedTabs,
            onPressedCurrentUrlMenu: onPressedCurrentUrlMenu,
            onPressedRefresh: onPressedRefresh,
            onEditingCompleteUrl: onEditingCompleteUrl,
            urlSliderPageController: pageSlider.urlSliderPageController,
            tabsState: tabs.viewTabsState,
            onPageChanged: pageSlider.onPageChanged,
          ),
        ),
      ),
      menuHostBuilder: (_) => MenuAnimation(
        controller: animations.urlMenuAnimation,
        offsetAnimation: animations.urlMenuOffsetAnimation,
        opacityAnimation: animations.urlMenuOpacityAnimation,
        child: HostPanel(
          tabs.hostState,
          key: keys.urlKey,
          onPressed: onPressedViewUrlPanel,
        ),
      ),
      pastGoBuilder: (_) => PastGoView(
        showState: _pastGoDelegate.showPastGoState,
        onPressed: _pastGoDelegate.onPastGoPressed,
      ),
      tabAnimatedViewBuilder: (_) => TabAnimatedView(
        onAnimationStart: onTabAnimationStart,
        onAnimationEnd: onTabAnimationEnd,
        showAnimationState: tabs.tabAnimationTypeState,
      ),
    );
  }

  void _onEmptyTabs() {
    _pageDelegate.reset();
    _pageSlideDelegate.slideToPage(0);
  }

  void _onTabAnimationComplete(bool isVisible) {
    _viewVisibleState.accept(isVisible);
    if (!isVisible) {
      _scrollToActiveTabInList();
    }
  }

  Future<bool> _scrollToPage({
    required String groupId,
    required String tabId,
    bool isAnimated = false,
  }) async {
    final index = _tabsDelegate.getTabIndexById(
      groupId: groupId,
      tabId: tabId,
    );

    if (index != null && index > -1) {
      _pageSlideDelegate.slideToPage(
        index,
        isAnimated: isAnimated,
      );

      _pageDelegate.reset();
    }

    return index != null && index > -1;
  }

  void _handleMenuState() {
    _animationDelegate.handleMenuType(
      _menuState.value,
      duration: Duration.zero,
    );
    resetFocus(contextSafe);
  }

  Future<void> _updatePastGo() async {
    _pastGoDelegate.updateVisible(
      (_viewVisibleState.value) &&
          (model.activeTabUrlHostState.value?.isEmpty ?? false) &&
          await checkExistClipBoardData(),
    );
  }

  void _onPressedCreateTab(String groupId, String tabId) {
    callWithDelay(
      () => _scrollToPage(
        groupId: groupId,
        tabId: tabId,
        isAnimated: true,
      ),
    );
  }

  void _scrollToActiveTabInList([Duration delay = Duration.zero]) {
    try {
      final activeTabId = model.activeTabIdState.value;
      final tabsItems = tabs.viewTabsState.value;

      if (activeTabId == null ||
          tabsItems == null ||
          tabs.selectedGroupIdState.value != model.activeGroupIdState.value) {
        return;
      }

      final maxOffset = tabs.tabListScrollController.position.maxScrollExtent;

      var activeIndex = 0;

      for (var i = 0; i < tabsItems.length; i++) {
        if (tabsItems[i].value.id == activeTabId) {
          activeIndex = i;
          break;
        }
      }

      double offset = 0;

      if (activeIndex == tabsItems.length - 1) {
        offset = maxOffset;
      } else if (activeIndex > 0) {
        final lineIndex = activeIndex == 0 ? 0 : (activeIndex / 2).floor();
        final itemSize = maxOffset / (tabsItems.length / 2).ceil();

        offset = itemSize * lineIndex;
      }

      _tabsDelegate.scrollTabList(offset);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }
}
