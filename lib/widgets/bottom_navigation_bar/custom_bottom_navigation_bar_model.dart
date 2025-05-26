import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app/app/service/app_links/app_links_service.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [CustomBottomNavigationBar]
class CustomBottomNavigationBarModel extends ElementaryModel {
  CustomBottomNavigationBarModel(
    ErrorHandler errorHandler,
    this._appLinksService,
    this._router,
  ) : super(errorHandler: errorHandler);

  final AppLinksService _appLinksService;
  final CompassRouter _router;

  Stream<BrowserAppLinksData> get browserLinksStream =>
      _appLinksService.browserLinksStream;

  Stream<RootTab> get rootTabStream => _router.currentRoutesStream
      .map((it) => RootTab.getByRoute(it.firstOrNull));

  Stream<bool> get isBottomBarVisibleStream => _router.currentRoutesStream.map(
        (it) {
          final currentRoute = it.lastOrNull;
          return currentRoute?.isBottomNavigationBarVisible ?? false;
        },
      ).distinct();
}
