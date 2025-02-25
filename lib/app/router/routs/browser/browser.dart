import 'package:app/app/router/router.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browserV2/screens/bookmarks/bookmarks_list_screen.dart';
import 'package:app/feature/browserV2/screens/browser_view/browser_tabs_view_screen.dart';
import 'package:app/feature/browserV2/screens/history/history_screen.dart';
import 'package:go_router/go_router.dart';

const browserUrlQueryParam = 'url';
const browserTabIdQueryParam = 'tabId';

/// Get branch for browser root.
StatefulShellBranch get browserBranch {
  return StatefulShellBranch(
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => BrowserPage(
          child: navigationShell,
        ),
        branches: [
          primaryBranch,
          tabsBranch,
        ],
      ),
    ],
  );
}

/// Get branch for browser primary page.
StatefulShellBranch get primaryBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.browser.name,
        path: AppRoute.browser.path,
        builder: (context, state) => PrimaryPage(
          url: state.uri.queryParameters[browserUrlQueryParam],
          tabId: state.uri.queryParameters[browserTabIdQueryParam],
        ),
        // builder: (context, state) => const BrowserTabViewScreen(),
        routes: [
          historyRoute,
          bookmarksRoute,
        ],
      ),
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

/// Get branch for browser tabs page.
StatefulShellBranch get tabsBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.browserTabs.name,
        path: AppRoute.browserTabs.path,
        builder: (context, state) => const BrowserTabsViewScreen(),
      ),
    ],
  );
}
