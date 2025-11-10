import 'package:app/app/router/router.dart';
import 'package:app/feature/browser/data/browser_uri.dart';
import 'package:app/feature/browser/domain/service/browser_service.dart';
import 'package:app/feature/browser/screens/main/route.dart';
import 'package:injectable/injectable.dart';

@injectable
class BrowserLauncher {
  BrowserLauncher(this._compassRouter, this._browserService);

  final CompassRouter _compassRouter;
  final BrowserService _browserService;

  void openBrowserByUri(Uri uri) {
    return _openBrowserByWebUri(BrowserUri.uri(uri));
  }

  void openBrowserByString(String url, {bool isInternalAppUri = true}) {
    return _openBrowserByWebUri(
      BrowserUri(url, isInternalAppUri: isInternalAppUri),
    );
  }

  void _openBrowserByWebUri(BrowserUri browserUri) {
    _showBrowserIfNeed();

    _browserService.tab.openUrl(browserUri);
  }

  void _showBrowserIfNeed() {
    if (_compassRouter.currentRoutes.lastOrNull is! BrowserRoute) {
      _compassRouter.compassPointNamed(const BrowserRouteData());
    }
  }
}
