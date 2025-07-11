import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/data/tabs/tabs_data.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [CreateBrowserGroupScreen]
@injectable
class CreateBrowserGroupScreenModel extends ElementaryModel {
  CreateBrowserGroupScreenModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<ImageCache?> get screenshotsState =>
      _browserService.tab.screenshotsState;

  NotNullListenableState<BrowserTab>? getTabById(String? tabId) {
    if (tabId == null) {
      return null;
    }

    return _browserService.tab.getTabListenableById(tabId);
  }
}
