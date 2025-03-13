import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/main/browser_main_screen.dart';
import 'package:app/feature/browserV2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browserV2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browserV2/screens/main/data/menu_data.dart';
import 'package:app/feature/browserV2/screens/main/helpers/menu_animation_helper.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_menu/data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_menu/tab_menu.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
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
    with
        // SystemButtonWmMixin,
        TickerProviderWidgetModelMixin {
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

  late final _visibleNavigationBarState = createNotifier<bool>(true);

  late final _screenSize = MediaQuery.of(context).size;

  late final _urlOffset = (screenWidth - urlWidth) / 2;

  late int _lastTabsCount = _tabsCollection?.count ?? 0;

  Offset? _downPosition;
  int _prevYScroll = 0;

  RenderManager<String> get renderManager => _renderManager;

  ListenableState<MenuType> get menuState => _menuState;

  MenuAnimationHelper get animation => _animation;

  AnimationController get progressController => _progressController;

  ListenableState<BrowserTabsCollection> get tabsState => model.tabsState;

  ListenableState<BrowserTab?> get activeTabState => model.activeTabState;

  ListenableState<bool> get viewVisibleState => _viewVisibleState;

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
    _visibleNavigationBarState.addListener(_handleVisibleNavigationBar);
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

  void onCreateController(String tabId, InAppWebViewController controller) {
    model.setController(tabId, controller);
  }

  void onDisposeController(String tabId) {
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

  void onChangeTab(String id) => _changeTab(id);

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
    _viewVisibleState.accept(true);
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
    _viewVisibleState.accept(false);
    _menuState.accept(MenuType.list);
  }

  Future<void> onPressedTabMenu(BrowserTab tab) async {
    final data = _renderManager.getRenderData(tab.id);

    if (data == null) {
      return;
    }

    final result = await BrowserTabMenu.show(context, data);

    // TODO(knightforce): handle menu
    switch (result) {
      case BrowserTabMenuItemData.copyLink:
        unawaited(
          Clipboard.setData(
            ClipboardData(
              text: tab.url.toString(),
            ),
          ),
        );
      case BrowserTabMenuItemData.pinTab:
      case BrowserTabMenuItemData.bookmark:
      case BrowserTabMenuItemData.newTabGroup:
      case null:
    }
  }

  void onPressedUrlMenu(String tabId) {
    // TODO(knightforce): create logic
  }

  void onPressedRefresh(String tabId) {
    // TODO(knightforce): create logic
  }

  void onPressedMenuUrl() {
    _menuState.accept(MenuType.view);
    _visibleNavigationBarState.accept(true);
  }

  void onEditingCompleteUrl(String tabId, String text) {
    model.requestUrl(tabId, text);
  }

  void refresh() {
    // _currentController?.reload();
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

    viewTabScrollController.jumpTo(
      viewMax * urlOffset / urlMax + _urlOffset,
    );
  }

  void _handleVisibleNavigationBar() {
    primaryBus.fire(
      _visibleNavigationBarState.value ?? true
          ? RevertNavigationEvent()
          : HideNavigationEvent(),
    );
  }

  void _changeTab(String id) {
    if (_tabsCollection == null) {
      return;
    }

    if (id != _activeTab?.id) {
      final index = _tabsCollection!.getIndexById(id);

      if (index > -1) {
        urlSliderController.jumpTo(urlWidth * index + 50);
        model.setActiveTab(id);
        _prevYScroll = 0;
      }
    }

    _viewVisibleState.accept(true);
    _menuState.accept(MenuType.view);
  }

  void _handleMenuState() {
    _animation.handleMenuType(_menuState.value);
  }
}
