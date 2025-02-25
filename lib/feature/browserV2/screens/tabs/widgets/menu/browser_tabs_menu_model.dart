import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/tabs/widgets/menu/browser_tabs_menu.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserTabsMenu]
class BrowserTabsMenuModel extends ElementaryModel {
  BrowserTabsMenuModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<BrowserTabsData> get tabsState =>
      _browserService.tM.tabsState;

  void clearTabs() => _browserService.tM.clearTabs();

  void createEmptyTab() => _browserService.tM.createEmptyTab();
}
