import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class SplashScreenRoute
    extends CompassRouteParameterless<SplashScreenRouteData> {
  SplashScreenRoute()
    : super(
        name: 'splash',
        path: '/splash',
        isInitial: true, // Mark as initial route
        isTopLevel: true, // Mark as top-level route
        builder: (context, _, __) => const SplashScreen(),
      );

  @override
  SplashScreenRouteData createData() {
    return const SplashScreenRouteData();
  }
}

class SplashScreenRouteData implements CompassRouteData {
  const SplashScreenRouteData();
}
