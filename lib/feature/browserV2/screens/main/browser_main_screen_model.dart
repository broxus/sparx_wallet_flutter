import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/main/browser_main_screen.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserMainScreen]
class BrowserMainScreenModel extends ElementaryModel {
  BrowserMainScreenModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);
  final BrowserService _browserService;

  ListenableState<BrowserTabsCollection> get tabsState =>
      _browserService.tM.tabsState;

  ListenableState<BrowserTab?> get activeTabState =>
      _browserService.tM.activeTabState;

  void setActiveTab(String id) {
    _browserService.tM.setActiveTab(id);
  }

  void removeBrowserTab(String id) {
    _browserService.tM.removeBrowserTab(id);
  }

  void clearTabs() => _browserService.tM.clearTabs();

  void createEmptyTab() => _browserService.tM.createEmptyTab();
}
