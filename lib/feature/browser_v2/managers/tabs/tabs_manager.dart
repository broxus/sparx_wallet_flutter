import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/core/wm/not_null_safe_notifier.dart';
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

  // final _allTabs = <String, BrowserTab>{};
  final _allGroups = <String, BrowserGroup>{};

  final _activeGroupState = StateNotifier<BrowserGroup?>();
  final _allTabsState = _TabsNotifier();
  final _activeTabState = StateNotifier<BrowserTab?>();

  final _allGroupsState = NotNullNotifier<List<BrowserGroup>>([]);

  ListenableState<BrowserGroup?> get activeGroupState => _activeGroupState;

  ListenableState<BrowserTab?> get activeTabState => _activeTabState;

  ListenableState<List<BrowserGroup>> get allGroupsState => _allGroupsState;

  ListenableState<Map<String, BrowserTab>> get allTabsState => _allTabsState;

  ListenableState<ImageCache?> get screenshotsState =>
      _screenShooter.screenshotsState;

  String? get activeTabScreenshotPath {
    return activeTab?.id == null
        ? null
        : _screenShooter.getScreenShotById(activeTab!.id);
  }

  ListenableState<ToolbarData> get controlPanelState => _controlPanelState;

  Iterable<String> get allBrowserTabsIds => _allTabsState.value.keys;

  BrowserTab? get activeTab => activeTabState.value;

  CustomWebViewController? get _currentController =>
      _controllers[activeTab?.id];

  void init() {
    activeGroupState.addListener(_handleActiveTab);
    _fetchDataFromCache();
  }

  void dispose() {
    _screenShooter.dispose();
    _allGroupsState.dispose();
    _activeGroupState.dispose();
    _allTabsState.dispose();
    _activeTabState.dispose();
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
    _controllers[activeTab?.id]?.reload();
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
    _allGroupsState.accept([]);
    _activeGroupState.accept(null);
    await clearTabs();
  }

  /// Clear all browser tabs
  Future<void> clearTabs() async {
    await _browserTabsStorageService.clear();
    await _screenShooter.clear();
    _allTabsState.clear();
    _allGroups.forEach((id, group) {
      group.tabsIds.clear();
    });
    _allGroupsState.accept(_allGroups.valuesList);
    _activeTabState.accept(null);
  }

  bool updateCachedUrl(String tabId, Uri uri) {
    final tab = _allTabsState[tabId];

    if (tab == null) {
      return false;
    }

    _allTabsState[tabId] = tab.copyWith(url: uri);
    _browserTabsStorageService.saveBrowserTabs(_allTabsState.tabs);

    if (tabId == activeTab?.id) {
      _activeGroupState.accept(_activeGroupState.value?.copyWith());
    }

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

    unawaited(_updateControlPanel());
  }

  Future<void> requestUrlActiveTab(Uri uri) async {
    final id = activeTab?.id;

    if (id == null) {
      return;
    }

    return requestUrl(id, uri);
  }

  void updateTabTitle(String tabId, String title) {
    final tab = _allTabsState[tabId];

    if (tab == null) {
      return;
    }

    _allTabsState[tabId] = tab.copyWith(title: title);
    _browserTabsStorageService.saveBrowserTabs(_allTabsState.tabs);

    if (tabId == activeTab?.id) {
      _activeGroupState.accept(_activeGroupState.value?.copyWith());
    }
  }

  void setActiveGroup(String groupId) {
    if (_activeGroupState.value?.id == groupId) {
      return;
    }

    final group = _allGroups[groupId];

    if (group == null) {
      return;
    }
    _activeGroupState.accept(group);
    _browserGroupsStorageService.saveActiveGroupId(groupId);
  }

  void setActiveTab(String? tabId) {
    if (tabId == null || _activeTabState.value?.id == tabId) {
      return;
    }

    final tab = _allTabsState[tabId];

    if (tab == null) {
      return;
    }

    _activeTabState.accept(tab);

    _browserTabsStorageService.saveBrowserActiveTabId(tabId);
  }

  /// Remove browser tab by id
  Future<void> removeBrowserTab({
    required String groupId,
    required String tabId,
  }) async {
    final group = _allGroups[groupId];

    if (group == null) {
      return;
    }

    final groupTabsIds = [...group.tabsIds];

    String? newActiveTabId;

    final removedIndex = groupTabsIds.indexWhere((id) => id == tabId);

    if (removedIndex != -1) {
      final removedId = groupTabsIds.removeAt(removedIndex);

      newActiveTabId = groupTabsIds.isEmpty || removedId != activeTab?.id
          ? null
          : groupTabsIds[min(removedIndex + 1, groupTabsIds.length - 1)];
    }

    _allGroups[groupId] = group.copyWith(
      tabsIds: groupTabsIds,
    );

    _setGroups(groups: _allGroups.valuesList);
    _allTabsState.remove(tabId);
    _browserTabsStorageService.saveBrowserTabs(_allTabsState.tabs);

    unawaited(_screenShooter.removeScreenshot(tabId));

    setActiveTab(newActiveTabId);
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
    final group = _allGroups[groupId] ?? _allGroups[tabsGroupId];

    if (group == null) {
      return;
    }

    final tab = BrowserTab.create(url: url);

    _allTabsState[tab.id] = tab;
    _browserTabsStorageService.saveBrowserTabs(_allTabsState.tabs);

    _allGroups[groupId] = group.copyWith(tabsIds: [...group.tabsIds, tab.id]);

    _setGroups(groups: _allGroups.valuesList);

    if (isSetActive) {
      setActiveGroup(group.id);
      setActiveTab(tab.id);
    }
  }

  void openUrl(Uri url) {
    final group = _allGroups[tabsGroupId];

    if (group == null) {
      return;
    }

    final lastTabId = group.tabsIds.lastOrNull;
    final lastTab = _allTabsState[lastTabId];

    if (lastTab != null &&
        lastTabId != null &&
        lastTab.url.toString().isEmpty) {
      requestUrl(lastTab.id, url);
      setActiveGroup(group.id);
      setActiveTab(lastTabId);
    } else {
      createBrowserTab(
        url: url,
        groupId: group.id,
      );
    }
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
    final index = _allGroups[groupId]?.tabsIds.indexWhere((id) => id == tabId);

    return index == -1 ? null : index;
  }

  String? getTabIdByIndex({
    required String groupId,
    required int index,
  }) {
    try {
      return _allGroups[groupId]?.tabsIds[index];
    } catch (_) {
      return null;
    }
  }

  /// Остановил проверку тут
  List<BrowserTab> getGroupTabs(String groupId) {
    final tabIds = _allGroups[groupId]?.tabsIds;

    if (tabIds == null) {
      return [];
    }

    final result = <BrowserTab>[];

    for (final id in tabIds) {
      final tab = _allTabsState[id];
      if (tab == null) {
        continue;
      }
      result.add(tab);
    }

    return result;
  }

  BrowserGroup? getGroupById(String id) => _allGroups[id];

  BrowserTab? getTabById(String id) => _allTabsState[id];

  Future<void> permissionsChanged(
    String tabId,
    PermissionsChangedEvent event,
  ) async {
    return _controllers[tabId]?.permissionsChanged(event);
  }

  BrowserGroup createBrowserGroup({
    String? name,
    String? initTabId,
    bool isSwitchToCreatedGroup = false,
  }) {
    if (initTabId != null) {
      final keys = _allGroups.keys;

      BrowserGroup? prevGroup;

      for (final key in keys) {
        if (_allGroups[key]?.tabsIds.contains(initTabId) ?? false) {
          prevGroup = _allGroups[key];
          break;
        }
      }

      if (prevGroup != null) {
        _allGroups[prevGroup.id] = prevGroup.copyWith(
          tabsIds: [...prevGroup.tabsIds]..remove(initTabId),
        );
      }
    }

    final group = BrowserGroup.create(
      name: name ??
          LocaleKeys.groupWithCount.tr(
            args: ['${_allGroups.length}'],
          ),
      tabsIds: [
        if (initTabId != null) initTabId,
      ],
    );

    _allGroups[group.id] = group;

    _setGroups(
      groups: _allGroups.valuesList,
    );

    if (isSwitchToCreatedGroup) {
      setActiveGroup(group.id);
      if (initTabId != null) {
        setActiveTab(initTabId);
      }
    }

    return group;
  }

  void updateGroupName({
    required String groupId,
    required String name,
  }) {
    final group = _allGroups[groupId];

    if (group == null) {
      return;
    }

    _allGroups[groupId] = group.copyWith(title: name);

    _setGroups(groups: _allGroups.valuesList);
  }

  void removeBrowserGroup(String groupId) {
    List<String>? groupTabsIds;

    if (groupId != _activeGroupState.value?.id) {
      groupTabsIds = _allGroups.remove(groupId)?.tabsIds;
    } else {
      final keys = _allGroups.keys.toList();

      int? groupIndex;

      for (var i = 0; i < keys.length; i++) {
        if (keys[i] == groupId) {
          groupIndex = i;
          break;
        }
      }

      if (groupIndex == null) {
        groupTabsIds = _allGroups.remove(groupId)?.tabsIds;
        setActiveGroup(tabsGroupId);
        setActiveTab(_allGroups[tabsGroupId]?.tabsIds.firstOrNull);
      } else {
        final isLastGroup = groupIndex == _allGroups.length - 1;

        final nextGroup = _allGroups[keys[groupIndex + (isLastGroup ? -1 : 1)]];

        if (nextGroup != null) {
          setActiveGroup(nextGroup.id);
          setActiveTab(nextGroup.tabsIds.firstOrNull);
        }
      }

      groupTabsIds = _allGroups.remove(groupId)?.tabsIds;
    }

    if (groupTabsIds != null) {
      _allTabsState.removeByList(groupTabsIds);
    }

    _setGroups(groups: _allGroups.valuesList);
    _browserTabsStorageService.saveBrowserTabs(_allTabsState.tabs);
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

    for (final group in groups) {
      _allGroups[group.id] = group;
    }

    final tabsMap = <String, BrowserTab>{};

    for (final tab in tabs) {
      tabsMap[tab.id] = tab;
    }
    _allTabsState.addTabs(tabsMap);

    BrowserGroup? activeGroup;
    BrowserTab? activeTab;

    if (_allTabsState.isEmpty) {
      activeTab = BrowserTab.create(url: _emptyUri);
      _allTabsState[activeTab.id] = activeTab;
      _browserTabsStorageService.saveBrowserTabs([activeTab]);
    } else {
      activeTab = _allTabsState[_browserTabsStorageService.getActiveTabId()] ??
          _allTabsState[_allTabsState.ids.firstOrNull];
    }

    if (_allGroups.isEmpty) {
      activeGroup = _browserGroupsStorageService.initGroups(
        _allTabsState.ids.toList(),
      );

      _allGroups[activeGroup.id] = activeGroup;
    } else {
      activeGroup =
          _allGroups[_browserGroupsStorageService.getActiveGroupId()] ??
              _allGroups[tabsGroupId]!;
    }

    // guard
    if (activeTab != null && !activeGroup.tabsIds.contains(activeTab.id)) {
      activeGroup = _allGroups.values.firstWhereOrNull(
        (g) => g.tabsIds.contains(activeTab?.id),
      );

      if (activeGroup == null) {
        activeGroup = _allGroups[tabsGroupId];
        activeTab = _allTabsState[activeGroup?.tabsIds.firstOrNull];
      }
    }

    _allGroupsState.accept(_allGroups.valuesList);
    _activeGroupState.accept(activeGroup);
    _activeTabState.accept(activeTab);

    _screenShooter.init(tabs);
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

  void _setGroups({
    required List<BrowserGroup> groups,
  }) {
    _browserGroupsStorageService.saveGroups(groups);
    _allGroupsState.accept(groups);
  }
}

extension _MapExt<K, V> on Map<K, V> {
  List<V> get valuesList => values.toList();
}

class _TabsNotifier extends NotNullNotifier<Map<String, BrowserTab>> {
  _TabsNotifier() : super({});

  List<String> get ids => value.keys.toList();

  List<BrowserTab> get tabs => value.values.toList();

  bool get isEmpty => value.isEmpty;

  BrowserTab? operator [](String? key) {
    return value[key];
  }

  void operator []=(String key, BrowserTab tab) {
    value[key] = tab;
    accept(value, isUnique: false);
  }

  void addTabs(Map<String, BrowserTab> map) {
    accept(value..addAll(map), isUnique: false);
  }

  void remove(String key) {
    accept(value..remove(key), isUnique: false);
  }

  void removeByList(List<String> ids) {
    for (final id in ids) {
      value.remove(id);
    }
    accept(value, isUnique: false);
  }

  void clear() {
    accept(value..clear(), isUnique: false);
  }
}
