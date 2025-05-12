import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/bookmarks/bookmarks_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@singleton
class BrowserBookmarksRoute
    extends CompassRouteParameterless<BrowserBookmarksRouteData> {
  BrowserBookmarksRoute()
      : super(
          name: 'browser-bookmarks',
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
