import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/browser_collection.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/data/tabs/tabs_data.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/feature/browser_v2/managers/tabs/helpers/browser_screen_shooter.dart';
import 'package:app/feature/browser_v2/screens/main/data/toolbar_data.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

class BrowserTabsManager {
  BrowserTabsManager(
    this._browserTabsStorageService,
    this._browserGroupsStorageService,
    this._generalStorageService,
  );

  static final _emptyUri = Uri.parse('');

  final BrowserTabsStorageService _browserTabsStorageService;
  final BrowserGroupsStorageService _browserGroupsStorageService;
  final GeneralStorageService _generalStorageService;

  late final _screenShooter =
      BrowserManagerScreenShooter(_generalStorageService);

  late final _controlPanelState = StateNotifier<ToolbarData>(
    initValue: ToolbarData(),
  );

  final _controllers = HashMap<String, CustomWebViewController>();

  final _groupsCollection = GroupsCollection();
  final _tabsCollection = TabsCollection();

  ListenableState<String?> get activeGroupIdState =>
      _groupsCollection.activeEntityIdState;

  ListenableState<String?> get activeTabIdState =>
      _tabsCollection.activeEntityIdState;

  NotNullListenableState<List<String>> get allGroupsIdsState =>
      _groupsCollection.idsState;

  NotNullListenableState<List<String>> get allTabsIdsState =>
      _tabsCollection.idsState;

  ListenableState<ImageCache?> get screenshotsState =>
      _screenShooter.screenshotsState;

  String? get activeTabScreenshotPath {
    return activeTabId == null
        ? null
        : _screenShooter.getScreenShotById(activeTabId!);
  }

  ListenableState<ToolbarData> get controlPanelState => _controlPanelState;

  String? get activeGroupId => _groupsCollection.activeEntityIdState.value;

  List<String> get allTabsIds => allTabsIdsState.value;

  String? get activeTabId => _tabsCollection.activeEntityIdState.value;

  CustomWebViewController? get _currentController => _controllers[activeTabId];

  void init() {
    activeTabIdState.addListener(_handleActiveTab);
    _fetchDataFromCache();
  }

  void dispose() {
    _screenShooter.dispose();
    _groupsCollection.dispose();
    _tabsCollection.dispose();
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

  Future<void> clear() async {
    await clearGroups();
  }

  Future<void> clearGroups() async {
    await _browserGroupsStorageService.clear();
    _groupsCollection.clear();
    await clearTabs();
  }

  /// Clear all browser tabs
  Future<void> clearTabs() async {
    await _browserTabsStorageService.clear();
    await _screenShooter.clear();
    _tabsCollection.clear();
  }

  void updateCachedUrl(String tabId, Uri uri) {
    _tabsCollection.updateUrl(tabId: tabId, uri: uri);
    _browserTabsStorageService.saveBrowserTabs(_tabsCollection.entities);
  }

  Future<void> requestUrl(String tabId, Uri uri) async {
    final resultUri = uri.scheme.isEmpty ? Uri.parse('https://$uri') : uri;

    updateCachedUrl(tabId, resultUri);

    await _controllers[tabId]?.loadUrl(
      urlRequest: URLRequest(url: WebUri.uri(resultUri)),
    );

    unawaited(_updateControlPanel());
  }

  Future<void> requestUrlActiveTab(Uri uri) async {
    final id = activeTabId;

    if (id == null) {
      return;
    }

    return requestUrl(id, uri);
  }

  void updateTabTitle(String tabId, String title) {
    _tabsCollection.updateTitle(id: tabId, title: title);
    _browserTabsStorageService.saveBrowserTabs(_tabsCollection.entities);
  }

  void setActiveGroup(String groupId) {
    _groupsCollection.setActiveById(groupId);
    _browserGroupsStorageService.saveActiveGroupId(groupId);
  }

  void setActiveTab(String? tabId) {
    _tabsCollection.setActiveById(tabId);
    _browserTabsStorageService.saveBrowserActiveTabId(tabId);
  }

  /// Remove browser tab by id
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

    String? newActiveTabId;

    final tabIds = _groupsCollection.getTabIds(groupId);

    if (tabIds != null) {
      newActiveTabId = tabIds.isEmpty || tabId != activeTabId
          ? null
          : tabIds[min(removedIndex, tabIds.length - 1)];
    }

    if (newActiveTabId != null) {
      _tabsCollection.setActiveById(newActiveTabId);
      _browserTabsStorageService.saveBrowserActiveTabId(newActiveTabId);
    }

    _browserGroupsStorageService.saveGroups(_groupsCollection.entities);
    _browserTabsStorageService.saveBrowserTabs(_tabsCollection.entities);

    unawaited(_screenShooter.removeScreenshot(tabId));
  }

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

      _browserGroupsStorageService.saveActiveGroupId(targetGroupId);
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
        _browserGroupsStorageService.saveActiveGroupId(tabsGroupId);
        _browserTabsStorageService.saveBrowserActiveTabId(lastTabId);

        return;
      }
    }

    createBrowserTab(
      url: url,
      groupId: tabsGroupId,
    );
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

  int? getTabIndex({
    required String groupId,
    required String tabId,
  }) {
    return _groupsCollection.getTabIndex(
      groupId: groupId,
      tabId: tabId,
    );
  }

  String? getTabIdByIndex({
    required String groupId,
    required int index,
  }) {
    return _groupsCollection.getTabIdByIndex(
      groupId: groupId,
      index: index,
    );
  }

  List<String>? getTabIds(String groupId) =>
      _groupsCollection.getTabIds(groupId);

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

  NotNullListenableState<BrowserGroup>? getGroupListenableById(String id) =>
      _groupsCollection.getListenable(id);

  NotNullListenableState<BrowserTab>? getTabListenableById(String id) =>
      _tabsCollection.getListenable(id);

  BrowserTab? getTabById(String id) => getTabListenableById(id)?.value;

  Uri? getTabUriId(String id) => getTabListenableById(id)?.value.url;

  Future<void> permissionsChanged(
    String tabId,
    PermissionsChangedEvent event,
  ) async {
    return _controllers[tabId]?.permissionsChanged(event);
  }

  BrowserGroup createBrowserGroup({
    String? name,
    String? prevOwnerGroupId,
    String? initTabId,
    bool isSwitchToCreatedGroup = false,
  }) {
    if (initTabId != null) {
      _groupsCollection.removeTabId(
        groupId: prevOwnerGroupId,
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
      _browserGroupsStorageService.saveActiveGroupId(group.id);
      if (initTabId != null) {
        _tabsCollection.setActiveById(initTabId);
        _browserTabsStorageService.saveBrowserActiveTabId(initTabId);
      }
    }

    return group;
  }

  void updateGroupName({
    required String groupId,
    required String name,
  }) {
    _groupsCollection.updateTitle(id: groupId, title: name);
    _browserGroupsStorageService.saveGroups(_groupsCollection.entities);
  }

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
      activeTabId =
          _browserTabsStorageService.getActiveTabId() ?? tabs.lastOrNull?.id;
    }

    if (groups.isEmpty) {
      groups.addAll(
        _browserGroupsStorageService.initGroups(
          tabs.map((tab) => tab.id).toList(),
        ),
      );
    }

    var activeGroupId = groups
        .firstWhereOrNull(
          (g) => g.tabsIds.contains(activeTabId),
        )
        ?.id;

    if (activeGroupId == null || activeTabId == null) {
      activeGroupId =
          _browserGroupsStorageService.getActiveGroupId() ?? tabsGroupId;
      activeTabId = null;
    }

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
    final controller = _currentController;

    _controlPanelState.accept(
      ToolbarData(
        isCanGoBack: await controller?.canGoBack(),
        isCanGoForward: await controller?.canGoForward(),
      ),
    );
  }
}
