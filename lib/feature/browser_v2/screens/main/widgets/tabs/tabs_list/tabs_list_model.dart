import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [BrowserTabsList]
class BrowserTabsListModel extends ElementaryModel {
  BrowserTabsListModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  NotNullListenableState<List<String>> get allTabsIdsState =>
      _browserService.tab.allTabsIdsState;

  List<NotNullListenableState<BrowserTab>> getGroupTabs(String groupId) {
    return _browserService.tab.getGroupTabsListenable(groupId);
  }

  List<String>? getTabIds(String groupId) {
    return _browserService.tab.getTabIds(groupId);
  }

  void removeBrowserTab({
    required String groupId,
    required String tabId,
  }) {
    _browserService.tab.removeBrowserTab(
      groupId: groupId,
      tabId: tabId,
    );
  }
}
