import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/data/tabs/tabs_data.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/clear_tabs_bottom_sheet.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

abstract interface class BrowserTabsAndGroupsUi {
  ListenableState<BrowserTabsCollection?> get tabsState;

  ListenableState<BrowserTab?> get activeTabState;

  ListenableState<TabAnimationType?> get tabAnimationTypeState;

  void changeTab(String id);

  void onCloseTab(String id);

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
  final Future<bool> Function(String int) scrollToTab;

  final _tabAnimationTypeState = StateNotifier<TabAnimationType?>();

  final _tabsState = StateNotifier<BrowserTabsCollection?>();

  @override
  ListenableState<BrowserTabsCollection?> get tabsState =>
      _tabsState;

  @override
  ListenableState<BrowserTab?> get activeTabState => model.activeTabState;

  @override
  ListenableState<TabAnimationType?> get tabAnimationTypeState =>
      _tabAnimationTypeState;

  BrowserTabsCollection? get _tabsCollection =>
      _tabsState.value;

  String? get activeTabId => _activeTab?.id;

  bool get isEmptyActiveTabUrl => _activeTab?.url.toString().isEmpty ?? false;

  BrowserTab? get _activeTab => activeTabState.value;

  BrowserGroup? get _activeGroup => model.activeGroupState.value;

  void dispose() {
    _tabsState.removeListener(_handleActiveGroupTabsCollection);
    activeTabState.removeListener(onUpdateActiveTab);
    model.activeGroupState.removeListener(_matchTabs);
    _tabAnimationTypeState.dispose();
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

  int? getTabIndexById(String tabId) {
    return _tabsCollection?.getIndexById(tabId);
  }

  String? getIdByIndex(int index) =>
      _tabsCollection?.getIdByIndex(index);

  @override
  Future<void> changeTab(String id) async {
    if (_tabsCollection == null) {
      return;
    }

    if (id != activeTabId) {
      final isSuccess = await scrollToTab(id);
      if (isSuccess) {
        model.setActiveTab(id);
      }
    }

    final data = renderManager.getRenderData(id);

    _tabAnimationTypeState.accept(
      ShowViewAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );

    onChangeTab();
  }

  @override
  void onCloseTab(String id) {
    model.removeBrowserTab(id);
  }

  @override
  Future<void> onCloseAllPressed() async {
    final isClear = await showBrowserClearTabsSheet(context: context);
    if (isClear ?? false) {
      model.clearTabs();
    }
  }

  @override
  void addTab() {
    model.createEmptyTab();
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
    model.activeGroupState.addListener(_matchTabs);
    _tabsState.addListener(_handleActiveGroupTabsCollection);
    activeTabState.addListener(onUpdateActiveTab);
  }

  void _handleActiveGroupTabsCollection() {
    _matchTabs();

    final isCountIncreased =
        _tabsCollection?.isCountIncreased ?? false;

    if (_tabsCollection?.isNotEmpty ?? true) {
      final id = _tabsCollection!.lastTab!.id;
      if (isCountIncreased) {
        changeTab(id);
      }
    } else {
      onEmptyTabs();
    }
  }

  void _matchTabs() {
    final allTabs = model.allTabsState.value;
    final activeGroupTabs = _activeGroup?.tabsIds;
    if (allTabs == null || activeGroupTabs == null) {
      return;
    }

    final result = <BrowserTab>[];

    for (final tab in allTabs.list) {
      if (activeGroupTabs.contains(tab.id)) {
        result.add(tab);
      }
    }

    _tabsState.accept(BrowserTabsCollection.fromList(result));
  }
}
