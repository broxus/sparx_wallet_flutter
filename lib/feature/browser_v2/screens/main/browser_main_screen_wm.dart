import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/models/tab/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/data/menu_data.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/browser_keys_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/menu_animation_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/page_slide_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/past_go_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/scroll_page_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/size_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/tab_menu_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/url_action_sheet.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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

  late final onWebPageScrollChanged = () {
    void onSuccess(bool isToTop) {
      _menuState.accept(isToTop ? MenuType.view : MenuType.url);
      _visibleNavigationBarState.accept(isToTop);
    }

    return (int y) => _pageDelegate.onWebPageScrollChanged(
          y,
          onSuccess: onSuccess,
        );
  }();

  late final onPointerUp = (() {
    void onSuccess() => resetFocus(context);
    return (PointerUpEvent event) => _pageDelegate.onPointerUp(
          event,
          onSuccess: onSuccess,
        );
  })();

  late final onOverScrolled = (() {
    void onSuccess() => _menuState.accept(MenuType.none);
    return (int y) => _pageDelegate.onOverScrolled(y, onSuccess: onSuccess);
  })();

  final _renderManager = BrowserRenderManager();

  late final _animationDelegate = BrowserMenuAnimationDelegate(this);

  late final _progressController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  late final _viewVisibleState = createNotifier<bool>(
    activeTabState.value != null,
  );

  late final _menuState = createNotifier<MenuType>(
    activeTabState.value != null ? MenuType.view : MenuType.list,
  );

  late final _showAnimationState = createNotifier<TabAnimationType?>();

  late final _visibleNavigationBarState = createNotifier<bool>(true);

  late int _lastTabsCount = _tabsCollection?.count ?? 0;

  late final keys = BrowserKeysDelegate();

  late final sizes = BrowserSizesDelegate(context);

  final _pageDelegate = BrowserPageScrollDelegate();

  late final _tabMenuDelegate = BrowserTabMenuDelegate(
    renderManager: _renderManager,
    onShowMenu: () => _menuState.accept(null),
    onHideMenu: () => _menuState.accept(MenuType.list),
    addUrlToBookmark: model.addUrlToBookmark,
  );

  final _pastGoDelegate = BrowserPastGoDelegate();

  late final _pageSlideDelegate = BrowserPageSlideDelegate(
    screenWidth: sizes.screenWidth,
    urlWidth: sizes.urlWidth,
    onChangeSlideIndex: (int tabIndex) {
      model.setActiveTab(_tabsCollection?.getIdByIndex(tabIndex));
    },
  );

  ScrollController get viewTabScrollController =>
      _pageSlideDelegate.viewTabScrollController;

  ScrollController get urlSliderController =>
      _pageSlideDelegate.urlSliderController;

  RenderManager<String> get renderManager => _renderManager;

  ListenableState<MenuType> get menuState => _menuState;

  ListenableState<TabAnimationType?> get showAnimationState =>
      _showAnimationState;

  BrowserMenuAnimationUi get animation => _animationDelegate;

  AnimationController get progressController => _progressController;

  ListenableState<BrowserTabsCollection> get tabsState => model.tabsState;

  ListenableState<BrowserTab?> get activeTabState => model.activeTabState;

  ListenableState<bool> get viewVisibleState => _viewVisibleState;

  ListenableState<bool> get showPastGoState => _pastGoDelegate.showPastGoState;

  BrowserTab? get _activeTab => activeTabState.value;

  BrowserTabsCollection? get _tabsCollection => tabsState.value;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    tabsState.addListener(_handleTabsCollection);
    activeTabState.addListener(_handleActiveTab);
    _menuState.addListener(_handleMenuState);
    _viewVisibleState.addListener(_handleViewVisibleState);
    _visibleNavigationBarState.addListener(_handleVisibleNavigationBar);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = _activeTab?.id;
      if (id != null) {
        _scrollToTab(id);
      }
    });

    super.initWidgetModel();
  }

  @override
  void dispose() {
    tabsState.removeListener(_handleTabsCollection);
    activeTabState.removeListener(_handleActiveTab);
    model.closeAllControllers();
    _menuState.removeListener(_handleMenuState);
    _progressController.dispose();
    _animationDelegate.dispose();
    _renderManager.dispose();
    _pastGoDelegate.dispose();
    _pageSlideDelegate.dispose();
    super.dispose();
  }

  void onCreateWebViewController(
    String tabId,
    InAppWebViewController controller,
  ) {
    model.setController(tabId, controller);
  }

  void onDisposeWebController(String tabId) {
    model.removeController(tabId);
  }

  void onChangeTab(String id) {
    _changeTab(id);
  }

  void onCloseTab(String id) {
    model.removeBrowserTab(id);
  }

  void onCloseAllPressed() {
    model.clearTabs();
  }

  void onPlusPressed() {
    model.createEmptyTab();
  }

  void onDonePressed() {
    final id = _activeTab?.id;
    final data = id == null ? null : _renderManager.getRenderData(id);

    _showAnimationState.accept(
      ShowViewAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );

    _menuState.accept(MenuType.view);
  }

  void onPointerDown(PointerDownEvent event) =>
      _pageDelegate.onPointerDown(event);

  void onPointerCancel(_) => _pageDelegate.onPointerCancel();

  void onPressedTabs() {
    final id = _activeTab?.id;
    final data = id == null ? null : _renderManager.getRenderData(id);

    _showAnimationState.accept(
      ShowTabsAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );

    _menuState.accept(MenuType.list);
  }

  Future<void> onPressedTabMenu(
    BrowserTab tab,
  ) =>
      _tabMenuDelegate.showTabMenu(
        context,
        tab,
      );

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
        onSuccess: (String text) => model.requestUrl(_activeTab?.id, text),
      );

  void onEditingCompleteUrl(String tabId, String text) {
    if (text.trim().isEmpty) {
      return;
    }

    model.requestUrl(tabId, text);
  }

  void onTabAnimationStart() {
    if (_showAnimationState.value == null) {
      return;
    }
    if (_showAnimationState.value is ShowTabsAnimationType) {
      _viewVisibleState.accept(false);
    }
  }

  void onTabAnimationEnd() {
    if (_showAnimationState.value == null) {
      return;
    }

    if (_showAnimationState.value is ShowViewAnimationType) {
      _viewVisibleState.accept(true);
    }

    _showAnimationState.accept(null);
  }

  bool onScrollNotification(ScrollNotification notification) =>
      _pageSlideDelegate.onScrollNotification(notification);

  void _handleTabsCollection() {
    final count = _tabsCollection?.count ?? 0;
    if (_tabsCollection?.isNotEmpty ?? true) {
      final id = _tabsCollection!.lastTab!.id;
      if (count > _lastTabsCount) {
        _changeTab(id);
      }
    } else {
      model.createEmptyTab();
      _pageDelegate.reset();
      _pageSlideDelegate.slideTo(0);
      _viewVisibleState.accept(true);
      _menuState.accept(MenuType.view);
    }

    _lastTabsCount = count;
  }

  void _handleActiveTab() {
    _progressController.reset();
    _updatePastGo();
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

  bool _scrollToTab(String id) {
    final index = _tabsCollection?.getIndexById(id);

    if (index != null && index > -1) {
      _pageSlideDelegate.slideTo(sizes.urlWidth * index + 50);
      _pageDelegate.reset();
    }

    return index != null && index > -1;
  }

  void _changeTab(String id) {
    if (_tabsCollection == null) {
      return;
    }

    if (id != _activeTab?.id) {
      final isSuccess = _scrollToTab(id);
      if (isSuccess) {
        model.setActiveTab(id);
      }
    }

    final data = _renderManager.getRenderData(id);

    _showAnimationState.accept(
      ShowViewAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );

    _menuState.accept(MenuType.view);
  }

  void _handleMenuState() {
    _animationDelegate.handleMenuType(_menuState.value);
  }

  Future<void> _updatePastGo() async {
    _pastGoDelegate.updateVisible(
      (_viewVisibleState.value ?? false) &&
          (_activeTab?.url.toString().isEmpty ?? false) &&
          await checkExistClipBoardData(),
    );
  }
}
