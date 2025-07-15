import 'package:app/feature/browser_v2/data/history_type.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [BrowserMainMenu]
class BrowserMainMenuModel extends ElementaryModel {
  BrowserMainMenuModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  void addCurrentToBookmark() {
    final id = _browserService.tab.activeTabIdState.value;

    if (id == null) {
      return;
    }

    _browserService.createTabBookMark(id);
  }

  (String, String) createTab(String groupId) {
    return _browserService.tab.createEmptyTab(groupId);
  }

  void reload() {
    _browserService.tab.refreshActiveTab();
  }

  Future<void> clearData(TimePeriod period, Set<TypeHistory> targets) async {
    _browserService.clearData(period, targets);
  }
}
