import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/bookmarks/bookmarks_page.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
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

class BrowserBookmarksRouteData implements CompassRouteData {
  const BrowserBookmarksRouteData();
}
