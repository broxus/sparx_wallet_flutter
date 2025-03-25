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
import 'package:app/feature/browser_v2/screens/main/helpers/menu_animation_helper.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_menu/data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_menu/tab_menu.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/url_menu.dart';
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

  final tabListKey = UniqueKey();
  final tabViewKey = UniqueKey();
  final listKey = UniqueKey();
  final viewKey = UniqueKey();
  final urlKey = UniqueKey();

  late final viewTabScrollController = createScrollController();
  late final urlSliderController = createScrollController();

  late final urlWidth = screenWidth * .915 + DimensSizeV2.d16;

  late final screenHeight = _screenSize.height;
  late final screenWidth = _screenSize.width;

  final _renderManager = BrowserRenderManager();

  late final _animation = MenuAnimationHelperImpl(this);

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

  late final _showPastGoState = createNotifier<bool>(true);

  late final _screenSize = MediaQuery.of(context).size;

  late int _lastTabsCount = _tabsCollection?.count ?? 0;

  Offset? _downPosition;
  int _prevYScroll = 0;

  RenderManager<String> get renderManager => _renderManager;

  ListenableState<MenuType> get menuState => _menuState;

  ListenableState<TabAnimationType?> get showAnimationState =>
      _showAnimationState;

  MenuAnimationHelper get animation => _animation;

  AnimationController get progressController => _progressController;

  ListenableState<BrowserTabsCollection> get tabsState => model.tabsState;

  ListenableState<BrowserTab?> get activeTabState => model.activeTabState;

  ListenableState<bool> get viewVisibleState => _viewVisibleState;

  ListenableState<bool> get showPastGoState => _showPastGoState;

  BrowserTab? get _activeTab => activeTabState.value;

  BrowserTabsCollection? get _tabsCollection => tabsState.value;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    tabsState.addListener(_handleTabsCollection);
    activeTabState.addListener(_handleActiveTab);
    urlSliderController.addListener(_handleUrlPanelScroll);
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
    _animation.dispose();
    _renderManager.dispose();
    super.dispose();
  }

  void onCreateWebViewController(
      String tabId, InAppWebViewController controller) {
    model.setController(tabId, controller);
  }

  void onDisposeWebController(String tabId) {
    model.removeController(tabId);
  }

  void onScrollChanged(int y) {
    final diff = _prevYScroll - y;

    if (diff > -100 && diff < 100) {
      return;
    }

    final isVisibleMenu = diff >= 0;

    _menuState.accept(isVisibleMenu ? MenuType.view : MenuType.url);
    _visibleNavigationBarState.accept(isVisibleMenu);

    _prevYScroll = y;
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

    if (data == null) {
      _viewVisibleState.accept(true);
    } else {
      _showAnimationState.accept(
        ShowViewAnimationType(
          tabX: data.xLeft,
          tabY: data.yTop,
        ),
      );
    }

    _menuState.accept(MenuType.view);
  }

  void onPointerDown(PointerDownEvent event) {
    _downPosition = event.position;
  }

  void onPointerUp(PointerUpEvent event) {
    if (_downPosition == null) {
      return;
    }

    if (event.position.dx > _downPosition!.dx + 10 ||
        event.position.dx < _downPosition!.dx - 10 ||
        event.position.dy > _downPosition!.dy + 10 ||
        event.position.dy < _downPosition!.dy - 10) {
      return;
    }

    resetFocus(context);
  }

  void onPressedTabs() {
    final id = _activeTab?.id;
    final data = id == null ? null : _renderManager.getRenderData(id);

    if (data == null) {
      _viewVisibleState.accept(false);
    } else {
      _showAnimationState.accept(
        ShowTabsAnimationType(
          tabX: data.xLeft,
          tabY: data.yTop,
        ),
      );
    }

    _menuState.accept(MenuType.list);
  }

  Future<void> onPressedTabMenu(BrowserTab tab) async {
    final data = _renderManager.getRenderData(tab.id);

    if (data == null) {
      return;
    }

    final menuValue = _menuState.value;

    _menuState.accept(null);
    primaryBus.fire(HideNavigationEvent());

    final result = await showBrowserTabMenu(context, data);

    _menuState.accept(menuValue);
    primaryBus.fire(RevertNavigationEvent());

    switch (result) {
      case BrowserTabMenuItemData.copyLink:
        unawaited(
          setClipBoardData(
            tab.url.toString(),
          ),
        );
      case BrowserTabMenuItemData.pinTab:
      // TODO(knightforce): handle
      case BrowserTabMenuItemData.bookmark:
        model.addUrlToBookmark(tab.id);
      case BrowserTabMenuItemData.newTabGroup:
      // TODO(knightforce): handle
      case null:
    }
  }

  Future<void> onPressedCurrentUrlMenu(String tabId) async {
    final result = await showUrlMenu(context);

    if (result == null) {
      return;
    }

    switch (result) {
      case BrowserUrlMenuValue.copyUrl:
        model.copyTabUrl(tabId);
      case BrowserUrlMenuValue.addBookmark:
        model.addUrlToBookmark(tabId);
      case BrowserUrlMenuValue.clearFromHistory:
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

  Future<void> onPastGoPressed() async {
    final text = await getClipBoardText();
    if (text == null) {
      return;
    }

    final id = _activeTab?.id;

    if (id != null) {
      model.requestUrl(id, text);
    }
  }

  void onEditingCompleteUrl(String tabId, String text) {
    model.requestUrl(tabId, text);
  }

  void onTabAnimationStart() {
    if (_showAnimationState.value is ShowTabsAnimationType) {
      _viewVisibleState.accept(false);
    }
  }

  void onTabAnimationEnd() {
    if (_showAnimationState.value is ShowViewAnimationType) {
      _viewVisibleState.accept(true);
    }

    _showAnimationState.accept(null);
  }

  void _handleTabsCollection() {
    final count = _tabsCollection?.count ?? 0;
    if (_tabsCollection?.isNotEmpty ?? true) {
      final id = _tabsCollection!.lastTab!.id;
      if (count > _lastTabsCount) {
        _changeTab(id);
      }
    } else {
      model.createEmptyTab();
      _prevYScroll = 0;
      urlSliderController.jumpTo(0);
      _viewVisibleState.accept(true);
      _menuState.accept(MenuType.view);
    }

    _lastTabsCount = count;
  }

  void _handleActiveTab() {
    _progressController.reset();
    _updatePastGo();
  }

  void _handleUrlPanelScroll() {
    final urlOffset = urlSliderController.offset;
    final urlMax = urlSliderController.position.maxScrollExtent;
    final viewMax = viewTabScrollController.position.maxScrollExtent;

    final tabIndex = ((viewMax - (viewMax - urlOffset)) / urlWidth).round();

    final id = _tabsCollection?.getIdByIndex(tabIndex);

    if (id != null) {
      model.setActiveTab(id);
    }

    final x = viewMax * urlOffset / urlMax;

    if (x == 0) {
      viewTabScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
    } else if (!x.isNaN) {
      viewTabScrollController.jumpTo(x);
    }
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
    final index = _tabsCollection!.getIndexById(id);

    if (index > -1) {
      urlSliderController.jumpTo(urlWidth * index + 50);
      _prevYScroll = 0;
    }

    return index > -1;
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

    if (data == null) {
      _viewVisibleState.accept(true);
    } else {
      _showAnimationState.accept(
        ShowViewAnimationType(
          tabX: data.xLeft,
          tabY: data.yTop,
        ),
      );
    }

    _menuState.accept(MenuType.view);
  }

  void _handleMenuState() {
    _animation.handleMenuType(_menuState.value);
  }

  Future<void> _updatePastGo() async {
    _showPastGoState.accept(
      (_viewVisibleState.value ?? false) &&
          (_activeTab?.url.toString().isEmpty ?? false) &&
          await checkExistClipBoardData(),
    );
  }
}
