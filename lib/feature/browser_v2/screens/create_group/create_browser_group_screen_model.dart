import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [CreateBrowserGroupScreen]
class CreateBrowserGroupScreenModel extends ElementaryModel {
  CreateBrowserGroupScreenModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  BrowserTab? getTabsByIds(String? tabId) {
    if (tabId == null) {
      return null;
    }

    final allTabs = _browserService.tabs.allBrowserTabs;

    return allTabs.firstWhereOrNull((tab) => tabId == tab.id);
  }
}
