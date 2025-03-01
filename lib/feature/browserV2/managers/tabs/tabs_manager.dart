import 'dart:math';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/managers/tabs/helpers/browser_screenshot_helper.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/service/storages/browser_tabs_storage_service.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';

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

  final _activeTabState = StateNotifier<BrowserTab?>();

  ListenableState<BrowserTabsCollection> get tabsState => _tabsState;

  ListenableState<BrowserTab?> get activeTabState => _activeTabState;

  ListenableState<ImageCache?> get screenshotsState =>
      _screenshotHelper.screenshotsState;

  /// Get last cached browser tabs
  List<BrowserTab> get browserTabs => _tabsCollection.list;

  BrowserTab? get activeTab => _activeTabState.value;

  String? get activeTabId => activeTab?.id;

  BrowserTabsCollection get _tabsCollection =>
      _tabsState.value ?? BrowserTabsCollection();

  void init() {
    _fetchTabsDataFromCache();
  }

  void dispose() {
    _tabsState.dispose();
    _screenshotHelper.dispose();
  }

  Future<void> clear() {
    return clearTabs();
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
    final tab = browserTabs.firstWhereOrNull((t) => t.id == tabId);

    if (tab == null) {
      return;
    }

    tab.url = uri;
    _setTabs(tabs: browserTabs);
  }

  void updateTitle(String tabId, String title) {
    final tab = browserTabs.firstWhereOrNull((t) => t.id == tabId);

    if (tab == null) {
      return;
    }

    tab.title = title;

    _setTabs(tabs: browserTabs);
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

    await _screenshotHelper.removeScreenshot(id);

    _setTabs(
      tabs: tabs,
      activeTabId: tabs[nextIndex].id,
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

  /// Put browser tabs to stream
  void _fetchTabsDataFromCache() {
    final tabs = _browserTabsStorageService.getTabs();

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
}
