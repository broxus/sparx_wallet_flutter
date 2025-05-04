import 'package:app/app/router/router.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:go_router/go_router.dart';

/// Get branch for browser root.
StatefulShellBranch get browserBranch {
  return StatefulShellBranch(
    routes: [
      tabViewRoute,
    ],
  );
}

GoRoute get tabViewRoute {
  return GoRoute(
    name: AppRoute.browser.name,
    path: AppRoute.browser.path,
    builder: (context, state) => const BrowserMainScreen(),
  );
}
