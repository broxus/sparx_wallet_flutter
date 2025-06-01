import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/tab_list_header.dart';

import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [TabListHeader]
class TabListHeaderModel extends ElementaryModel {
  TabListHeaderModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  NotNullListenableState<List<String>> get groupsIdsState =>
      _browserService.tabs.allGroupsIdsState;

  NotNullListenableState<BrowserGroup>? getGroupListenable(String groupId) =>
      _browserService.tabs.getGroupListenableById(groupId);
}
