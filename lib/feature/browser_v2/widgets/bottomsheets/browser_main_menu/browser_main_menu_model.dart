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
    final id = _browserService.tM.activeTabIdState.value;

    if (id == null) {
      return;
    }

    _browserService.createTabBookMark(id);
  }

  void createTab(String groupId) {
    _browserService.tM.createEmptyTab(groupId);
  }

  void reload() {
    _browserService.tM.refreshActiveTab();
  }

  Future<void> clearData(TimePeriod period, Set<TypeHistory> targets) async {
    _browserService.clearData(period, targets);
  }
}
