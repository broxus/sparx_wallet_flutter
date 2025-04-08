import 'package:app/app/router/app_route.dart';
import 'package:app/feature/update_version/view/update_version_screen.dart';
import 'package:go_router/go_router.dart';

GoRoute get updateVersionRoute {
  return GoRoute(
    name: AppRoute.updateVersion.name,
    path: AppRoute.updateVersion.path,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      fullscreenDialog: true,
      opaque: false,
      transitionsBuilder: (_, __, ___, child) => child,
      child: const UpdateVersionScreen(),
    ),
  );
}
