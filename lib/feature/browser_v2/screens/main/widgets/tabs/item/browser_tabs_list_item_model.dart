import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [BrowserTabsListItem]
@injectable
class BrowserTabsListItemModel extends ElementaryModel {
  BrowserTabsListItemModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<String?> get activeTabIdState =>
      _browserService.tab.activeTabIdState;

  ListenableState<Map<String, String>> get screenshotsState =>
      _browserService.tab.screenshotsState;
}
