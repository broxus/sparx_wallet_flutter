import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/manage_seeds_accounts/view/manage_seeds_accounts_page.dart';
import 'package:app/feature/profile/seed_detail/route.dart';
import 'package:app/v1/feature/add_seed/enter_seed_name/route.dart';
import 'package:injectable/injectable.dart';

@singleton
class ManageSeedsAccountsRoute
    extends CompassRouteParameterless<ManageSeedsAccountsRouteData> {
  ManageSeedsAccountsRoute(
    SeedDetailRoute seedDetailRoute,
    // ignore: deprecated_member_use_from_same_package
    EnterSeedNameRoute enterSeedNameRoute,
  ) : super(
          name: 'manage-seeds-accounts',
          builder: (context, _, __) => const ManageSeedsAccountsPage(),
          compassBaseRoutes: [
            seedDetailRoute,
            enterSeedNameRoute,
          ],
        );

  @override
  ManageSeedsAccountsRouteData dataFabric() {
    return const ManageSeedsAccountsRouteData();
  }
}

class ManageSeedsAccountsRouteData implements CompassRouteData {
  const ManageSeedsAccountsRouteData();
}
