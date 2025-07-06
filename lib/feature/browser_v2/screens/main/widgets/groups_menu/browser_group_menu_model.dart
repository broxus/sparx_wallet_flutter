import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/groups_menu/browser_group_menu.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

/// [ElementaryModel] for [BrowserGroupMenu]
class BrowserGroupMenuModel extends ElementaryModel {
  BrowserGroupMenuModel(
    ErrorHandler errorHandler,
    this._browserService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;
  final MessengerService _messengerService;

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

  (BrowserGroup?, VoidCallback) removeGroup(String groupId) {
    return _browserService.tab.removeBrowserGroup(groupId);
  }

  NotNullListenableState<BrowserGroup>? getGroupListenableById(
    String groupId,
  ) =>
      _browserService.tab.getGroupListenableById(groupId);

  void showUndoToast(
    String groupName,
    VoidCallback onAction,
  ) {
    _messengerService.show(
      Message.info(
        message: LocaleKeys.browserGroupDeleted.tr(
          args: [groupName],
        ),
        actionText: LocaleKeys.undo.tr(),
        onAction: onAction,
        topMargin: DimensSizeV2.d72,
        duration: const Duration(seconds: 20),
      ),
    );
  }
}
