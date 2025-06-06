import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/network/configure_networks/configure_networks_page.dart';
import 'package:app/feature/network/edit_network/route.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class ConfigureNetworksRoute
    extends CompassRouteParameterless<ConfigureNetworksRouteData> {
  ConfigureNetworksRoute(
    @Named.from(EditNetworkRoute) CompassBaseRoute editNetworkRoute,
  ) : super(
          path: '/configure-networks',
          isSaveLocation: true,
          builder: (context, _, __) => const ConfigureNetworksPage(),
          compassBaseRoutes: [editNetworkRoute],
        );

  @override
  ConfigureNetworksRouteData createData() {
    return const ConfigureNetworksRouteData();
  }
}

class ConfigureNetworksRouteData implements CompassRouteData {
  const ConfigureNetworksRouteData();
}
