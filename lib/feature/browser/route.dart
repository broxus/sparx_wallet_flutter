import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/view/browser_page.dart';
import 'package:app/feature/browser/bookmarks/bookmarks_page.dart';
import 'package:app/feature/browser/history/history_page.dart';
import 'package:app/feature/browser/primary/primary_page.dart';
import 'package:app/feature/browser/tabs/tabs_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const browserUrlQueryParam = 'url';
const browserTabIdQueryParam = 'tabId';

@lazySingleton
class BrowserRoute extends CompassShellRoute<BrowserRouteData> {
  BrowserRoute({
    required this.browserPrimaryRoute,
    required this.browserTabsRoute,
  }) : super(
          name: 'browser',
          isTopLevel: true, // Mark as top-level route
        );

  final BrowserPrimaryRoute browserPrimaryRoute;
  final BrowserTabsRoute browserTabsRoute;

  @override
  List<CompassBaseRoute<dynamic, dynamic>> get compassBaseRoutes => [
        browserPrimaryRoute,
        browserTabsRoute,
      ];

  @override
  Widget builder(BuildContext context, GoRouterState state) => BrowserPage(
        child: super.builder(context, state),
      );

  @override
  BrowserRouteData dataFabric() {
    return const BrowserRouteData();
  }
}

/// Data model for Browser route
@freezed
class BrowserRouteData
    with _$BrowserRouteData
    implements CompassRouteData {
  const factory BrowserRouteData() = _BrowserRouteData;

  const BrowserRouteData._();
}

@lazySingleton
class BrowserPrimaryRoute extends CompassRoute<BrowserPrimaryRouteData, void> {
  BrowserPrimaryRoute({
    required this.browserHistoryRoute,
    required this.browserBookmarksRoute,
  }) : super(
          name: 'browser-primary',
          path: '/browser',
          builder: (context, data, _) => PrimaryPage(
            url: data.url,
            tabId: data.tabId,
          ),
          compassBaseRoutes: [
            browserHistoryRoute,
            browserBookmarksRoute,
          ],
        );

  final BrowserHistoryRoute browserHistoryRoute;
  final BrowserBookmarksRoute browserBookmarksRoute;

  @override
  BrowserPrimaryRouteData fromQueryParams(Map<String, String> queryParams) {
    return BrowserPrimaryRouteData(
      url: queryParams[browserUrlQueryParam],
      tabId: queryParams[browserTabIdQueryParam],
    );
  }
}

/// Data model for BrowserPrimary route
@freezed
class BrowserPrimaryRouteData
    with _$BrowserPrimaryRouteData
    implements CompassRouteDataQuery {
  const factory BrowserPrimaryRouteData({
    /// URL to navigate to
    String? url,

    /// ID of tab to open
    String? tabId,
  }) = _BrowserPrimaryRouteData;

  const BrowserPrimaryRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      if (url != null) browserUrlQueryParam: url!,
      if (tabId != null) browserTabIdQueryParam: tabId!,
    };
  }
}

@lazySingleton
class BrowserHistoryRoute
    extends CompassRouteParameterless<BrowserHistoryRouteData> {
  BrowserHistoryRoute()
      : super(
          name: 'browser-history',
          path: 'history',
          builder: (context, _, __) => const HistoryPage(),
        );

  @override
  BrowserHistoryRouteData dataFabric() {
    return const BrowserHistoryRouteData();
  }
}

/// Data model for BrowserHistory route
@freezed
class BrowserHistoryRouteData
    with _$BrowserHistoryRouteData
    implements CompassRouteData {
  const factory BrowserHistoryRouteData() = _BrowserHistoryRouteData;

  const BrowserHistoryRouteData._();
}

@lazySingleton
class BrowserBookmarksRoute
    extends CompassRouteParameterless<BrowserBookmarksRouteData> {
  BrowserBookmarksRoute()
      : super(
          name: 'browser-bookmarks',
          path: 'bookmarks',
          builder: (context, _, __) => const BookmarksPage(),
        );

  @override
  BrowserBookmarksRouteData dataFabric() {
    return const BrowserBookmarksRouteData();
  }
}

/// Data model for BrowserBookmarks route
@freezed
class BrowserBookmarksRouteData
    with _$BrowserBookmarksRouteData
    implements CompassRouteData {
  const factory BrowserBookmarksRouteData() = _BrowserBookmarksRouteData;

  const BrowserBookmarksRouteData._();
}

@lazySingleton
class BrowserTabsRoute
    extends CompassRouteParameterless<BrowserTabsRouteData> {
  BrowserTabsRoute()
      : super(
          name: 'browser-tabs',
          path: '/browser-tabs',
          builder: (context, _, __) => const TabsPage(),
        );

  @override
  BrowserTabsRouteData dataFabric() {
    return const BrowserTabsRouteData();
  }
}

/// Data model for BrowserTabs route
@freezed
class BrowserTabsRouteData
    with _$BrowserTabsRouteData
    implements CompassRouteData {
  const factory BrowserTabsRouteData() = _BrowserTabsRouteData;

  const BrowserTabsRouteData._();
}
