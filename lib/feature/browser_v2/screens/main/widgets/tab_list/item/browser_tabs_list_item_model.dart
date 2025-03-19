import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/models/tab/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_list/item/browser_tabs_list_item.dart';
import 'package:app/feature/browser_v2/service/browser_service.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserTabsListItem]
class BrowserTabsListItemModel extends ElementaryModel {
  BrowserTabsListItemModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<BrowserTab?> get activeTabState =>
      _browserService.tM.activeTabState;

  ListenableState<ImageCache?> get screenshotsState =>
      _browserService.tM.screenshotsState;
}
