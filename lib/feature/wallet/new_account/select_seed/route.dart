import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/screen/route.dart';
import 'package:app/feature/wallet/new_account/select_seed/select_seed_page.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class SelectSeedRoute extends CompassRouteParameterless<SelectSeedRouteData> {
  SelectSeedRoute(
    @Named.from(NewAccountRoute) CompassBaseRoute newAccountRoute,
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

class SelectSeedRouteData implements CompassRouteData {
  const SelectSeedRouteData();
}
