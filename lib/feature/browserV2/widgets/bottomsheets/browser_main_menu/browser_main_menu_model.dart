import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/browser_main_menu/browser_main_menu.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [BrowserMainMenu]
class BrowserMainMenuModel extends ElementaryModel {
  BrowserMainMenuModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  void addCurrentToBookmark() {
    _browserService.createCurrentTabBookMark();
  }
}
