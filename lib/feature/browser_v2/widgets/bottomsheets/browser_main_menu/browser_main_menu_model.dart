import 'package:app/feature/browser_v2/service/browser_service.dart';
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
    final id = _browserService.tM.activeTabId;

    if (id == null) {
      return;
    }

    _browserService.createTabBookMark(id);
  }

  void createTab() {
    _browserService.tM.createEmptyTab();
  }

  void reload() {
    _browserService.tM.refreshActiveTab();
  }
}
