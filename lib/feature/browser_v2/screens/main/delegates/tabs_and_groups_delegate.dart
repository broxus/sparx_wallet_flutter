import 'dart:async';

import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/clear_tabs_bottom_sheet.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

abstract interface class BrowserTabsAndGroupsUi {
  ListenableState<List<BrowserTab>?> get viewTabsState;

  ListenableState<String?> get hostState;

  ListenableState<String?> get selectedGroupIdState;

  ListenableState<TabAnimationType?> get tabAnimationTypeState;

  void onPressedGroup(String groupId);

  void onCloseAllPressed();

  void addTab();

  void changeTab({
    required String groupId,
    required String tabId,
  });
}

class BrowserTabsAndGroupsDelegate implements BrowserTabsAndGroupsUi {
  BrowserTabsAndGroupsDelegate(
    this.context,
    this.model, {
    required this.renderManager,
    required this.onEmptyTabs,
    required this.onUpdateActiveTab,
    required this.onChangeTab,
    required this.scrollToTab,
    required this.checkIsVisiblePages,
  }) {
    _init();
  }

  final BuildContext context;
  final BrowserMainScreenModel model;
  final BrowserRenderManager renderManager;
  final VoidCallback onEmptyTabs;
  final VoidCallback onUpdateActiveTab;
  final VoidCallback onChangeTab;
  final Future<bool> Function({
    required String groupId,
    required String tabId,
  }) scrollToTab;
  final bool Function() checkIsVisiblePages;

  final _tabAnimationTypeState = StateNotifier<TabAnimationType?>();

  late final _viewTabsState = StateNotifier<List<BrowserTab>?>();

  final _hostState = StateNotifier<String?>();

  late final _selectedGroupIdState = StateNotifier<String?>(
    initValue: model.activeGroupState.value?.id,
  );

  @override
  ListenableState<String?> get selectedGroupIdState => _selectedGroupIdState;

  @override
  ListenableState<List<BrowserTab>?> get viewTabsState => _viewTabsState;

  @override
  ListenableState<String?> get hostState => _hostState;

  @override
  ListenableState<TabAnimationType?> get tabAnimationTypeState =>
      _tabAnimationTypeState;

  String? get activeTabId => model.activeTabId;

  bool get isEmptyActiveTabUrl => _activeTab?.url.toString().isEmpty ?? false;

  BrowserTab? get _activeTab => model.getTabById(activeTabId);

  void dispose() {
    model.activeGroupState.removeListener(_handleActiveGroup);
    model.activeTabState.removeListener(_handleActiveTab);
    model.allTabsState.removeListener(_handleAllTabs);
    _selectedGroupIdState.dispose();
    _tabAnimationTypeState.dispose();
    _viewTabsState.removeListener(_handleTabs);
  }

  @override
  void changeTab({
    required String groupId,
    required String tabId,
  }) {
    final data = renderManager.getRenderData(tabId);

    _tabAnimationTypeState.accept(
      ShowViewAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );
    model
      ..setActiveGroup(groupId)
      ..setActiveTab(tabId);
    onChangeTab();
  }

  @override
  void onPressedGroup(String groupId) {
    _selectedGroupIdState.accept(groupId);
  }

  void onTabAnimationStart(ValueChanged<bool> onComplete) {
    if (_tabAnimationTypeState.value == null) {
      return;
    }
    if (_tabAnimationTypeState.value is ShowTabsAnimationType) {
      onComplete(false);
    }
  }

  void onTabAnimationEnd(ValueChanged<bool> onComplete) {
    if (_tabAnimationTypeState.value == null) {
      return;
    }

    if (_tabAnimationTypeState.value is ShowViewAnimationType) {
      onComplete(true);
    }

    _tabAnimationTypeState.accept(null);
  }

  int? getTabIndexById({
    required String groupId,
    required String tabId,
  }) {
    return model.getTabIndex(
      groupId: groupId,
      tabId: tabId,
    );
  }

  String? getIdByIndex({
    required String groupId,
    required int index,
  }) =>
      model.getTabIdByIndex(
        groupId: groupId,
        index: index,
      );

  @override
  Future<void> onCloseAllPressed() async {
    final isClear = await showBrowserClearTabsSheet(context: context);
    if (isClear ?? false) {
      model.clearTabs();
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
    final data = id == null ? null : renderManager.getRenderData(id);

    _tabAnimationTypeState.accept(
      ShowViewAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );
  }

  void animateShowTabs() {
    final id = activeTabId;
    final data = id == null ? null : renderManager.getRenderData(id);

    _tabAnimationTypeState.accept(
      ShowTabsAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );
  }

  Future<void> createGroup(
    BuildContext context, {
    String? tabId,
  }) async {
    // TODO(knightforce): Temp. Compass is expected to be implemented
    final groupName =
        await Navigator.of(context, rootNavigator: true).push<String>(
      MaterialPageRoute(
        builder: (_) {
          return CreateBrowserGroupScreen(
            tabId: tabId,
          );
        },
      ),
    );

    if (groupName == null) {
      return;
    }

    final group = model.createBrowserGroup(
      name: groupName,
      tabId: tabId,
    );

    if (group != null) {
      _selectedGroupIdState.accept(group.id);
    }
  }

  void _init() {
    model.activeGroupState.addListener(_handleActiveGroup);
    model.activeTabState.addListener(_handleActiveTab);
    model.allTabsState.addListener(_handleAllTabs);
    _viewTabsState.addListener(_handleTabs);
    final groupId = model.activeGroupState.value?.id;

    if (groupId != null) {
      _viewTabsState.accept(model.getGroupTabs(groupId));
    }
  }

  void _handleActiveGroup() {
    _selectedGroupIdState.accept(model.activeGroupState.value?.id);
  }

  Future<void> _handleActiveTab() async {
    if (checkIsVisiblePages()) {
      return;
    }

    final activeGroupId = model.activeGroupState.value?.id;
    final activeTabId = model.activeTabId;

    if (activeGroupId == null || activeTabId == null) {
      return;
    }

    _selectedGroupIdState.accept(activeGroupId);
    _viewTabsState.accept(model.getGroupTabs(activeGroupId));

    onUpdateActiveTab();

    final data = renderManager.getRenderData(activeTabId);

    await scrollToTab(
      groupId: activeGroupId,
      tabId: activeTabId,
    );

    _tabAnimationTypeState.accept(
      ShowViewAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );

    onChangeTab();
  }

  void _handleAllTabs() {
    final activeGroupId = model.activeGroupState.value?.id;

    if (activeGroupId != null) {
      _viewTabsState.accept(model.getGroupTabs(activeGroupId));
    }
  }

  void _handleTabs() {
    if (_viewTabsState.value?.isEmpty ?? true) {
      onEmptyTabs();
    }
  }
}
