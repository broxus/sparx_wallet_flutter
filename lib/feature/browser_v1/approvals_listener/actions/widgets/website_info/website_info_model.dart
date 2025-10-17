import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class WebsiteInfoModel extends ElementaryModel {
  WebsiteInfoModel(ErrorHandler errorHandler, this._browserService)
    : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  Future<String?> getFaviconUrl(Uri uri) =>
      _browserService.fav.getFaviconURL(uri);
}
