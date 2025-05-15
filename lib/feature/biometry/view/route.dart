import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/biometry/view/biometry_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class EnableBiometryRoute
    extends CompassRouteParameterless<EnableBiometryRouteData> {
  EnableBiometryRoute()
      : super(
          path: '/enable-biometry',
          builder: (context, _, __) => const BiometryScreen(),
        );

  @override
  EnableBiometryRouteData dataFabric() {
    return const EnableBiometryRouteData();
  }
}

class EnableBiometryRouteData implements CompassRouteData {
  const EnableBiometryRouteData();
}
