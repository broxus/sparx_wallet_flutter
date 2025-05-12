import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/manage_seeds_accounts/view/manage_seeds_accounts_page.dart';
import 'package:app/feature/profile/seed_detail/route.dart';
import 'package:app/v1/feature/add_seed/enter_seed_name/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@singleton
class ManageSeedsAccountsRoute
    extends CompassRouteParameterless<ManageSeedsAccountsRouteData> {
  ManageSeedsAccountsRoute({
    required this.seedDetailRoute,
    required this.enterSeedNameRoute,
  }) : super(
          name: 'manage-seeds-accounts',
          builder: (context, _, __) => const ManageSeedsAccountsPage(),
          compassBaseRoutes: [
            seedDetailRoute,
            enterSeedNameRoute,
          ],
        );

  final SeedDetailRoute seedDetailRoute;
  final EnterSeedNameRoute enterSeedNameRoute;

  @override
  ManageSeedsAccountsRouteData dataFabric() {
    return const ManageSeedsAccountsRouteData();
  }
}

/// Data model for ManageSeedsAccounts route
@freezed
class ManageSeedsAccountsRouteData
    with _$ManageSeedsAccountsRouteData
    implements CompassRouteData {
  const factory ManageSeedsAccountsRouteData() = _ManageSeedsAccountsRouteData;

  const ManageSeedsAccountsRouteData._();
}
