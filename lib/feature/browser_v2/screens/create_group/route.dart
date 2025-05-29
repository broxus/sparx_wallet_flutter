import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen.dart';
import 'package:injectable/injectable.dart';

const _tabIdQueryParam = 'tabId';

@named
@Singleton(as: CompassBaseRoute)
class CreateBrowserGroupRoute
    extends CompassRoute<CreateBrowserGroupRouteData> {
  CreateBrowserGroupRoute()
      : super(
          name: 'createBrowserGroup',
          path: '/createBrowserGroup',
          isBottomNavigationBarVisible: false,
          builder: (context, data, __) => CreateBrowserGroupScreen(),
        );

  @override
  CreateBrowserGroupRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    return CreateBrowserGroupRouteData(
      tabId: queryParams[_tabIdQueryParam],
    );
  }
}

class CreateBrowserGroupRouteData implements CompassRouteDataQuery {
  const CreateBrowserGroupRouteData({
    this.tabId,
  });

  final String? tabId;

  @override
  Map<String, String> toQueryParams() {
    return {
      _tabIdQueryParam: tabId ?? '',
    };
  }
}
