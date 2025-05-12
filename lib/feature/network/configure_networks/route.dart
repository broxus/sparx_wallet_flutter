import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/network/configure_networks/configure_networks_page.dart';
import 'package:app/feature/network/edit_network/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@singleton
class ConfigureNetworksRoute
    extends CompassRouteParameterless<ConfigureNetworksRouteData> {
  ConfigureNetworksRoute({
    required this.editNetworkRoute,
  }) : super(
          name: 'configure-networks',
          builder: (context, _, __) => const ConfigureNetworksPage(),
          compassBaseRoutes: [editNetworkRoute],
        );

  final EditNetworkRoute editNetworkRoute;

  @override
  ConfigureNetworksRouteData dataFabric() {
    return const ConfigureNetworksRouteData();
  }
}

/// Data model for ConfigureNetworks route
@freezed
class ConfigureNetworksRouteData
    with _$ConfigureNetworksRouteData
    implements CompassRouteData {
  const factory ConfigureNetworksRouteData() = _ConfigureNetworksRouteData;

  const ConfigureNetworksRouteData._();
}
