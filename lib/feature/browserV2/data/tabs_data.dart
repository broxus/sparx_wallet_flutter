import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:collection/collection.dart';

class BrowserTabsData {
  BrowserTabsData({
    List<BrowserTab>? tabs,
    this.activeTabId,
  }) : tabs = tabs ?? [];

  final List<BrowserTab> tabs;
  final String? activeTabId;

  List<BrowserTab> get sortedTabs {
    return [...tabs]..sort(
        (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
      );
  }

  late final activeTab = tabs.firstWhereOrNull((t) => t.id == activeTabId);

  late final count = tabs.length;

  BrowserTabsData copyWith({
    List<BrowserTab>? tabs,
    String? activeTabId,
  }) {
    return BrowserTabsData(
      tabs: tabs ?? this.tabs,
      activeTabId: activeTabId ?? this.activeTabId,
    );
  }
}
