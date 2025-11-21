import 'package:app/feature/browser/domain/service/browser_service.dart';
import 'package:app/feature/browser/widgets/favicon_view/favicon_view.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [FaviconView]
@injectable
class FaviconViewModel extends ElementaryModel {
  FaviconViewModel(ErrorHandler errorHandler, this._browserService)
    : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  Future<String?> getFavicon(Uri? uri) async {
    if (uri == null) {
      return null;
    }
    return _browserService.fav.getFaviconURL(uri);
  }
}
