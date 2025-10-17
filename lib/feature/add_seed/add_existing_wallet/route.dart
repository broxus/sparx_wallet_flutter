import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/add_existing_wallet/view/add_existing_wallet_page.dart';
import 'package:app/feature/add_seed/import_wallet/route.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class AddExistingWalletRoute
    extends CompassRouteParameterless<AddExistingWalletRouteData> {
  AddExistingWalletRoute(
    @Named.from(ImportWalletRoute) CompassBaseRoute importWalletRoute,
  ) : super(
        path: '/add-existing-wallet',
        isSaveLocation: true,
        builder: (context, _, __) => const AddExistingWalletPage(),
        compassBaseRoutes: [importWalletRoute],
      );

  @override
  AddExistingWalletRouteData createData() {
    return const AddExistingWalletRouteData();
  }
}

class AddExistingWalletRouteData implements CompassRouteData {
  const AddExistingWalletRouteData();
}
