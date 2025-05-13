import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/biometry/view/biometry_screen.dart';
import 'package:injectable/injectable.dart';

@singleton
class EnableBiometryRoute
    extends CompassRouteParameterless<EnableBiometryRouteData> {
  EnableBiometryRoute()
      : super(
          name: 'enable-biometry',
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
