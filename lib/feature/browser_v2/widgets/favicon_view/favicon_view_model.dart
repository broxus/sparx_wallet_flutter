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

  Future<String?> getFavicon(Uri? uri) async {
    if (uri == null) {
      return null;
    }
    return _browserService.fM.getFavicon(uri);
  }
}
