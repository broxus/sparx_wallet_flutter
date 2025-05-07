import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/manage_seeds_accounts/route.dart';
import 'package:app/feature/profile/view/profile_page_widget.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
class ProfileRoute extends CompassRouteParameterless<ProfileRouteData> {
  ProfileRoute({
    required this.manageSeedsAccountsRoute,
  }) : super(
          name: 'profile',
          path: '/profile',
          isTopLevel: true, // Mark as top-level route
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

/// Data model for Profile route
@freezed
class ProfileRouteData
    with _$ProfileRouteData
    implements CompassRouteData {
  const factory ProfileRouteData() = _ProfileRouteData;

  const ProfileRouteData._();
}
