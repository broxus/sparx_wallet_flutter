import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/managers/tabs/helpers/browser_screenshot_helper.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/main/data/control_panels_data.dart';
import 'package:app/feature/browserV2/service/storages/browser_tabs_storage_service.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserTabsManager {
  BrowserTabsManager(
    this._browserTabsStorageService,
    this._generalStorageService,
  );

  static final _emptyUri = Uri.parse('');

  final BrowserTabsStorageService _browserTabsStorageService;
  final GeneralStorageService _generalStorageService;

  late final _screenshotHelper =
      BrowserManagerScreenshotHelper(_generalStorageService);

  /// Subject of browser tabs
  final _tabsState =
      StateNotifier<BrowserTabsCollection>(initValue: BrowserTabsCollection());

  late final _controlPanelState = StateNotifier<BrowserMainControlPanelData>(
    initValue: BrowserMainControlPanelData(),
  );

  final _activeTabState = StateNotifier<BrowserTab?>();

  final _controllers = HashMap<String, InAppWebViewController>();

  ListenableState<BrowserTabsCollection> get tabsState => _tabsState;

  ListenableState<BrowserTab?> get activeTabState => _activeTabState;

  ListenableState<ImageCache?> get screenshotsState =>
      _screenshotHelper.screenshotsState;

  ListenableState<BrowserMainControlPanelData> get controlPanelState =>
      _controlPanelState;

  /// Get last cached browser tabs
  List<BrowserTab> get browserTabs => _tabsCollection.list;

  BrowserTab? get activeTab => _activeTabState.value;

  String? get activeTabId => activeTab?.id;

  BrowserTabsCollection get _tabsCollection =>
      _tabsState.value ?? BrowserTabsCollection();

  InAppWebViewController? get _currentController => _controllers[activeTabId];

  void init() {
    activeTabState.addListener(_handleActiveTab);
    _fetchTabsDataFromCache();
  }

  void dispose() {
    activeTabState.removeListener(_handleActiveTab);
    _tabsState.dispose();
    _screenshotHelper.dispose();
  }

  void setController(String tabId, InAppWebViewController controller) {
    _controllers[tabId] = controller;
  }

  void removeController(String tabId) {
    _controllers.remove(tabId);
  }

  void closeAllControllers() {
    _controllers
      ..forEach((k, c) => c.dispose())
      ..clear();
  }

  Future<void> clear() {
    return clearTabs();
  }

  void openUrl(Uri uri) {
    createBrowserTab(uri);
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
    final isSuccess = updateCachedUrl(tabId, uri);

    if (!isSuccess) {
      return;
    }
    await _controllers[tabId]?.loadUrl(
      urlRequest: URLRequest(url: WebUri.uri(uri)),
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
    await _browserTabsStorageService.clearBrowserTabs();
    await _screenshotHelper.clear();
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

    await _screenshotHelper.removeScreenshot(id);

    _setTabs(
      tabs: tabs,
      activeTabId: newActiveTabId,
    );
  }

  void createEmptyTab() => createBrowserTab(_emptyUri);

  void createBrowserTab(Uri url) {
    final tab = BrowserTab.create(url: url);
    _setTabs(
      tabs: [...browserTabs, tab],
      activeTabId: tab.id,
    );
  }

  Future<void> createScreenshot({
    required String tabId,
    required Future<Uint8List?> Function() takePictureCallback,
  }) =>
      _screenshotHelper.createScreenshot(
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
      BrowserMainControlPanelData(
        isCanGoBack: await controller?.canGoBack(),
        isCanGoForward: await controller?.canGoForward(),
      ),
    );
  }
}
