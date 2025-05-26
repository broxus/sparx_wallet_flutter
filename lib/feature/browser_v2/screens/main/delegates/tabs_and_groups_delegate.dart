import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/clear_tabs_bottom_sheet.dart';
import 'package:app/utils/common_utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

abstract interface class BrowserTabsAndGroupsUi {
  ListenableState<List<BrowserTab>?> get tabsState;

  ListenableState<String?> get hostState;

  ListenableState<String?> get selectedGroupIdState;

  ListenableState<TabAnimationType?> get tabAnimationTypeState;

  void changeTab({
    required String groupId,
    required String tabId,
  });

  void onPressedGroup(String groupId);

  void onCloseAllPressed();

  void addTab();
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

  final _tabAnimationTypeState = StateNotifier<TabAnimationType?>();

  final _tabsState = StateNotifier<List<BrowserTab>?>();

  final _hostState = StateNotifier<String?>();

  late final _selectedGroupIdState = StateNotifier<String?>(
    initValue: model.activeGroupState.value?.activeTabId,
  );

  // final _selectedGroupTabsState = StateNotifier<List<BrowserTab>?>();

  @override
  ListenableState<String?> get selectedGroupIdState => _selectedGroupIdState;

  @override
  ListenableState<List<BrowserTab>?> get tabsState => _tabsState;

  @override
  ListenableState<String?> get hostState => _hostState;

  // @override
  // ListenableState<List<BrowserTab>?> get selectedGroupTabsState =>
  //     _selectedGroupTabsState;

  @override
  ListenableState<TabAnimationType?> get tabAnimationTypeState =>
      _tabAnimationTypeState;

  String? get activeTabId => model.activeGroupState.value?.activeTabId;

  bool get isEmptyActiveTabUrl => _activeTab?.url.toString().isEmpty ?? false;

  BrowserTab? get _activeTab => model.getTabById(activeTabId);

  void dispose() {
    // _tabsState.removeListener(_handleActiveGroupTabsCollection);
    model.activeGroupState.removeListener(onUpdateActiveTab);
    _selectedGroupIdState.dispose();
    // model.activeGroupState.removeListener(_matchTabs);
    _tabAnimationTypeState.dispose();
    _tabsState.removeListener(_handleTabs);
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
  void changeTab({
    required String groupId,
    required String tabId,
  }) {
    model.setActiveTab(groupId: groupId, tabId: tabId);

    callWithDelay(() async {
      if (tabId != activeTabId) {
        final isSuccess = await scrollToTab(
          groupId: groupId,
          tabId: tabId,
        );
        if (isSuccess) {
          model.setActiveTab(
            groupId: groupId,
            tabId: tabId,
          );
        }
      }

      final data = renderManager.getRenderData(tabId);

      _tabAnimationTypeState.accept(
        ShowViewAnimationType(
          tabX: data?.xLeft,
          tabY: data?.yTop,
        ),
      );

      if (model.activeGroupState.value?.groupId != groupId) {
        _tabsState.accept(model.getGroupTabs(groupId));
      }
      onChangeTab();
    });
  }

  // @override
  // void onPressedGroup(String groupId) {
  //   _selectedGroupTabsState.accept(model.getGroupTabs(groupId));
  // }

  // @override
  // void onCloseTab(String tabId) {
  //   model.removeBrowserTab(tabId);
  // }

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

  void _init() {
    _tabsState.addListener(_handleTabs);
    tabsState.addListener(onUpdateActiveTab);
  }

  void _handleTabs() {
    if (_tabsState.value?.isEmpty ?? true) {
      onEmptyTabs();
    }
  }
}
