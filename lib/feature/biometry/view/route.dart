import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/biometry/view/biometry_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

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

/// Data model for EnableBiometry route
@freezed
class EnableBiometryRouteData
    with _$EnableBiometryRouteData
    implements CompassRouteData {
  const factory EnableBiometryRouteData() = _EnableBiometryRouteData;

  const EnableBiometryRouteData._();
}
