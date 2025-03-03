import 'package:app/app/router/app_route.dart';
import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app/app/service/app_links/app_links_service.dart';
import 'package:app/app/service/navigation/service/navigation_service.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [CustomBottomNavigationBar]
class CustomBottomNavigationBarModel extends ElementaryModel {
  CustomBottomNavigationBarModel(
    ErrorHandler errorHandler,
    this._appLinksService,
    this._navigationService,
  ) : super(errorHandler: errorHandler);

  final AppLinksService _appLinksService;

  final NavigationService _navigationService;

  int get tabIndex => RootTab.getByPath(
        getRootPath(fullPath: _navigationService.state.fullPath),
      ).index;

  Stream<BrowserAppLinksData> get browserLinksStream =>
      _appLinksService.browserLinksStream;
}
