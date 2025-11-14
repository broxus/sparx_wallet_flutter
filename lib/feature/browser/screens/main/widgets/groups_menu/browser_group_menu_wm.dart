import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser/data/groups/browser_group.dart';
import 'package:app/feature/browser/screens/create_group/create_browser_group_screen.dart';
import 'package:app/feature/browser/screens/main/widgets/groups_menu/browser_group_menu.dart';
import 'package:app/feature/browser/screens/main/widgets/groups_menu/browser_group_menu_model.dart';
import 'package:app/feature/browser/screens/main/widgets/groups_menu/widgets/edit_group_name_bottom_sheet.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

typedef GroupData = NotNullListenableState<BrowserGroup>;

/// [WidgetModel] для [BrowserGroupMenu]
@injectable
class BrowserGroupMenuWidgetModel
    extends CustomWidgetModel<BrowserGroupMenu, BrowserGroupMenuModel> {
  BrowserGroupMenuWidgetModel(super.model);

  late final _groupsState = createNotifier<List<GroupData>>();
  late final _editGroupsState = createNotNullNotifier<bool>(false);

  ListenableState<List<GroupData>> get groupsState => _groupsState;

  ListenableState<bool> get editGroupsState => _editGroupsState;

  ListenableState<String?> get activeGroupIdState => model.activeGroupIdState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.allGroupsIdsState.addListener(_handleGroups);
  }

  @override
  void dispose() {
    model.allGroupsIdsState.removeListener(_handleGroups);
    super.dispose();
  }

  void _handleGroups() {
    final result = <NotNullListenableState<BrowserGroup>>[];

    for (final id in model.allGroupsIdsState.value) {
      final listenable = model.getGroupListenableById(id);

      if (listenable == null) {
        continue;
      }

      result.add(listenable);
    }

    _groupsState.accept(result);
  }

  void onPressedEditAll() {
    _editGroupsState.accept(true);
  }

  void onPressedDone() {
    if (_editGroupsState.value) {
      _editGroupsState.accept(false);
      return;
    }
    Navigator.of(context).pop();
  }

  void onPressedItem(String groupId) {
    model.setActiveGroup(groupId);
    Navigator.of(context).pop();
  }

  Future<void> onPressedEditGroup(String groupId) async {
    final groupName = model.getGroupNameById(groupId);

    if (groupName == null) {
      return;
    }

    final newName = (await showBrowserEditNameMenu(context, groupName))?.trim();

    if (newName == null || groupName == newName) {
      return;
    }

    model.updateGroupName(groupId: groupId, name: newName);
  }

  void onPressedRemoveGroup(String groupId) {
    model.removeGroup(groupId);
  }

  Future<void> onPressedNewGroup() async {
    // TODO(knightforce): Temp. Compass is expected to be implemented

    final groupName = await Navigator.of(context, rootNavigator: true)
        .push<String>(
          MaterialPageRoute(
            builder: (_) {
              return const CreateBrowserGroupScreen();
            },
          ),
        );

    if (groupName == null) {
      return;
    }

    model.createBrowserGroup(groupName);
  }
}
