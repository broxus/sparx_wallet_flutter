import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/data/menu_data.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/animation_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/browser_keys_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/page_slide_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/past_go_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/progress_indicator_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/scroll_page_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/size_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/tab_menu_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/delegates/tabs_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/url_action_sheet.dart';
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

  late final keys = BrowserKeysDelegate();

  late final sizes = BrowserSizesDelegate(context);

  final _renderManager = BrowserRenderManager();

  late final _animationDelegate = BrowserAnimationDelegate(this);

  late final _progressIndicatorDelegate =
      BrowserProgressIndicatorDelegate(this);

  final _pageDelegate = BrowserPageScrollDelegate();

  late final _tabMenuDelegate = BrowserTabMenuDelegate(
    model,
    context,
    renderManager: _renderManager,
    onShowMenu: () => _menuState.accept(null),
    onHideMenu: () => _menuState.accept(MenuType.list),
  );

  final _pastGoDelegate = BrowserPastGoDelegate();

  late final _pageSlideDelegate = BrowserPageSlideDelegate(
    screenWidth: sizes.screenWidth,
    urlWidth: sizes.urlWidth,
    onChangeSlideIndex: (int tabIndex) {
      model.setActiveTab(_tabsDelegate.getIdByIndex(tabIndex));
    },
  );

  late final _tabsDelegate = BrowserTabsDelegate(
    model,
    renderManager: _renderManager,
    onEmptyTabs: _onEmptyTabs,
    scrollToTab: _scrollToTab,
    onChangeTab: _onChangeTab,
    onUpdateActiveTab: () {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          _progressIndicatorDelegate.reset();
          _updatePastGo();
        },
      );
    },
  );

  late final _viewVisibleState = createNotifier<bool>(
    _tabsDelegate.activeTabState.value != null,
  );

  late final _menuState = createNotifier<MenuType>(
    _tabsDelegate.activeTabState.value != null ? MenuType.view : MenuType.list,
  );

  late final _visibleNavigationBarState = createNotifier<bool>(true);

  BrowserPageSlideUi get pageSlider => _pageSlideDelegate;

  BrowserTabsUi get tabs => _tabsDelegate;

  BrowserPastGoUi get pastGo => _pastGoDelegate;

  BrowserAnimationUi get animations => _animationDelegate;

  BrowserProgressIndicatorUi get progressIndicator =>
      _progressIndicatorDelegate;

  BrowserTabMenuUi get tabMenu => _tabMenuDelegate;

  RenderManager<String> get renderManager => _renderManager;

  ListenableState<MenuType> get menuState => _menuState;

  ListenableState<bool> get viewVisibleState => _viewVisibleState;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    _menuState.addListener(_handleMenuState);
    _viewVisibleState.addListener(_handleViewVisibleState);
    _visibleNavigationBarState.addListener(_handleVisibleNavigationBar);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = _tabsDelegate.activeTabId;
      if (id != null) {
        _scrollToTab(id);
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
    InAppWebViewController controller,
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

  void onPointerDown(PointerDownEvent event) =>
      _pageDelegate.onPointerDown(event);

  void onPointerCancel(_) => _pageDelegate.onPointerCancel();

  void onWebPageScrollChanged(int y) => _pageDelegate.onWebPageScrollChanged(
        y,
        onSuccess: _onWebPageScrollChangedSuccess,
      );

  void onPointerUp(PointerUpEvent event) => _pageDelegate.onPointerUp(
        event,
        onSuccess: resetFocus,
      );

  void onPressedTabs() {
    _tabsDelegate.animateShowTabs();
    _menuState.accept(MenuType.list);
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

  void onTabAnimationEnd() => _tabsDelegate.onTabAnimationEnd(
        _onTabAnimationComplete,
      );

  void _onWebPageScrollChangedSuccess(bool isToTop) {
    _menuState.accept(isToTop ? MenuType.view : MenuType.url);
    _visibleNavigationBarState.accept(isToTop);
  }

  void _onEmptyTabs() {
    model.createEmptyTab();
    _pageDelegate.resetVerticalScroll();
    _pageSlideDelegate.slideTo(0);
    _viewVisibleState.accept(true);
    _menuState.accept(MenuType.view);
  }

  void _onChangeTab() => _menuState.accept(MenuType.view);

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

  bool _scrollToTab(String id) {
    final index = _tabsDelegate.getTabIndexById(id);

    if (index != null && index > -1) {
      _pageSlideDelegate.slideTo(sizes.urlWidth * index + 50);
      _pageDelegate.resetVerticalScroll();
    }

    return index != null && index > -1;
  }

  void _handleMenuState() {
    _animationDelegate.handleMenuType(_menuState.value);
  }

  Future<void> _updatePastGo() async {
    _pastGoDelegate.updateVisible(
      (_viewVisibleState.value ?? false) &&
          (_tabsDelegate.isEmptyActiveTabUrl) &&
          await checkExistClipBoardData(),
    );
  }
}
