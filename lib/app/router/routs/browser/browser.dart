import 'package:app/app/router/router.dart';
import 'package:app/feature/browserV2/screens/bookmarks/bookmarks_list_screen.dart';
import 'package:app/feature/browserV2/screens/history/history_screen.dart';
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
    routes: [
      historyRoute,
      bookmarksRoute,
    ],
  );
}

/// Get route for browser primary page.
GoRoute get bookmarksRoute {
  return GoRoute(
    name: AppRoute.browserBookmarks.name,
    path: AppRoute.browserBookmarks.path,
    builder: (context, state) => const BrowserBookmarksListScreen(),
  );
}

/// Get route for browser history page.
GoRoute get historyRoute {
  return GoRoute(
    name: AppRoute.browserHistory.name,
    path: AppRoute.browserHistory.path,
    builder: (_, __) => const HistoryScreen(),
  );
}
