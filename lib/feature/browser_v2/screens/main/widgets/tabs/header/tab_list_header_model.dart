import 'package:app/feature/browser_v2/data/tabs_data.dart';
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

  // TODO(knightforce): temp. Refacrtor in groub task
  ListenableState<BrowserTabsCollection> get tabsState =>
      _browserService.tabs.tabsState;

  final BrowserService _browserService;
}
