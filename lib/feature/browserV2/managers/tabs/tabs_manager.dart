import 'dart:math';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browserV2/data/control_panels_data.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/managers/tabs/helpers/browser_screenshot_helper.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/service/storages/browser_tabs_storage_service.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// enum BrowserTabStateType {
//   initial,
//   loading,
//   loaded,
//   error,
// }

class BrowserTabsManager {
  BrowserTabsManager(
    this._browserTabsStorageService,
    this._generalStorageService,
  );

  static final _emptyUri = Uri.parse('');

  final BrowserTabsStorageService _browserTabsStorageService;
  final GeneralStorageService _generalStorageService;

  final _controllers = <String, InAppWebViewController>{};

  late final _screenshotHelper =
      BrowserManagerScreenshotHelper(_generalStorageService);

  /// Subject of browser tabs
  final _tabsState =
      StateNotifier<BrowserTabsData>(initValue: BrowserTabsData());

  final _controlPanelState = StateNotifier<BrowserControlPanelData>(
    initValue: BrowserControlPanelData(),
  );

  ListenableState<BrowserTabsData> get tabsState => _tabsState;

  ListenableState<BrowserControlPanelData> get controlPanelState =>
      _controlPanelState;

  /// Get last cached browser tabs
  List<BrowserTab> get browserTabs => _tabsData.tabs;

  /// Get last cached of active browser tab id
  String? get activeTabId => _tabsData.activeTabId;

  BrowserTab? get activeTab => _tabsData.activeTab;

  BrowserTabsData get _tabsData => _tabsState.value ?? BrowserTabsData();

  InAppWebViewController? get _currentController => _controllers[activeTabId];

  void init() {
    _fetchTabsDataFromCache();
    _tabsState.addListener(_handleTabs);
  }

  void dispose() {
    _tabsState.dispose();
  }

  Future<void> clear() {
    return clearTabs();
  }

  void setController(String tabId, InAppWebViewController controller) {
    _controllers[tabId] = controller;
    _updateControlPanel();
  }

  void removeController(String tabId) {
    _controllers.remove(tabId);
    _updateControlPanel();
  }

  void openUrl(Uri uri) {
    final id = activeTabId;
    if (id == null) {
      createBrowserTab(uri);
      return;
    }
    updateUrl(id, uri);
  }

  void updateUrl(String tabId, Uri uri) {
    final tabs = [...browserTabs];
    final index = tabs.indexWhere((t) => t.id == tabId);

    if (index == -1) {
      return;
    }

    tabs[index] = tabs[index].copyWith(url: uri);

    _setTabs(tabs: tabs);
  }

  /// Clear all browser tabs
  Future<void> clearTabs() async {
    await _browserTabsStorageService.clearBrowserTabs();
    await _screenshotHelper.clear();
    _tabsState.accept(BrowserTabsData());
  }

  void setActiveTab(String? id) {
    if (id == activeTabId) {
      return;
    }

    _setTabs(activeTabId: id);
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

  /// TODO(Knightforce): check need?
  // void setBrowserTab(BrowserTab tab) {
  //   final id = tab.id;
  //   final tabs = [...browserTabs];
  //   final index = tabs.indexWhere((tab) => tab.id == id);
  //
  //   if (index == -1) {
  //     tabs.add(tab);
  //   } else {
  //     tabs[index] = tab;
  //   }
  //
  //   _saveTabs(tabs);
  // }

  /// Remove browser tab by id
  Future<void> removeBrowserTab(String id) async {
    final tabs = [...browserTabs];

    final count = browserTabs.length;

    int? removedIndex;

    for (var i = 0; i < count; i++) {
      if (browserTabs[i].id != id) {
        continue;
      }

      removedIndex = i;
    }

    if (removedIndex == null) {
      return;
    }

    tabs.removeAt(removedIndex);

    final nextIndex = min(removedIndex, browserTabs.length - 1);

    _setTabs(
      tabs: tabs,
      activeTabId: tabs[nextIndex].id,
    );

    await _screenshotHelper.removeScreenshot(id);
  }

  void createEmptyTab() => createBrowserTab(_emptyUri);

  void createBrowserTab(Uri url) {
    final tab = BrowserTab.create(url: url);
    _setTabs(
      tabs: [...browserTabs, tab],
      activeTabId: tab.id,
    );
  }

  String createImageId() => _screenshotHelper.createImageId();

  String? getImagePath({
    required String tabId,
    String? imageId,
  }) =>
      _screenshotHelper.getImagePath(
        tabId: tabId,
        imageId: imageId,
      );

  String? getTabDirectoryPath(String tabId) =>
      _screenshotHelper.getTabDirectoryPath(tabId);

  /// Put browser tabs to stream
  void _fetchTabsDataFromCache() {
    final tabs = _browserTabsStorageService.getTabs();
    final savedId = _browserTabsStorageService.getActiveTabId();

    final id = savedId == null
        ? tabs.firstOrNull?.id
        : tabs.firstWhereOrNull((tab) => tab.id == savedId)?.id ??
            tabs.firstOrNull?.id;

    _tabsState.accept(
      BrowserTabsData(
        tabs: _browserTabsStorageService.getTabs(),
        activeTabId: id,
      ),
    );
  }

  void _setTabs({
    List<BrowserTab>? tabs,
    String? activeTabId,
  }) {
    if (tabs != null) {
      _browserTabsStorageService.saveBrowserTabs(tabs);
    }

    if (activeTabId != null) {
      _browserTabsStorageService.saveBrowserActiveTabId(activeTabId);
    }

    _tabsState.accept(
      _tabsData.copyWith(
        tabs: tabs,
        activeTabId: activeTabId,
      ),
    );
  }

  void _handleTabs() {
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
}
