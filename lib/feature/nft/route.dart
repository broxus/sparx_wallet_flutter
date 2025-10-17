import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class NftRoute extends CompassRouteParameterless<NftRouteData> {
  NftRoute(
    @Named.from(AddNftRoute) CompassBaseRoute addNftRoute,
    @Named.from(NftCollectionRoute) CompassBaseRoute nftCollectionRoute,
  ) : super(
        name: 'nft',
        path: '/nft',
        isSaveLocation: true,
        isSaveSubroutes: true,
        bottomBarState: BottomBarState.expanded,
        builder: (context, _, __) => const NftPageWidget(),
        compassBaseRoutes: [addNftRoute, nftCollectionRoute],
      );

  @override
  NftRouteData createData() {
    return const NftRouteData();
  }
}

class NftRouteData implements CompassRouteData {
  const NftRouteData();
}

@named
@Singleton(as: CompassBaseRoute)
class AddNftRoute extends CompassRouteParameterless<AddNftRouteRouteData> {
  AddNftRoute()
    : super(
        path: '/add-nft',
        bottomBarState: BottomBarState.hidden,
        builder: (context, _, __) => const AddNftWidget(),
      );

  @override
  AddNftRouteRouteData createData() {
    return const AddNftRouteRouteData();
  }
}

class AddNftRouteRouteData implements CompassRouteData {
  const AddNftRouteRouteData();
}
