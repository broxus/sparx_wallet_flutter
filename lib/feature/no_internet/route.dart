import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/no_internet/no_internet_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class NoInternetRoute extends CompassRouteParameterless<NoInternetRouteData> {
  NoInternetRoute()
      : super(
          name: 'no-internet',
          path: '/no-internet',
          isTopLevel: true, // Mark as top-level route
          builder: (context, _, __) => const NoInternetScreen(),
        );

  @override
  NoInternetRouteData dataFabric() {
    return const NoInternetRouteData();
  }
}

/// Data model for NoInternet route
class NoInternetRouteData implements CompassRouteData {
  const NoInternetRouteData();
}
