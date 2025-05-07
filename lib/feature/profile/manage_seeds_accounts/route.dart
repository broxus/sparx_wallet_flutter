import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/add_existing_wallet/route.dart';
import 'package:app/feature/profile/manage_seeds_accounts/view/manage_seeds_accounts_page.dart';
import 'package:app/feature/profile/seed_detail/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
class ManageSeedsAccountsRoute
    extends CompassRouteParameterless<ManageSeedsAccountsRouteData> {
  ManageSeedsAccountsRoute({
    required this.seedDetailRoute,
    required this.addExistingWalletRoute,
  }) : super(
          name: 'manage-seeds-accounts',
          builder: (context, _, __) => const ManageSeedsAccountsPage(),
          compassBaseRoutes: [
            seedDetailRoute,
            addExistingWalletRoute,
          ],
        );

  final SeedDetailRoute seedDetailRoute;
  final AddExistingWalletRoute addExistingWalletRoute;

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
