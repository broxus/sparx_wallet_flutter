import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser/data/groups/browser_group.dart';
import 'package:app/feature/browser/domain/service/browser_service.dart';
import 'package:app/feature/browser/screens/main/widgets/tabs/tabs_list/widgets/header/tab_list_header.dart';

import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [TabListHeader]
@injectable
class TabListHeaderModel extends ElementaryModel {
  TabListHeaderModel(ErrorHandler errorHandler, this._browserService)
    : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  NotNullListenableState<List<String>> get groupsIdsState =>
      _browserService.tab.allGroupsIdsState;

  NotNullListenableState<BrowserGroup>? getGroupListenable(String groupId) =>
      _browserService.tab.getGroupListenableById(groupId);
}
