import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/groups/groups_data.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/header/tab_list_header.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [TabListHeader]
class TabListHeaderModel extends ElementaryModel {
  TabListHeaderModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<BrowserGroupsCollection> get groupsState =>
      _browserService.groups.groupsState;

  ListenableState<BrowserGroup?> get activeGroupState =>
      _browserService.groups.activeGroupState;

  void setActiveGroup(String id) => _browserService.groups.setActiveGroup(id);

  String createBrowserGroup({
    String? title,
    List<String>? tabsIds,
  }) =>
      _browserService.groups.createBrowserGroup(
        title: title,
        tabsIds: tabsIds,
      );
}
