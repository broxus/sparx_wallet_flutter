import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/manage_seeds_accounts/route.dart';
import 'package:app/feature/profile/view/profile_page_widget.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProfileRoute extends CompassRouteParameterless<ProfileRouteData> {
  ProfileRoute({
    required this.manageSeedsAccountsRoute,
  }) : super(
          name: 'profile',
          builder: (context, _, __) => const ProfilePageWidget(),
          compassBaseRoutes: [
            manageSeedsAccountsRoute,
          ],
        );

  final ManageSeedsAccountsRoute manageSeedsAccountsRoute;

  @override
  ProfileRouteData dataFabric() {
    return const ProfileRouteData();
  }
}

class ProfileRouteData implements CompassRouteData {
  const ProfileRouteData();
}
