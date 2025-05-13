import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/add_account_page.dart';
import 'package:app/feature/wallet/new_account/add_external_account/route.dart';
import 'package:app/feature/wallet/new_account/screen/route.dart';
import 'package:app/feature/wallet/new_account/select_seed/route.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class AddAccountRoute extends CompassRouteParameterless<AddAccountRouteData> {
  AddAccountRoute(
    @Named.from(SelectSeedRoute) CompassBaseRoute selectSeedRoute,
    @Named.from(NewAccountRoute) CompassBaseRoute newAccountRoute,
    @Named.from(NewExternalAccountRoute)
    CompassBaseRoute newExternalAccountRoute,
  ) : super(
          name: 'wallet-add-account',
          builder: (context, _, __) => const AddAccountPage(),
          compassBaseRoutes: [
            selectSeedRoute,
            newAccountRoute,
            newExternalAccountRoute,
          ],
        );

  @override
  AddAccountRouteData dataFabric() {
    return const AddAccountRouteData();
  }
}

class AddAccountRouteData implements CompassRouteData {
  const AddAccountRouteData();
}
