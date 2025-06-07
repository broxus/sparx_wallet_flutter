import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
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

  NotNullListenableState<List<String>> get allGroupsIdsState =>
      _browserService.tab.allGroupsIdsState;

  ListenableState<String?> get activeGroupIdState =>
      _browserService.tab.activeGroupIdState;

  int? get allGroupsCount => allGroupsIdsState.value.length;

  String? getGroupNameById(String groupId) =>
      _browserService.tab.getGroupListenableById(groupId)?.value.title;

  void setActiveGroup(String groupId) {
    _browserService.tab.setActiveGroup(groupId);
  }

  void createBrowserGroup(String name) =>
      _browserService.tab.createBrowserGroup(
        name: name,
      );

  void updateGroupName({
    required String groupId,
    required String name,
  }) {
    _browserService.tab.updateGroupName(
      groupId: groupId,
      name: name,
    );
  }

  void removeGroup(String groupId) {
    _browserService.tab.removeBrowserGroup(groupId);
  }

  NotNullListenableState<BrowserGroup>? getGroupListenableById(
    String groupId,
  ) =>
      _browserService.tab.getGroupListenableById(groupId);
}
