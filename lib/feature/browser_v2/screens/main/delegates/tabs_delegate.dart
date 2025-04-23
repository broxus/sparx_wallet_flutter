import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/data/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/clear_tabs_bottom_sheet.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

abstract interface class BrowserTabsUi {
  ListenableState<BrowserTabsCollection> get tabsState;

  ListenableState<BrowserTab?> get activeTabState;

  ListenableState<TabAnimationType?> get showAnimationState;

  void changeTab(String id);

  void onCloseTab(String id);

  void onCloseAllPressed();

  void addTab();
}

class BrowserTabsDelegate implements BrowserTabsUi {
  BrowserTabsDelegate(
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
  final bool Function(String int) scrollToTab;

  late final _showAnimationState = StateNotifier<TabAnimationType?>();

  late int _lastTabsCount = _tabsCollection?.count ?? 0;

  @override
  ListenableState<BrowserTabsCollection> get tabsState => model.tabsState;

  @override
  ListenableState<BrowserTab?> get activeTabState => model.activeTabState;

  @override
  ListenableState<TabAnimationType?> get showAnimationState =>
      _showAnimationState;

  BrowserTabsCollection? get _tabsCollection => tabsState.value;

  String? get activeTabId => _activeTab?.id;

  bool get isEmptyActiveTabUrl => _activeTab?.url.toString().isEmpty ?? false;

  BrowserTab? get _activeTab => activeTabState.value;

  void dispose() {
    tabsState.removeListener(_handleTabsCollection);
    activeTabState.removeListener(onUpdateActiveTab);
    _showAnimationState.dispose();
  }

  void onTabAnimationStart(ValueChanged<bool> onComplete) {
    if (_showAnimationState.value == null) {
      return;
    }
    if (_showAnimationState.value is ShowTabsAnimationType) {
      onComplete(false);
    }
  }

  void onTabAnimationEnd(ValueChanged<bool> onComplete) {
    if (_showAnimationState.value == null) {
      return;
    }

    if (_showAnimationState.value is ShowViewAnimationType) {
      onComplete(true);
    }

    _showAnimationState.accept(null);
  }

  int? getTabIndexById(String tabId) {
    return _tabsCollection?.getIndexById(tabId);
  }

  String? getIdByIndex(int index) => _tabsCollection?.getIdByIndex(index);

  @override
  void changeTab(String id) {
    if (_tabsCollection == null) {
      return;
    }

    if (id != activeTabId) {
      final isSuccess = scrollToTab(id);
      if (isSuccess) {
        model.setActiveTab(id);
      }
    }

    final data = renderManager.getRenderData(id);

    _showAnimationState.accept(
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

    _showAnimationState.accept(
      ShowViewAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );
  }

  void animateShowTabs() {
    final id = activeTabId;
    final data = id == null ? null : renderManager.getRenderData(id);

    _showAnimationState.accept(
      ShowTabsAnimationType(
        tabX: data?.xLeft,
        tabY: data?.yTop,
      ),
    );
  }

  void _init() {
    tabsState.addListener(_handleTabsCollection);
    activeTabState.addListener(onUpdateActiveTab);
  }

  void _handleTabsCollection() {
    final count = _tabsCollection?.count ?? 0;
    if (_tabsCollection?.isNotEmpty ?? true) {
      final id = _tabsCollection!.lastTab!.id;
      if (count > _lastTabsCount) {
        changeTab(id);
      }
    } else {
      onEmptyTabs();
    }

    _lastTabsCount = count;
  }
}
