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

  ListenableState<Uri?> get activeTabUriState;

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

  Future<void> clearTabs([String? groupId]);

  (String, String) createEmptyTab(String groupId);

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
    initValue: const ToolbarData(),
  );

  late final _activeTabUriState = StateNotifier<Uri?>();

  final _groupsReactiveStore = GroupsReactiveStore();
  final _tabsReactiveStore = TabsReactiveStore();

  @override
  ListenableState<String?> get activeGroupIdState =>
      _groupsReactiveStore.activeEntityIdState;

  @override
  ListenableState<String?> get activeTabIdState =>
      _tabsReactiveStore.activeEntityIdState;

  @override
  NotNullListenableState<List<String>> get allGroupsIdsState =>
      _groupsReactiveStore.entitiesIdsListState;

  @override
  NotNullListenableState<List<String>> get allTabsIdsState =>
      _tabsReactiveStore.entitiesIdsListState;

  @override
  ListenableState<Uri?> get activeTabUriState => _activeTabUriState;

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

  String? get activeGroupId => _groupsReactiveStore.activeEntityIdState.value;

  List<String> get allTabsIds => allTabsIdsState.value;

  String? get activeTabId => _tabsReactiveStore.activeEntityIdState.value;

  void init() {
    activeTabIdState.addListener(_handleActiveTab);
    _fetchDataFromCache();
  }

  void dispose() {
    _screenShooter.dispose();
    _groupsReactiveStore.dispose();
    _tabsReactiveStore.dispose();
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

    unawaited(
      Future(
        () {
          final newTab = BrowserTab.create(url: _emptyUri);
          final tabs = [newTab];
          final groups = _browserGroupsStorageService.initGroups([newTab.id]);

          _tabsReactiveStore
            ..addList(tabs)
            ..setActiveById(newTab.id);
          _browserTabsStorageService.saveBrowserTabs(tabs);

          Future(() {
            _groupsReactiveStore
              ..addList(groups)
              ..setActiveById(groups.first.id);
            _browserTabsStorageService.saveBrowserActiveTabId(newTab.id);
          });
        },
      ),
    );
  }

  Future<void> clearGroups() async {
    await _browserGroupsStorageService.clear();
    _groupsReactiveStore.clear();
  }

  /// Clear all browser tabs
  @override
  Future<void> clearTabs([String? groupId]) async {
    if (groupId == null) {
      await _browserTabsStorageService.clear();
      await _screenShooter.clear();
      _groupsReactiveStore.clearTabs();
      _tabsReactiveStore.clear();
      return;
    }

    final tabsIds = _groupsReactiveStore.getTabIds(groupId);

    if (tabsIds != null) {
      _tabsReactiveStore.removeList(tabsIds);
    }
    _groupsReactiveStore.clearTabs(groupId);

    _browserGroupsStorageService.saveGroups(_groupsReactiveStore.entities);
    _browserTabsStorageService.saveBrowserTabs(_tabsReactiveStore.entities);

    if (groupId == activeGroupIdState.value) {
      _tabsReactiveStore.setActiveById(null);
      _browserTabsStorageService.saveBrowserActiveTabId(null);
    }
  }

  @override
  void updateCachedUrl(String tabId, Uri uri) {
    _updateUriState(tabId, uri);
    _tabsReactiveStore.updateUrl(tabId: tabId, uri: uri);
    _browserTabsStorageService.saveBrowserTabs(_tabsReactiveStore.entities);
    _updateControlPanel();
  }

  @override
  Future<void> requestUrl(String tabId, Uri uri) async {
    final resultUri = uri.scheme.isEmpty ? Uri.parse('https://$uri') : uri;

    updateCachedUrl(tabId, resultUri);

    unawaited(_controllersDelegate.loadUrl(tabId, resultUri));
  }

  @override
  Future<void> requestUrlActiveTab(Uri uri) async {
    final id = activeTabId;

    if (id == null) {
      return;
    }

    return requestUrl(id, uri);
  }

  void loadData(
    String tabId,
    String html, {
    WebUri? baseUrl,
    WebUri? historyUrl,
  }) {
    _updateUriState(tabId, null);
    _controllersDelegate.loadData(
      tabId,
      html,
      baseUrl: baseUrl,
      historyUrl: historyUrl,
    );
  }

  @override
  void updateTabTitle(String tabId, String title) {
    _tabsReactiveStore.updateTitle(id: tabId, title: title);
    _browserTabsStorageService.saveBrowserTabs(_tabsReactiveStore.entities);
  }

  @override
  void setActiveGroup(String groupId) {
    _groupsReactiveStore.setActiveById(groupId);
  }

  @override
  void setActiveTab(String? tabId) {
    _tabsReactiveStore.setActiveById(tabId);
    _browserTabsStorageService.saveBrowserActiveTabId(tabId);
  }

  /// Remove browser tab by id
  @override
  Future<void> removeBrowserTab({
    required String groupId,
    required String tabId,
  }) async {
    final removedIndex = _groupsReactiveStore.removeTabId(
      groupId: groupId,
      tabId: tabId,
    );
    _tabsReactiveStore.remove(tabId);

    if (removedIndex == null) {
      return;
    }

    final tabIds = _groupsReactiveStore.getTabIds(groupId);

    if (groupId == activeGroupId && tabId == activeTabId) {
      final newActiveTabId = (tabIds?.isEmpty ?? true)
          ? null
          : tabIds?[min(removedIndex, tabIds.length - 1)];

      _tabsReactiveStore.setActiveById(newActiveTabId);
      _browserTabsStorageService.saveBrowserActiveTabId(newActiveTabId);
    }

    _browserGroupsStorageService.saveGroups(_groupsReactiveStore.entities);
    _browserTabsStorageService.saveBrowserTabs(_tabsReactiveStore.entities);

    unawaited(_screenShooter.removeScreenshot(tabId));
  }

  @override
  (String, String) createEmptyTab(String groupId) => createBrowserTab(
        url: _emptyUri,
        groupId: groupId,
      );

  (String, String) createBrowserTab({
    required String groupId,
    required Uri url,
    bool isSetActive = true,
  }) {
    final targetGroupId =
        _groupsReactiveStore.checkExistEntity(groupId) ? groupId : tabsGroupId;

    final tab = BrowserTab.create(url: url);

    _groupsReactiveStore.addTabId(
      groupId: targetGroupId,
      tabId: tab.id,
    );
    _tabsReactiveStore.add(tab);

    _browserGroupsStorageService.saveGroups(_groupsReactiveStore.entities);
    _browserTabsStorageService.saveBrowserTabs(_tabsReactiveStore.entities);

    if (isSetActive) {
      _groupsReactiveStore.setActiveById(targetGroupId);
      _tabsReactiveStore.setActiveById(tab.id);

      _browserTabsStorageService.saveBrowserActiveTabId(tab.id);
    }

    return (groupId, tab.id);
  }

  void openUrl(Uri url) {
    final lastTabId = _groupsReactiveStore.getTabIds(tabsGroupId)?.lastOrNull;

    if (lastTabId != null) {
      final isExistUrl =
          _tabsReactiveStore.getCachedUrl(lastTabId).toString().isNotEmpty;
      if (!isExistUrl) {
        requestUrl(lastTabId, url);

        _groupsReactiveStore.setActiveById(tabsGroupId);
        _tabsReactiveStore.setActiveById(lastTabId);
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
    return _groupsReactiveStore.getTabIndex(
      groupId: groupId,
      tabId: tabId,
    );
  }

  @override
  String? getTabIdByIndex({
    required String groupId,
    required int index,
  }) {
    return _groupsReactiveStore.getTabIdByIndex(
      groupId: groupId,
      index: index,
    );
  }

  @override
  List<String>? getTabIds(String groupId) =>
      _groupsReactiveStore.getTabIds(groupId);

  @override
  List<NotNullListenableState<BrowserTab>> getGroupTabsListenable(
    String groupId,
  ) {
    final tabIds = _groupsReactiveStore.getTabIds(groupId);

    if (tabIds == null) {
      return [];
    }

    final result = <NotNullListenableState<BrowserTab>>[];

    for (final id in tabIds) {
      final listenable = _tabsReactiveStore.getListenable(id);
      if (listenable == null) {
        continue;
      }
      result.add(listenable);
    }

    return result;
  }

  @override
  NotNullListenableState<BrowserGroup>? getGroupListenableById(String id) =>
      _groupsReactiveStore.getListenable(id);

  @override
  NotNullListenableState<BrowserTab>? getTabListenableById(String id) =>
      _tabsReactiveStore.getListenable(id);

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
      _groupsReactiveStore.removeTabId(
        groupId: originalGroupId,
        tabId: initTabId,
      );
    }

    final group = BrowserGroup.create(
      name: name ??
          LocaleKeys.groupWithCount.tr(
            args: ['${_groupsReactiveStore.count}'],
          ),
      tabsIds: [
        if (initTabId != null) initTabId,
      ],
    );

    _groupsReactiveStore.add(group);
    _browserGroupsStorageService.saveGroups(_groupsReactiveStore.entities);

    if (isSwitchToCreatedGroup) {
      _groupsReactiveStore.setActiveById(group.id);
      if (initTabId != null) {
        _tabsReactiveStore.setActiveById(initTabId);
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
    _groupsReactiveStore.updateTitle(id: groupId, title: name);
    _browserGroupsStorageService.saveGroups(_groupsReactiveStore.entities);
  }

  @override
  void removeBrowserGroup(String groupId) {
    final tabsIds = _groupsReactiveStore.getTabIds(groupId);
    final removeIndex = _groupsReactiveStore.remove(groupId);
    if (tabsIds != null) {
      _tabsReactiveStore.removeList(tabsIds);
    }

    if (groupId == activeGroupId) {
      if (removeIndex != null) {
        _groupsReactiveStore.setActiveByIndex(removeIndex);
        setActiveTab(null);
      } else {
        _groupsReactiveStore.setActiveById(tabsGroupId);
      }
    }

    _browserGroupsStorageService.saveGroups(_groupsReactiveStore.entities);
    _browserTabsStorageService.saveBrowserTabs(_tabsReactiveStore.entities);
  }

  /// Put browser tabs to stream
  void _fetchDataFromCache() {
    final tabs = _browserTabsStorageService.getTabs()
      ..forEach((tab) {
        if (tab.url.hasEmptyPath || tab.url.path == 'blank') {
          tab.url = Uri.parse('');
        }
      })
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

    _groupsReactiveStore.addList(groups);
    _tabsReactiveStore.addList(tabs);
    _groupsReactiveStore.setActiveById(activeGroupId);
    _tabsReactiveStore.setActiveById(activeTabId);
  }

  void _handleActiveTab() {
    _updateControlPanel();

    if (activeTabId != null) {
      _activeTabUriState.accept(
        _tabsReactiveStore.getCachedUrl(activeTabId!),
      );
    }
  }

  Future<void> _updateControlPanel() async {
    final id = activeTabId;

    _controlPanelState.accept(
      id == null
          ? const ToolbarData()
          : ToolbarData(
              isCanGoBack: await _controllersDelegate.checkCanGoBack(id),
              isCanGoForward: await _controllersDelegate.checkCanGoForward(id),
            ),
    );
  }

  void _updateUriState(String tabId, Uri? uri) {
    if (tabId == activeTabId && uri != _activeTabUriState.value) {
      _activeTabUriState.accept(uri);
    }
  }
}
