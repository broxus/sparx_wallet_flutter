import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/manage_seeds_accounts/view/manage_seeds_accounts_page.dart';
import 'package:app/feature/profile/seed_detail/route.dart';
import 'package:app/v1/feature/add_seed/enter_seed_name/route.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class ManageSeedsAccountsRoute
    extends CompassRouteParameterless<ManageSeedsAccountsRouteData> {
  ManageSeedsAccountsRoute(
    @Named.from(SeedDetailRoute) CompassBaseRoute seedDetailRoute,
    // ignore: deprecated_member_use_from_same_package
    @Named.from(EnterSeedNameRoute) CompassBaseRoute enterSeedNameRoute,
  ) : super(
          name: 'manage-seeds-accounts',
          path: '/manage-seeds-accounts',
          isSaveLocation: true,
          bottomBarState: BottomBarState.expanded,
          builder: (context, _, __) => const ManageSeedsAccountsPage(),
          compassBaseRoutes: [
            seedDetailRoute,
            enterSeedNameRoute,
          ],
        );

  @override
  ManageSeedsAccountsRouteData createData() {
    return const ManageSeedsAccountsRouteData();
  }
}

class ManageSeedsAccountsRouteData implements CompassRouteData {
  const ManageSeedsAccountsRouteData();
}
