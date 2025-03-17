import 'package:app/app/router/router.dart';
import 'package:app/feature/browserV2/screens/main/browser_main_screen.dart';
import 'package:go_router/go_router.dart';

const browserUrlQueryParam = 'url';
const browserTabIdQueryParam = 'tabId';

/// Get branch for browser root.
StatefulShellBranch get browserBranch {
  return StatefulShellBranch(
    routes: [
      tabViewRoute,
    ],
  );
}

/// Get branch for browser primary page.
// StatefulShellBranch get primaryBranch {
//   return StatefulShellBranch(
//     routes: [
//       GoRoute(
//         name: AppRoute.browser.name,
//         path: AppRoute.browser.path,
//         builder: (context, state) => PrimaryPage(
//           url: state.uri.queryParameters[browserUrlQueryParam],
//           tabId: state.uri.queryParameters[browserTabIdQueryParam],
//         ),
//         routes: [
//           historyRoute,
//           bookmarksRoute,
//         ],
//       ),
//     ],
//   );
// }

GoRoute get tabViewRoute {
  return GoRoute(
    name: AppRoute.browser.name,
    path: AppRoute.browser.path,
    builder: (context, state) => const BrowserMainScreen(),
  );
}
