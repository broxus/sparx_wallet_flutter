import 'dart:async';
import 'dart:math';

import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/browser_collection.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/data/tabs/tabs_data.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_base_delegate.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_service_pages_controllers_delegate.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_service_screenshots_delegate.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/feature/browser_v2/screens/main/data/toolbar_data.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

abstract interface class BrowserServiceTabs {
  ListenableState<ImageCache?> get screenshotsState;

  ListenableState<ToolbarData> get controlPanelState;

  NotNullListenableState<List<String>> get allGroupsIdsState;

  ListenableState<String?> get activeGroupIdState;

  ListenableState<String?> get activeTabIdState;

  String? get activeTabScreenshotPath;

  NotNullListenableState<List<String>> get allTabsIdsState;

  NotNullListenableState<BrowserTab>? getTabListenableById(String id);

  NotNullListenableState<BrowserGroup>? getGroupListenableById(String id);

  void setActiveGroup(String groupId);

  BrowserGroup createBrowserGroup({
    String? name,
    String? originalGroupId,
    String? initTabId,
    bool isSwitchToCreatedGroup = false,
  });

  void updateGroupName({
    required String groupId,
    required String name,
  });

  void removeBrowserGroup(String groupId);

  Future<void> backWeb();

  Future<void> forwardWeb();

  void updateCachedUrl(String tabId, Uri uri);

  void updateTabTitle(String tabId, String title);

  Future<void> createScreenshot({
    required String tabId,
    required Future<Uint8List?> Function() takePictureCallback,
  });

  List<NotNullListenableState<BrowserTab>> getGroupTabsListenable(
    String groupId,
  );

  List<String>? getTabIds(String groupId);

  Future<void> removeBrowserTab({
    required String groupId,
    required String tabId,
  });

  void setActiveTab(String? tabId);

  BrowserTab? getTabById(String id);

  Future<void> clearTabs();

  void createEmptyTab(String groupId);

  Future<void> requestUrl(String tabId, Uri uri);

  void setController(String tabId, CustomWebViewController controller);

  void removeController(String tabId);

  void closeAllControllers();

  void refresh(String tabId);

  Uri? getTabUriId(String id);

  String? getTabIdByIndex({
    required String groupId,
    required int index,
  });

  int? getTabIndex({
    required String groupId,
    required String tabId,
  });

  Future<void> requestUrlActiveTab(Uri uri);

  void refreshActiveTab();
}

@injectable
class BrowserServiceTabsDelegate
    implements BrowserDelegate, BrowserServiceTabs {
  BrowserServiceTabsDelegate(
    this._browserTabsStorageService,
    this._browserGroupsStorageService,
    this._controllersDelegate,
    this._screenShooter,
  );

  static final _emptyUri = Uri.parse('');

  final BrowserTabsStorageService _browserTabsStorageService;
  final BrowserGroupsStorageService _browserGroupsStorageService;

  final BrowserServicePagesControllersDelegate _controllersDelegate;
  final BrowserServiceScreenshotsDelegate _screenShooter;

  late final _controlPanelState = StateNotifier<ToolbarData>(
    initValue: ToolbarData(),
  );

  final _groupsCollection = GroupsCollection();
  final _tabsCollection = TabsCollection();

  @override
  ListenableState<String?> get activeGroupIdState =>
      _groupsCollection.activeEntityIdState;

  @override
  ListenableState<String?> get activeTabIdState =>
      _tabsCollection.activeEntityIdState;

  @override
  NotNullListenableState<List<String>> get allGroupsIdsState =>
      _groupsCollection.idsState;

  @override
  NotNullListenableState<List<String>> get allTabsIdsState =>
      _tabsCollection.idsState;

  @override
  ListenableState<ImageCache?> get screenshotsState =>
      _screenShooter.screenshotsState;

  @override
  String? get activeTabScreenshotPath {
    return activeTabId == null
        ? null
        : _screenShooter.getScreenShotById(activeTabId!);
  }

  @override
  ListenableState<ToolbarData> get controlPanelState => _controlPanelState;

  String? get activeGroupId => _groupsCollection.activeEntityIdState.value;

  List<String> get allTabsIds => allTabsIdsState.value;

  String? get activeTabId => _tabsCollection.activeEntityIdState.value;

  void init() {
    activeTabIdState.addListener(_handleActiveTab);
    _fetchDataFromCache();
  }

  void dispose() {
    _screenShooter.dispose();
    _groupsCollection.dispose();
    _tabsCollection.dispose();
  }

  @override
  void setController(String tabId, CustomWebViewController controller) =>
      _controllersDelegate.setController(tabId, controller);

  @override
  void removeController(String tabId) =>
      _controllersDelegate.removeController(tabId);

  @override
  void refresh(String tabId) => _controllersDelegate.refresh(tabId);

  @override
  void refreshActiveTab() {
    if (activeTabId != null) {
      refresh(activeTabId!);
    }
  }

  @override
  void closeAllControllers() => _controllersDelegate.closeAllControllers();

  Future<void> clear() async {
    await clearGroups();
    await clearTabs();
  }

  Future<void> clearGroups() async {
    await _browserGroupsStorageService.clear();
    _groupsCollection.clear();
  }

  /// Clear all browser tabs
  @override
  Future<void> clearTabs() async {
    await _browserTabsStorageService.clear();
    await _screenShooter.clear();
    _groupsCollection.clearTabs();
    _tabsCollection.clear();
  }

  @override
  void updateCachedUrl(String tabId, Uri uri) {
    _tabsCollection.updateUrl(tabId: tabId, uri: uri);
    _browserTabsStorageService.saveBrowserTabs(_tabsCollection.entities);
    _updateControlPanel();
  }

  @override
  Future<void> requestUrl(String tabId, Uri uri) async {
    final resultUri = uri.scheme.isEmpty ? Uri.parse('https://$uri') : uri;

    updateCachedUrl(tabId, resultUri);

    unawaited(_controllersDelegate.loadUrl(tabId, uri));
  }

  @override
  Future<void> requestUrlActiveTab(Uri uri) async {
    final id = activeTabId;

    if (id == null) {
      return;
    }

    return requestUrl(id, uri);
  }

  @override
  void updateTabTitle(String tabId, String title) {
    _tabsCollection.updateTitle(id: tabId, title: title);
    _browserTabsStorageService.saveBrowserTabs(_tabsCollection.entities);
  }

  @override
  void setActiveGroup(String groupId) {
    _groupsCollection.setActiveById(groupId);
  }

  @override
  void setActiveTab(String? tabId) {
    _tabsCollection.setActiveById(tabId);
    _browserTabsStorageService.saveBrowserActiveTabId(tabId);
  }

  /// Remove browser tab by id
  @override
  Future<void> removeBrowserTab({
    required String groupId,
    required String tabId,
  }) async {
    final removedIndex = _groupsCollection.removeTabId(
      groupId: groupId,
      tabId: tabId,
    );
    _tabsCollection.remove(tabId);

    if (removedIndex == null) {
      return;
    }

    final tabIds = _groupsCollection.getTabIds(groupId);

    if (groupId == activeGroupId && tabId == activeTabId) {
      final newActiveTabId = (tabIds?.isEmpty ?? true)
          ? null
          : tabIds?[min(removedIndex, tabIds.length - 1)];

      _tabsCollection.setActiveById(newActiveTabId);
      _browserTabsStorageService.saveBrowserActiveTabId(newActiveTabId);
    }

    _browserGroupsStorageService.saveGroups(_groupsCollection.entities);
    _browserTabsStorageService.saveBrowserTabs(_tabsCollection.entities);

    unawaited(_screenShooter.removeScreenshot(tabId));
  }

  @override
  void createEmptyTab(String groupId) => createBrowserTab(
        url: _emptyUri,
        groupId: groupId,
      );

  void createBrowserTab({
    required String groupId,
    required Uri url,
    bool isSetActive = true,
  }) {
    final targetGroupId =
        _groupsCollection.checkExistEntity(groupId) ? groupId : tabsGroupId;

    final tab = BrowserTab.create(url: url);

    _groupsCollection.addTabId(
      groupId: targetGroupId,
      tabId: tab.id,
    );
    _tabsCollection.add(tab);

    _browserGroupsStorageService.saveGroups(_groupsCollection.entities);
    _browserTabsStorageService.saveBrowserTabs(_tabsCollection.entities);

    if (isSetActive) {
      _groupsCollection.setActiveById(targetGroupId);
      _tabsCollection.setActiveById(tab.id);

      _browserTabsStorageService.saveBrowserActiveTabId(tab.id);
    }
  }

  void openUrl(Uri url) {
    final lastTabId = _groupsCollection.getTabIds(tabsGroupId)?.lastOrNull;

    if (lastTabId != null) {
      final isExistUrl =
          _tabsCollection.getCachedUrl(lastTabId).toString().isNotEmpty;
      if (!isExistUrl) {
        requestUrl(lastTabId, url);

        _groupsCollection.setActiveById(tabsGroupId);
        _tabsCollection.setActiveById(lastTabId);
        _browserTabsStorageService.saveBrowserActiveTabId(lastTabId);

        return;
      }
    }

    createBrowserTab(
      url: url,
      groupId: tabsGroupId,
    );
  }

  @override
  Future<void> createScreenshot({
    required String tabId,
    required Future<Uint8List?> Function() takePictureCallback,
  }) =>
      _screenShooter.createScreenshot(
        tabId: tabId,
        takePictureCallback: takePictureCallback,
      );

  @override
  Future<void> backWeb() async {
    if (activeTabId == null) {
      return;
    }

    await _controllersDelegate.goBack(activeTabId!);
    unawaited(_updateControlPanel());
  }

  @override
  Future<void> forwardWeb() async {
    if (activeTabId == null) {
      return;
    }

    await _controllersDelegate.goForward(activeTabId!);
    unawaited(_updateControlPanel());
  }

  void clearCachedFiles() {
    _screenShooter.clear();
    InAppWebViewController.clearAllCache();
  }

  @override
  int? getTabIndex({
    required String groupId,
    required String tabId,
  }) {
    return _groupsCollection.getTabIndex(
      groupId: groupId,
      tabId: tabId,
    );
  }

  @override
  String? getTabIdByIndex({
    required String groupId,
    required int index,
  }) {
    return _groupsCollection.getTabIdByIndex(
      groupId: groupId,
      index: index,
    );
  }

  @override
  List<String>? getTabIds(String groupId) =>
      _groupsCollection.getTabIds(groupId);

  @override
  List<NotNullListenableState<BrowserTab>> getGroupTabsListenable(
    String groupId,
  ) {
    final tabIds = _groupsCollection.getTabIds(groupId);

    if (tabIds == null) {
      return [];
    }

    final result = <NotNullListenableState<BrowserTab>>[];

    for (final id in tabIds) {
      final listenable = _tabsCollection.getListenable(id);
      if (listenable == null) {
        continue;
      }
      result.add(listenable);
    }

    return result;
  }

  @override
  NotNullListenableState<BrowserGroup>? getGroupListenableById(String id) =>
      _groupsCollection.getListenable(id);

  @override
  NotNullListenableState<BrowserTab>? getTabListenableById(String id) =>
      _tabsCollection.getListenable(id);

  @override
  BrowserTab? getTabById(String id) => getTabListenableById(id)?.value;

  @override
  Uri? getTabUriId(String id) => getTabListenableById(id)?.value.url;

  Future<void> permissionsChanged(
    String tabId,
    PermissionsChangedEvent event,
  ) =>
      _controllersDelegate.permissionsChanged(
        tabId,
        event,
      );

  @override
  BrowserGroup createBrowserGroup({
    String? name,
    String? originalGroupId,
    String? initTabId,
    bool isSwitchToCreatedGroup = false,
  }) {
    if (initTabId != null) {
      _groupsCollection.removeTabId(
        groupId: originalGroupId,
        tabId: initTabId,
      );
    }

    final group = BrowserGroup.create(
      name: name ??
          LocaleKeys.groupWithCount.tr(
            args: ['${_groupsCollection.count}'],
          ),
      tabsIds: [
        if (initTabId != null) initTabId,
      ],
    );

    _groupsCollection.add(group);
    _browserGroupsStorageService.saveGroups(_groupsCollection.entities);

    if (isSwitchToCreatedGroup) {
      _groupsCollection.setActiveById(group.id);
      if (initTabId != null) {
        _tabsCollection.setActiveById(initTabId);
        _browserTabsStorageService.saveBrowserActiveTabId(initTabId);
      }
    }

    return group;
  }

  @override
  void updateGroupName({
    required String groupId,
    required String name,
  }) {
    _groupsCollection.updateTitle(id: groupId, title: name);
    _browserGroupsStorageService.saveGroups(_groupsCollection.entities);
  }

  @override
  void removeBrowserGroup(String groupId) {
    final tabsIds = _groupsCollection.getTabIds(groupId);
    final removeIndex = _groupsCollection.remove(groupId);
    if (tabsIds != null) {
      _tabsCollection.removeList(tabsIds);
    }

    if (groupId == activeGroupId) {
      if (removeIndex != null) {
        _groupsCollection.setActiveByIndex(removeIndex);
        setActiveTab(null);
      } else {
        _groupsCollection.setActiveById(tabsGroupId);
      }
    }

    _browserGroupsStorageService.saveGroups(_groupsCollection.entities);
    _browserTabsStorageService.saveBrowserTabs(_tabsCollection.entities);
  }

  /// Put browser tabs to stream
  void _fetchDataFromCache() {
    final tabs = _browserTabsStorageService.getTabs()
      ..sort(
        (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
      );

    final groups = _browserGroupsStorageService.getGroups()
      ..sort(
        (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
      );

    String? activeTabId;

    if (tabs.isEmpty) {
      final newTab = BrowserTab.create(url: _emptyUri);
      activeTabId = newTab.id;
      tabs.add(newTab);
      _browserTabsStorageService.saveBrowserTabs(tabs);
    } else {
      activeTabId = _browserTabsStorageService.getActiveTabId();
    }

    if (groups.isEmpty) {
      groups.addAll(
        _browserGroupsStorageService.initGroups(
          tabs.map((tab) => tab.id).toList(),
        ),
      );
    }

    final activeGroupId = activeTabId == null
        ? tabsGroupId
        : groups
                .firstWhereOrNull(
                  (g) => g.tabsIds.contains(activeTabId),
                )
                ?.id ??
            tabsGroupId;

    _screenShooter.init(tabs);

    _groupsCollection.addList(groups);
    _tabsCollection.addList(tabs);
    _groupsCollection.setActiveById(activeGroupId);
    _tabsCollection.setActiveById(activeTabId);
  }

  void _handleActiveTab() {
    _updateControlPanel();
  }

  Future<void> _updateControlPanel() async {
    final id = activeTabId;

    _controlPanelState.accept(
      id == null
          ? ToolbarData()
          : ToolbarData(
              isCanGoBack: await _controllersDelegate.checkCanGoBack(id),
              isCanGoForward: await _controllersDelegate.checkCanGoForward(id),
            ),
    );
  }
}
