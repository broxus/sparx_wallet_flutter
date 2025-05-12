import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/primary/route.dart';
import 'package:app/feature/browser/tabs/route.dart';
import 'package:app/feature/browser/view/browser_page.dart';
import 'package:injectable/injectable.dart';

@singleton
class BrowserRoute extends CompassShellRoute {
  BrowserRoute({
    required this.browserPrimaryRoute,
    required this.browserTabsRoute,
  }) : super(
          builder: (context, state, shell) => BrowserPage(
            child: shell,
          ),
          compassBaseRoutes: [
            browserPrimaryRoute,
            browserTabsRoute,
          ],
        );

  final BrowserPrimaryRoute browserPrimaryRoute;
  final BrowserTabsRoute browserTabsRoute;
}
