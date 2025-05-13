import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/primary/route.dart';
import 'package:app/feature/browser/tabs/route.dart';
import 'package:app/feature/browser/view/browser_page.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class BrowserRoute extends CompassShellRoute {
  BrowserRoute(
    @Named.from(BrowserPrimaryRoute) CompassBaseRoute browserPrimaryRoute,
    @Named.from(BrowserTabsRoute) CompassBaseRoute browserTabsRoute,
  ) : super(
          builder: (context, state, shell) => BrowserPage(
            child: shell,
          ),
          compassBaseRoutes: [
            browserPrimaryRoute,
            browserTabsRoute,
          ],
        );
}
