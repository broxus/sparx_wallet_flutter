import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/browser_tab.dart';
import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/feature/browser_v2/managers/tabs/helpers/browser_screen_shooter.dart';
import 'package:app/feature/browser_v2/screens/main/data/toolbar_data.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

class BrowserTabsManager {
  BrowserTabsManager(
    this._browserTabsStorageService,
    this._generalStorageService,
  );

  static final _emptyUri = Uri.parse('');

  final BrowserTabsStorageService _browserTabsStorageService;
  final GeneralStorageService _generalStorageService;

  late final _screenShooter =
      BrowserManagerScreenShooter(_generalStorageService);

  /// Subject of browser tabs
  final _tabsState =
      StateNotifier<BrowserTabsCollection>(initValue: BrowserTabsCollection());

  late final _controlPanelState = StateNotifier<ToolbarData>(
    initValue: ToolbarData(),
  );

  final _activeTabState = StateNotifier<BrowserTab?>();

  final _controllers = HashMap<String, CustomWebViewController>();

  ListenableState<BrowserTabsCollection> get tabsState => _tabsState;

  ListenableState<BrowserTab?> get activeTabState => _activeTabState;

  ListenableState<ImageCache?> get screenshotsState =>
      _screenShooter.screenshotsState;

  ListenableState<ToolbarData> get controlPanelState => _controlPanelState;

  /// Get last cached browser tabs
  List<BrowserTab> get browserTabs => _tabsCollection.list;

  BrowserTab? get activeTab => _activeTabState.value;

  String? get activeTabId => activeTab?.id;

  BrowserTabsCollection get _tabsCollection =>
      _tabsState.value ?? BrowserTabsCollection();

  CustomWebViewController? get _currentController => _controllers[activeTabId];

  String? get activeTabScreenshotPath {
    return activeTabId == null
        ? null
        : _screenShooter.getScreenShotById(activeTabId!);
  }

  void init() {
    activeTabState.addListener(_handleActiveTab);
    _fetchTabsDataFromCache();
  }

  void dispose() {
    activeTabState.removeListener(_handleActiveTab);
    _tabsState.dispose();
    _screenShooter.dispose();
  }

  void setController(String tabId, CustomWebViewController controller) {
    _controllers[tabId] = controller;
  }

  void removeController(String tabId) {
    _controllers.remove(tabId);
  }

  void refresh(String tabId) {
    _controllers[tabId]?.reload();
  }

  void refreshActiveTab() {
    _controllers[activeTabId]?.reload();
  }

  void closeAllControllers() {
    _controllers
      ..forEach((k, c) => c.dispose())
      ..clear();
  }

  Future<void> clear() {
    return clearTabs();
  }

  bool updateCachedUrl(String tabId, Uri uri) {
    final tabs = [...browserTabs];

    final index = tabs.indexWhere((t) => t.id == tabId);

    if (index == -1) {
      return false;
    }

    tabs[index] = tabs[index].copyWith(url: uri);

    _setTabs(tabs: tabs);

    if (tabs[index].id == activeTabId) {
      _activeTabState.accept(tabs[index]);
    }

    // Simple update - request on vew
    unawaited(_updateControlPanel());
    return true;
  }

  Future<void> requestUrl(String tabId, Uri uri) async {
    final resultUri = uri.scheme.isEmpty ? Uri.parse('https://$uri') : uri;

    final isSuccess = updateCachedUrl(tabId, resultUri);

    if (!isSuccess) {
      return;
    }

    await _controllers[tabId]?.loadUrl(
      urlRequest: URLRequest(url: WebUri.uri(resultUri)),
    );
    // After simple update - request by program
    unawaited(_updateControlPanel());
  }

  Future<void> requestUrlActiveTab(Uri uri) async {
    final id = activeTabId;

    if (id == null) {
      return;
    }

    return requestUrl(id, uri);
  }

  void updateTitle(String tabId, String title) {
    final tabs = [...browserTabs];

    final index = tabs.indexWhere((t) => t.id == tabId);

    if (index == -1) {
      return;
    }

    tabs[index] = tabs[index].copyWith(title: title);

    _setTabs(tabs: tabs);

    if (tabs[index].id == activeTabId) {
      _activeTabState.accept(tabs[index]);
    }
  }

  /// Clear all browser tabs
  Future<void> clearTabs() async {
    await _browserTabsStorageService.clear();
    await _screenShooter.clear();
    _tabsState.accept(BrowserTabsCollection());
    _activeTabState.accept(null);
  }

  void setActiveTab(String? id) {
    if (id == activeTabId) {
      return;
    }

    _setTabs(activeTabId: id);
  }

  /// Remove browser tab by id
  Future<void> removeBrowserTab(String id) async {
    final tabs = [...browserTabs];

    final count = tabs.length;

    int? removedIndex;

    for (var i = 0; i < count; i++) {
      if (tabs[i].id != id) {
        continue;
      }

      removedIndex = i;
      break;
    }

    if (removedIndex == null) {
      return;
    }

    final removedId = tabs.removeAt(removedIndex).id;

    final newActiveTabId = tabs.isEmpty
        ? null
        : removedId == activeTabId
            ? tabs[min(removedIndex + 1, tabs.length - 1)].id
            : null;

    await _screenShooter.removeScreenshot(id);

    _setTabs(
      tabs: tabs,
      activeTabId: newActiveTabId,
    );
  }

  String createEmptyTab() => createBrowserTab(_emptyUri);

  void openUrl(Uri url) {
    final lastTab = browserTabs.lastOrNull;
    if (lastTab != null && lastTab.url.toString().isEmpty) {
      requestUrl(lastTab.id, url);
    } else {
      createBrowserTab(url);
    }
  }

  String createBrowserTab(Uri url) {
    final tab = BrowserTab.create(url: url);
    _setTabs(
      tabs: [...browserTabs, tab],
      activeTabId: tab.id,
    );

    return tab.id;
  }

  Future<void> createScreenshot({
    required String tabId,
    required Future<Uint8List?> Function() takePictureCallback,
  }) =>
      _screenShooter.createScreenshot(
        tabId: tabId,
        takePictureCallback: takePictureCallback,
      );

  Future<void> backWeb() async {
    await _currentController?.goBack();
    unawaited(_updateControlPanel());
  }

  Future<void> forwardWeb() async {
    await _currentController?.goForward();
    unawaited(_updateControlPanel());
  }

  Future<bool> clearCookie() async {
    return CookieManager.instance().deleteAllCookies();
  }

  void clearCachedFiles() {
    _screenShooter.clear();
    InAppWebViewController.clearAllCache();
  }

  BrowserTab? getTabById(String id) {
    return browserTabs.firstWhereOrNull((tab) => tab.id == id);
  }

  Future<void> permissionsChanged(
    String tabId,
    PermissionsChangedEvent event,
  ) async {
    return _controllers[tabId]?.permissionsChanged(event);
  }

  /// Put browser tabs to stream
  void _fetchTabsDataFromCache() {
    final tabs = _browserTabsStorageService.getTabs()
      ..sort(
        (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
      );

    BrowserTab? activeTab;

    if (tabs.isEmpty) {
      final newTab = BrowserTab.create(url: _emptyUri);
      activeTab = newTab;
      tabs.add(newTab);
    } else {
      final savedId = _browserTabsStorageService.getActiveTabId();

      activeTab = savedId == null
          ? tabs.firstOrNull
          : tabs.firstWhereOrNull((tab) => tab.id == savedId) ??
              tabs.firstOrNull;
    }

    _tabsState.accept(BrowserTabsCollection(tabs));

    _screenShooter.init(tabs);

    _activeTabState.accept(activeTab);
  }

  void _setTabs({
    List<BrowserTab>? tabs,
    String? activeTabId,
  }) {
    if (tabs != null) {
      _browserTabsStorageService.saveBrowserTabs(tabs);
      _tabsState.accept(BrowserTabsCollection(tabs));
    }

    if (activeTabId != null) {
      _browserTabsStorageService.saveBrowserActiveTabId(activeTabId);
      _activeTabState.accept(
        (tabs ?? browserTabs).firstWhereOrNull((t) => t.id == activeTabId),
      );
    }
  }

  void _handleActiveTab() {
    _updateControlPanel();
  }

  Future<void> _updateControlPanel() async {
    final controller = _currentController;

    _controlPanelState.accept(
      ToolbarData(
        isCanGoBack: await controller?.canGoBack(),
        isCanGoForward: await controller?.canGoForward(),
      ),
    );
  }
}
