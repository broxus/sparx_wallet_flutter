import 'dart:collection';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/main/browser_main_screen.dart';
import 'package:app/feature/browserV2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browserV2/screens/main/data/control_panels_data.dart';
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

  ListenableState<BrowserTabsCollection> get tabsState => model.tabsState;

  ListenableState<BrowserTab?> get activeTabState => model.activeTabState;

  ListenableState<bool> get viewVisibleState => _viewVisibleState;

  ListenableState<BrowserControlPanelData> get controlPanelState =>
      _controlPanelState;

  BrowserTab? get _activeTab => activeTabState.value;

  // TODO(knightforce): depending on what opens first - a list or a page
  // TODO(knightforce): if a page - need to skip animations - set the desired view
  late final _viewVisibleState = createNotifier<bool>(
    activeTabState.value != null,
  );

  late final _controlPanelState = createNotifier<BrowserControlPanelData>(
    BrowserControlPanelData(),
  );

  late final urlWidth = screenWidth * .915 + DimensSizeV2.d16;

  late final screenHeight = _screenSize.height;
  late final screenWidth = _screenSize.width;

  late final _screenSize = MediaQuery.of(context).size;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  InAppWebViewController? get _currentController =>
      _controllers[_activeTab?.id];

  @override
  void initWidgetModel() {
    tabsState.addListener(_handleTabsCollection);
    activeTabState.addListener(_handleActiveTab);
    urlSliderController.addListener(_handleUrlPanelScroll);
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

  void onChangeTab(String id) {
    _viewVisibleState.accept(true);
    model.setActiveTab(id);
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
  }

  void onPressedUrlMenu(String tabId) {
    // TODO
  }

  void onPressedRefresh(String tabId) {
    // TODO
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
  }

  void _handleActiveTab() {
    _updateControlPanel();
    // todo перелистнуть пейджер на индекс
    // todo не создавать еще ни разу не показанные WebView
    //
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
      viewMax * urlOffset / urlMax,
    );
  }
}
