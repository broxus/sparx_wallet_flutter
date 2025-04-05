import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/models/tab/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen_model.dart';
import 'package:app/feature/browser_v2/screens/main/data/browser_render_manager.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';

class BrowserTabsDelegate {
  BrowserTabsDelegate(
    this.model, {
    required this.renderManager,
    required this.onEmptyTabs,
    required this.onUpdateActiveTab,
    required this.onChangeTab,
    required this.scrollToTab,
  }) {
    _init();
  }

  final BrowserMainScreenModel model;
  final BrowserRenderManager renderManager;
  final VoidCallback onEmptyTabs;
  final VoidCallback onUpdateActiveTab;
  final VoidCallback onChangeTab;
  final bool Function(String int) scrollToTab;

  late final _showAnimationState = StateNotifier<TabAnimationType?>();

  ListenableState<TabAnimationType?> get showAnimationState =>
      _showAnimationState;

  late int _lastTabsCount = _tabsCollection?.count ?? 0;

  ListenableState<BrowserTabsCollection> get tabsState => model.tabsState;

  ListenableState<BrowserTab?> get activeTabState => model.activeTabState;

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
