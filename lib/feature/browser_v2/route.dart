import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class BrowserRoute extends CompassRouteParameterless<BrowserRouteData> {
  BrowserRoute()
      : super(
          name: 'browser',
          path: '/browser',
          isSaveLocation: true,
          builder: (context, _, __) => const BrowserMainScreen(),
        );

  @override
  BrowserRouteData createData() {
    return const BrowserRouteData();
  }
}

class BrowserRouteData implements CompassRouteData {
  const BrowserRouteData();
}
