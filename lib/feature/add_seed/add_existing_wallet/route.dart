import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/add_existing_wallet/view/add_existing_wallet_page.dart';
import 'package:app/feature/add_seed/import_wallet/route.dart';
import 'package:injectable/injectable.dart';

@singleton
class AddExistingWalletRoute
    extends CompassRouteParameterless<AddExistingWalletRouteData> {
  AddExistingWalletRoute({
    required this.importWalletRoute,
  }) : super(
          name: 'add-existing-wallet',
          builder: (context, _, __) => const AddExistingWalletPage(),
          compassBaseRoutes: [importWalletRoute],
        );

  final ImportWalletRoute importWalletRoute;

  @override
  AddExistingWalletRouteData dataFabric() {
    return const AddExistingWalletRouteData();
  }
}

class AddExistingWalletRouteData
    implements CompassRouteData {
  const AddExistingWalletRouteData();
}
