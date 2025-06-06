import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/manage_seeds_accounts/route.dart';
import 'package:app/feature/profile/view/profile_page_widget.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class ProfileRoute extends CompassRouteParameterless<ProfileRouteData> {
  ProfileRoute(
    @Named.from(ManageSeedsAccountsRoute)
    CompassBaseRoute manageSeedsAccountsRoute,
  ) : super(
          name: 'profile',
          path: '/profile',
          isSaveLocation: true,
          isSaveSubroutes: true,
          isBottomNavigationBarVisible: true,
          builder: (context, _, __) => const ProfilePageWidget(),
          compassBaseRoutes: [
            manageSeedsAccountsRoute,
          ],
        );

  @override
  ProfileRouteData createData() {
    return const ProfileRouteData();
  }
}

class ProfileRouteData implements CompassRouteData {
  const ProfileRouteData();
}
