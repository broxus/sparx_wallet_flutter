import 'dart:async';
import 'dart:collection';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/screens/create_group/route.dart';
import 'package:app/feature/browser/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/feature/browser/widgets/bottomsheets/clear_tabs_bottom_sheet.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

abstract interface class BrowserTabsAndGroupsUi {
  ListenableState<List<NotNullListenableState<BrowserTab>>?> get viewTabsState;

  ListenableState<Uri?> get activeTabUriState;

  ListenableState<String?> get selectedGroupIdState;

  ListenableState<TabAnimationType?> get tabAnimationTypeState;

  ScrollController get tabListScrollController;

  void onPressedGroup(String groupId);

  void onCloseAllPressed();

  void addTab();

  void changeTab({required String groupId, required String tabId});
}

class BrowserTabsAndGroupsUiDelegate implements BrowserTabsAndGroupsUi {
  BrowserTabsAndGroupsUiDelegate(
    this.context,
    this.model, {
    required this.tabsRenderManager,
    required this.onEmptyTabs,
    required this.onUpdateActiveTab,
    required this.checkIsVisiblePages,
    required this.hideMenu,
    required this.showMenu,
  }) {
    _init();
  }

  final BuildContext context;
  final BrowserMainScreenModel model;
  final BrowserTabsRenderManager tabsRenderManager;
  final VoidCallback onEmptyTabs;
  final ValueChanged<bool> onUpdateActiveTab;
  final bool Function() checkIsVisiblePages;
  final VoidCallback hideMenu;
  final VoidCallback showMenu;

  final _tabAnimationTypeState = StateNotifier<TabAnimationType?>();

  late final _viewTabsState =
      StateNotifier<List<NotNullListenableState<BrowserTab>>?>();

  late final _selectedGroupIdState = StateNotifier<String?>(
    initValue: model.activeGroupIdState.value,
  );

  @override
  final tabListScrollController = ScrollController();

  final _groupsScrollOffsets = HashMap<String, double>();

  int? _tabsPrevCount;
  int? _tabsCount;

  @override
  ListenableState<String?> get selectedGroupIdState => _selectedGroupIdState;

  @override
  ListenableState<List<NotNullListenableState<BrowserTab>>?>
  get viewTabsState => _viewTabsState;

  @override
  ListenableState<Uri?> get activeTabUriState => model.activeTabUriState;

  @override
  ListenableState<TabAnimationType?> get tabAnimationTypeState =>
      _tabAnimationTypeState;

  String? get activeTabId => model.activeTabId;

  bool get isEmptyActiveTabUrl => _activeTab?.url.toString().isEmpty ?? false;

  BrowserTab? get _activeTab => model.getTabById(activeTabId);

  void dispose() {
    model.activeGroupIdState.removeListener(_handleActiveGroup);
    model.activeTabIdState.removeListener(_handleActiveTab);
    model.allTabsIdsState.removeListener(_handleAllTabs);
    _selectedGroupIdState.dispose();
    _tabAnimationTypeState.dispose();
    _viewTabsState.removeListener(_handleTabs);
    tabListScrollController.dispose();
    _groupsScrollOffsets.clear();
  }

  @override
  void changeTab({required String groupId, required String tabId}) {
    final data = tabsRenderManager.getRenderData(tabId);

    if (tabId == _activeTab?.id) {
      _tabAnimationTypeState.accept(
        ShowViewAnimationType(tabX: data?.xLeft, tabY: data?.yTop),
      );
    } else {
      model
        ..setActiveGroup(groupId)
        ..setActiveTab(tabId);
    }
  }

  @override
  void onPressedGroup(String groupId) {
    final currentGroupId = _selectedGroupIdState.value;

    if (currentGroupId != null && tabListScrollController.hasClients) {
      _groupsScrollOffsets[currentGroupId] = tabListScrollController.offset;
    }

    _selectedGroupIdState.accept(groupId);
  }

  void onTabAnimationStart({VoidCallback? onCompleteShowTabs}) {
    if (_tabAnimationTypeState.value == null) {
      return;
    }
    if (_tabAnimationTypeState.value is ShowTabsAnimationType) {
      onCompleteShowTabs?.call();
    }
  }

  void onTabAnimationEnd({VoidCallback? onCompleteShowView}) {
    if (_tabAnimationTypeState.value == null) {
      return;
    }

    if (_tabAnimationTypeState.value is ShowViewAnimationType) {
      onCompleteShowView?.call();
    }

    _tabAnimationTypeState.accept(null);
  }

  int? getTabIndexById({required String groupId, required String tabId}) {
    return model.getTabIndex(groupId: groupId, tabId: tabId);
  }

  String? getIdByIndex({required String groupId, required int index}) =>
      model.getTabIdByIndex(groupId: groupId, index: index);

  @override
  Future<void> onCloseAllPressed() async {
    final isClear = await showBrowserClearTabsSheet(context: context);

    final groupId = selectedGroupIdState.value;

    if (groupId != null && (isClear ?? false)) {
      model.clearTabs(groupId);
    }
  }

  @override
  void addTab() {
    final id = _selectedGroupIdState.value;

    if (id == null) {
      return;
    }

    model.createEmptyTab(id);
  }

  void animateShowView() {
    final id = activeTabId;
    final data = id == null ? null : tabsRenderManager.getRenderData(id);

    _tabAnimationTypeState.accept(
      ShowViewAnimationType(tabX: data?.xLeft, tabY: data?.yTop),
    );
  }

  void animateShowTabs() {
    final id = activeTabId;
    final data = id == null ? null : tabsRenderManager.getRenderData(id);

    _tabAnimationTypeState.accept(
      ShowTabsAnimationType(tabX: data?.xLeft, tabY: data?.yTop),
    );
  }

  Future<void> createGroup(
    BuildContext context, {
    String? tabId,
    String? originalGroupId,
  }) async {
    hideMenu();

    final groupName = await context.compassPush<String?>(
      CreateBrowserGroupRouteData(tabId: tabId),
    );

    showMenu();

    if (groupName == null) {
      return;
    }

    final group = model.createBrowserGroup(
      name: groupName,
      tabId: tabId,
      originalGroupId: originalGroupId,
    );

    if (group != null) {
      _selectedGroupIdState.accept(group.id);
    }
  }

  void scrollTabList(double offset) {
    tabListScrollController.jumpTo(offset);
  }

  void _init() {
    model.activeGroupIdState.addListener(_handleActiveGroup);
    model.activeTabIdState.addListener(_handleActiveTab);
    model.allTabsIdsState.addListener(_handleAllTabs);
    _viewTabsState.addListener(_handleTabs);
    _selectedGroupIdState.addListener(_handleSelectedGroup);
    final groupId = model.activeGroupIdState.value;

    if (groupId != null) {
      _viewTabsState.accept(model.getGroupTabs(groupId));
    }
  }

  void _handleActiveGroup() {
    _selectedGroupIdState.accept(model.activeGroupIdState.value);
  }

  Future<void> _handleActiveTab() async {
    final activeGroupId = model.activeGroupIdState.value;
    final activeTabId = model.activeTabId;

    if (checkIsVisiblePages()) {
      if (_tabsPrevCount != null &&
          _tabsCount != null &&
          _tabsPrevCount! < _tabsCount!) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onUpdateActiveTab(true);
        });
      }
    } else if (activeGroupId != null && activeTabId != null) {
      _selectedGroupIdState.accept(activeGroupId);

      _viewTabsState.accept(model.getGroupTabs(activeGroupId));

      final data = tabsRenderManager.getRenderData(activeTabId);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        onUpdateActiveTab(false);
      });

      var xLeft = data?.xLeft;
      var yTop = data?.yTop;

      if (data == null && (_tabsCount ?? 0) > (_tabsPrevCount ?? 0)) {
        final position = _calculatePosition();
        xLeft = position.$1;
        yTop = position.$2;
      }

      _tabAnimationTypeState.accept(
        ShowViewAnimationType(tabX: xLeft, tabY: yTop),
      );
    }

    if (_tabsCount != null &&
        _tabsPrevCount != null &&
        _tabsCount! < _tabsPrevCount!) {
      _updateCount();
    }
  }

  void _handleAllTabs() {
    _updateCount();

    final activeGroupId = model.activeGroupIdState.value;

    if (activeGroupId != null) {
      _viewTabsState.accept(model.getGroupTabs(activeGroupId));
    }
  }

  void _handleTabs() {
    if (_viewTabsState.value?.isEmpty ?? true) {
      onEmptyTabs();
    }
  }

  void _updateCount() {
    _tabsPrevCount = _tabsCount;
    _tabsCount = model.allTabsIdsState.value.length;
  }

  void _handleSelectedGroup() {
    final offset = _groupsScrollOffsets[_selectedGroupIdState.value];
    if (offset != null) {
      tabListScrollController.jumpTo(offset);
    }
  }

  (double, double) _calculatePosition() {
    final count = _tabsCount;

    if (count == null || count == 0) {
      return (0.0, 0.0);
    }

    final itemWidth = tabsRenderManager.itemWidth;
    final itemHeight = tabsRenderManager.itemHeight;

    var xLeft = count.isEven ? itemWidth * (count - 1) : 0.0;
    final yTop = itemHeight * (count - 1);

    return (xLeft, yTop);
  }
}
