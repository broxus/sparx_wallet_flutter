import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/no_internet/no_internet_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@singleton
class NoInternetRoute
    extends CompassRouteParameterless<NoInternetRouteData> {
  NoInternetRoute()
      : super(
          name: 'no-internet',
          isTopLevel: true, // Mark as top-level route
          builder: (context, _, __) => const NoInternetScreen(),
        );

  @override
  NoInternetRouteData dataFabric() {
    return const NoInternetRouteData();
  }
}

/// Data model for NoInternet route
@freezed
class NoInternetRouteData
    with _$NoInternetRouteData
    implements CompassRouteData {
  const factory NoInternetRouteData() = _NoInternetRouteData;

  const NoInternetRouteData._();
}
