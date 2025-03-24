import 'package:app/feature/browser_v2/managers/favicon_manager.dart';
import 'package:app/feature/browser_v2/service/browser_service.dart';
import 'package:app/feature/browser_v2/widgets/favicon_view/favicon_view.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [FaviconView]
class FaviconViewModel extends ElementaryModel {
  FaviconViewModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<FaviconData> get allFaviconsState =>
      _browserService.fM.faviconsState;

  void fetchFavicons(Uri? uri) {
    if (uri == null) {
      return;
    }
    _browserService.fM.fetchFavicon(uri);
  }
}
