import 'dart:collection';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/main/browser_main_screen.dart';
import 'package:app/feature/browserV2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browserV2/screens/main/data/control_panels_data.dart';
import 'package:app/feature/browserV2/screens/main/data/menu_data.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
    extends CustomWidgetModel<BrowserMainScreen, BrowserMainScreenModel> {
  BrowserMainScreenWidgetModel(
    super.model,
  );

  final tabListKey = UniqueKey();
  final tabViewKey = UniqueKey();

  late final viewTabScrollController = createScrollController();
  late final urlSliderController = createScrollController();

  final _controllers = HashMap<String, InAppWebViewController>();

  late final _viewVisibleState = createNotifier<bool>(
    activeTabState.value != null,
  );

  late final _menuState = createNotifier<MenuType>(
    activeTabState.value != null ? MenuType.view : MenuType.list,
  );

  late final _controlPanelState = createNotifier<BrowserControlPanelData>(
    BrowserControlPanelData(),
  );

  late final _visibleNavigationBarState = createNotifier<bool>(true);

  late final urlWidth = screenWidth * .915 + DimensSizeV2.d16;

  late final screenHeight = _screenSize.height;
  late final screenWidth = _screenSize.width;

  late final _screenSize = MediaQuery.of(context).size;

  ListenableState<BrowserTabsCollection> get tabsState => model.tabsState;

  ListenableState<BrowserTab?> get activeTabState => model.activeTabState;

  ListenableState<bool> get viewVisibleState => _viewVisibleState;

  ListenableState<MenuType> get menuState => _menuState;

  ListenableState<BrowserControlPanelData> get controlPanelState =>
      _controlPanelState;

  BrowserTab? get _activeTab => activeTabState.value;

  BrowserTabsCollection? get _tabsCollection => tabsState.value;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  InAppWebViewController? get _currentController =>
      _controllers[_activeTab?.id];

  @override
  void initWidgetModel() {
    tabsState.addListener(_handleTabsCollection);
    activeTabState.addListener(_handleActiveTab);
    urlSliderController.addListener(_handleUrlPanelScroll);
    _visibleNavigationBarState.addListener(_handleVisibleNavigationBar);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    tabsState.removeListener(_handleTabsCollection);
    activeTabState.removeListener(_handleActiveTab);
    _controllers
      ..forEach((k, c) => c.dispose())
      ..clear();
    super.dispose();
  }

  void onCreateController(String tabId, InAppWebViewController controller) {
    _controllers[tabId] = controller;
  }

  void onDisposeController(String tabId) {
    _controllers.remove(tabId);
  }

  int _prevYScroll = 0;

  void onScrollChanged(int y) {
    final isVisibleMenu = _prevYScroll - y >= 0;

    _menuState.accept(isVisibleMenu ? MenuType.view : MenuType.url);
    _visibleNavigationBarState.accept(isVisibleMenu);

    _prevYScroll = y;
  }

  void onChangeTab(String id) {
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

  Offset? _downPosition;

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

  void onPressedBackPressed() {
    // TODO
  }

  void onPressedForwardPressed() {
    // TODO
  }

  void onPressedDotsPressed() {
    // TODO
  }

  void onPressedBook() {
    // TODO
  }

  void onPressedTabs() {
    _viewVisibleState.accept(false);
    _menuState.accept(MenuType.list);
  }

  void onPressedUrlMenu(String tabId) {
    // TODO
  }

  void onPressedRefresh(String tabId) {
    // TODO
  }

  void onPressedMenuUrl() {
    _menuState.accept(MenuType.view);
    _visibleNavigationBarState.accept(true);
  }

  void onEditingCompleteUrl(String tabId, String text) {
    // TODO
  }

  void goBack() {
    _currentController?.goBack();
  }

  void goForward() {
    _currentController?.goForward();
  }

  void refresh() {
    _currentController?.reload();
  }

  void _handleTabsCollection() {
    if (tabsState.value?.list.isNotEmpty ?? true) {
      return;
    }

    model.createEmptyTab();
    _prevYScroll = 0;
    urlSliderController.jumpTo(0);
    _viewVisibleState.accept(true);
    _menuState.accept(MenuType.view);
  }

  void _handleActiveTab() {
    _updateControlPanel();
  }

  Future<void> _updateControlPanel() async {
    final controller = _currentController;

    _controlPanelState.accept(
      BrowserControlPanelData(
        isCanGoBack: await controller?.canGoBack(),
        isCanGoForward: await controller?.canGoForward(),
      ),
    );
  }

  void _handleUrlPanelScroll() {
    final urlOffset = urlSliderController.offset;
    final urlMax = urlSliderController.position.maxScrollExtent;
    final viewMax = viewTabScrollController.position.maxScrollExtent;

    viewTabScrollController.jumpTo(
      viewMax * urlOffset / urlMax + (screenWidth - urlWidth) / 2,
    );
  }

  void _handleVisibleNavigationBar() {
    primaryBus.fire(
      _visibleNavigationBarState.value ?? true
          ? RevertNavigationEvent()
          : HideNavigationEvent(),
    );
  }
}
