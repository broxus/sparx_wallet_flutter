import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/tabs_data.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserTabsListItem]
class BrowserTabsListItemModel extends ElementaryModel {
  BrowserTabsListItemModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<BrowserGroup?> get activeGroupState =>
      _browserService.tM.activeGroupState;

  String? get activeTabId => _browserService.tM.activeTab?.id;

  ListenableState<ImageCache?> get screenshotsState =>
      _browserService.tM.screenshotsState;
}
