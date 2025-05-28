import 'dart:math';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/groups_menu/browser_group_menu.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/groups_menu/browser_group_menu_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

typedef GroupsData = (List<BrowserGroup>?, String?);

/// Factory method for creating [BrowserGroupMenuWidgetModel]
BrowserGroupMenuWidgetModel defaultBrowserGroupMenuWidgetModelFactory(
  BuildContext context,
) {
  return BrowserGroupMenuWidgetModel(
    BrowserGroupMenuModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserGroupMenu]
class BrowserGroupMenuWidgetModel
    extends CustomWidgetModel<BrowserGroupMenu, BrowserGroupMenuModel> {
  BrowserGroupMenuWidgetModel(
    super.model,
  );

  late final _groupsState = createNotifier<GroupsData>();
  late final _editGroupsState = createNotNullNotifier<bool>(false);

  ListenableState<GroupsData> get groupsState => _groupsState;

  ListenableState<bool> get editGroupsState => _editGroupsState;

  @override
  void initWidgetModel() {
    model.allGroupsState.addListener(_handleGroups);
    model.activeGroupState.addListener(_handleGroups);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    model.allGroupsState.removeListener(_handleGroups);
    model.activeGroupState.removeListener(_handleGroups);
    super.dispose();
  }

  void _handleGroups() {
    _groupsState.accept(
      (
        model.allGroupsState.value,
        model.activeGroupState.value?.groupId,
      ),
    );
  }

  void onPressedEditAll() {
    _editGroupsState.accept(true);
  }

  void onPressedDone() {
    Navigator.of(context).pop();
  }

  void onPressedItem(String groupId) {
    model.setActiveGroup(groupId);
  }

  void onPressedEditGroup(String groupId) {}

  void onPressedRemoveGroup(String groupId) {}

  Future<void> onPressedNewGroup() async {
    // TODO(knightforce): Temp. Compass is expected to be implemented

    final groupName =
        await Navigator.of(context, rootNavigator: true).push<String>(
      MaterialPageRoute(
        builder: (_) {
          return CreateBrowserGroupScreen();
        },
      ),
    );

    if (groupName == null) {
      return;
    }

    model.createBrowserGroup(groupName);
  }
}
