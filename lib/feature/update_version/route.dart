import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/update_version/view/update_version_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
class UpdateVersionRoute
    extends CompassRouteParameterless<UpdateVersionRouteData> {
  UpdateVersionRoute()
      : super(
          name: 'update-version',
          path: '/update-version',
          isTopLevel: true, // Mark as top-level route
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

/// Data model for UpdateVersion route
@freezed
class UpdateVersionRouteData
    with _$UpdateVersionRouteData
    implements CompassRouteData {
  const factory UpdateVersionRouteData() = _UpdateVersionRouteData;

  const UpdateVersionRouteData._();
}
