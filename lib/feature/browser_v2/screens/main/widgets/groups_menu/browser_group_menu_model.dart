import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/groups/groups_data.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/groups_menu/browser_group_menu.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserGroupMenu]
class BrowserGroupMenuModel extends ElementaryModel {
  BrowserGroupMenuModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<List<BrowserGroup>> get allGroupsState =>
      _browserService.tabs.allGroupsState;

  ListenableState<ActiveGroupData?> get activeGroupState =>
      _browserService.tabs.activeGroupState;

  int? get allGroupsCount => allGroupsState.value?.length;

  void setActiveGroup(String groupId) {
    _browserService.tabs.setActiveTab(groupId: groupId);
  }

  void createBrowserGroup(String name) =>
      _browserService.tabs.createBrowserGroup(
        name: name,
      );
}
