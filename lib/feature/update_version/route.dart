import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/update_version/view/update_version_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateVersionRoute
    extends CompassRouteParameterless<UpdateVersionRouteData> {
  UpdateVersionRoute()
      : super(
          name: 'update-version',
          isTopLevel: true,
          pageBuilder: (context, _, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            fullscreenDialog: true,
            opaque: false,
            transitionsBuilder: (_, __, ___, child) => child,
            child: const UpdateVersionScreen(),
          ),
        );

  @override
  UpdateVersionRouteData dataFabric() {
    return const UpdateVersionRouteData();
  }
}

class UpdateVersionRouteData implements CompassRouteData {
  const UpdateVersionRouteData();
}
