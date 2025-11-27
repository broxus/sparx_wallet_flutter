import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/screens/create_group/route.dart';
import 'package:app/feature/browser/screens/main/browser_main_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class BrowserRoute extends CompassRouteParameterless<BrowserRouteData> {
  BrowserRoute(
    @Named.from(CreateBrowserGroupRoute)
    CompassBaseRoute createBrowserGroupRoute,
  ) : super(
        name: 'browser',
        path: '/browser',
        isSaveLocation: true,
        bottomBarState: BottomBarState.expanded,
        builder: (context, _, __) => const BrowserMainScreen(),
        compassBaseRoutes: [createBrowserGroupRoute],
      );

  @override
  BrowserRouteData createData() {
    return const BrowserRouteData();
  }
}

class BrowserRouteData implements CompassRouteData {
  const BrowserRouteData();
}
