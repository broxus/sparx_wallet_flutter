import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/bookmarks/route.dart';
import 'package:app/feature/browser/history/route.dart';
import 'package:app/feature/browser/primary/primary_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const _urlQueryParam = 'url';
const _tabIdQueryParam = 'tabId';

@singleton
class BrowserPrimaryRoute extends CompassRoute<BrowserPrimaryRouteData> {
  BrowserPrimaryRoute({
    required this.browserHistoryRoute,
    required this.browserBookmarksRoute,
  }) : super(
          name: 'browser-primary',
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
      url: queryParams[_urlQueryParam],
      tabId: queryParams[_tabIdQueryParam],
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
    final url = this.url;
    final tabId = this.tabId;

    return {
      if (url != null) _urlQueryParam: url,
      if (tabId != null) _tabIdQueryParam: tabId!,
    };
  }
}
