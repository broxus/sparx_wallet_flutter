import 'package:app/app/router/router.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/route.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';

@injectable
class BrowserLauncher {
  BrowserLauncher(this._compassRouter, this._browserService);

  final CompassRouter _compassRouter;
  final BrowserService _browserService;

  void openBrowserByUri(Uri uri) {
    return _openBrowserByWebUri(WebUri.uri(uri));
  }

  void openBrowserByString(String url) {
    return _openBrowserByWebUri(WebUri(url));
  }

  void _openBrowserByWebUri(WebUri webUri) {
    _showBrowserIfNeed();

    _browserService.tab.openUrl(webUri);
  }

  void _showBrowserIfNeed() {
    if (_compassRouter.currentRoutes.lastOrNull is! BrowserRoute) {
      _compassRouter.compassPointNamed(const BrowserRouteData());
    }
  }
}
