import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/browser_view/browser_tabs_view_screen.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserTabsViewScreen]
class BrowserTabsViewScreenModel extends ElementaryModel {
  BrowserTabsViewScreenModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<BrowserTabsData?> get tabsState =>
      _browserService.tM.tabsState;

  List<BrowserTab> get browserTabs => _browserService.tM.browserTabs;
}
