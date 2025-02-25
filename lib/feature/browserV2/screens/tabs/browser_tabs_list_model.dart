import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/tabs/browser_tabs_list.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserTabsList]
class BrowserTabsListModel extends ElementaryModel {
  BrowserTabsListModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<BrowserTabsData> get tabsState =>
      _browserService.tM.tabsState;

  void setActiveTab(String id) {
    _browserService.tM.setActiveTab(id);
  }

  void removeBrowserTab(String id) {
    _browserService.tM.removeBrowserTab(id);
  }
}
