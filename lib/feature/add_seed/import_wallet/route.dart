import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/route.dart';
import 'package:app/feature/add_seed/import_wallet/import_wallet_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class ImportWalletRoute
    extends CompassRouteParameterless<ImportWalletRouteData> {
  ImportWalletRoute(
    // @Named.from(EnterSeedPhraseRoute) CompassBaseRoute enterSeedPhraseRoute,
    @Named.from(CreateSeedOnboardingPasswordRoute)
    CompassBaseRoute createSeedPasswordRoute,
  ) : super(
          name: 'import-wallet',
          builder: (context, _, __) => const ImportWalletScreen(),
          compassBaseRoutes: [
            // enterSeedPhraseRoute,
            createSeedPasswordRoute,
          ],
        );

  @override
  ImportWalletRouteData dataFabric() {
    return const ImportWalletRouteData();
  }
}

class ImportWalletRouteData implements CompassRouteData {
  const ImportWalletRouteData();
}
