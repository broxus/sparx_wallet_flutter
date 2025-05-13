import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/tabs/tabs_page.dart';
import 'package:injectable/injectable.dart';

@singleton
class BrowserTabsRoute extends CompassRouteParameterless<BrowserTabsRouteData> {
  BrowserTabsRoute()
      : super(
          name: 'browser-tabs',
          builder: (context, _, __) => const TabsPage(),
        );

  @override
  BrowserTabsRouteData dataFabric() {
    return const BrowserTabsRouteData();
  }
}

class BrowserTabsRouteData implements CompassRouteData {
  const BrowserTabsRouteData();
}
