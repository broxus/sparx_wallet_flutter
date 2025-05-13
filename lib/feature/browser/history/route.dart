import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/history/history_page.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class BrowserHistoryRoute
    extends CompassRouteParameterless<BrowserHistoryRouteData> {
  BrowserHistoryRoute()
      : super(
          name: 'browser-history',
          builder: (context, _, __) => const HistoryPage(),
        );

  @override
  BrowserHistoryRouteData dataFabric() {
    return const BrowserHistoryRouteData();
  }
}

class BrowserHistoryRouteData implements CompassRouteData {
  const BrowserHistoryRouteData();
}
