import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/groups/groups_data.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserTabsList]
class BrowserTabsListModel extends ElementaryModel {
  BrowserTabsListModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<List<BrowserGroup>> get allGroupsState =>
      _browserService.tabs.allGroupsState;

  ListenableState<ActiveGroupData?> get activeGroupState =>
      _browserService.tabs.activeGroupState;

  List<BrowserTab> getGroupTabs(String groupId) {
    return _browserService.tabs.getGroupTabs(groupId);
  }

  void removeBrowserTab({
    required String groupId,
    required String tabId,
  }) {
    _browserService.tM.removeBrowserTab(
      groupId: groupId,
      tabId: tabId,
    );
  }
}
