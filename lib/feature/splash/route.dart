import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
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
  SplashScreenRouteData dataFabric() {
    return const SplashScreenRouteData();
  }
}

/// Data model for SplashScreen route
@freezed
class SplashScreenRouteData
    with _$SplashScreenRouteData
    implements CompassRouteData {
  const factory SplashScreenRouteData() = _SplashScreenRouteData;

  const SplashScreenRouteData._();
}
