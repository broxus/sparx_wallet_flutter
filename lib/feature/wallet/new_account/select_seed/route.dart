import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/screen/route.dart';
import 'package:app/feature/wallet/new_account/select_seed/select_seed_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@singleton
class SelectSeedRoute extends CompassRouteParameterless<SelectSeedRouteData> {
  SelectSeedRoute(
    NewAccountRoute newAccountRoute,
  ) : super(
          name: 'wallet-select-seed',
          builder: (context, _, __) => const SelectSeedPage(),
          compassBaseRoutes: [
            newAccountRoute,
          ],
        );

  @override
  SelectSeedRouteData dataFabric() {
    return const SelectSeedRouteData();
  }
}

/// Data model for SelectSeed route
@freezed
class SelectSeedRouteData
    with _$SelectSeedRouteData
    implements CompassRouteDataQuery {
  const factory SelectSeedRouteData() = _SelectSeedRouteData;

  const SelectSeedRouteData._();

  @override
  Map<String, String> toQueryParams() {
    // This route doesn't require any parameters
    return {};
  }
}
