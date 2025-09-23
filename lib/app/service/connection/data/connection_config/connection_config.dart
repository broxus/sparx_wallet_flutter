import 'package:app/app/service/connection/connection.dart';
import 'package:collection/collection.dart';

class ConnectionConfig {
  ConnectionConfig({
    required String defaultConnectionId,
    List<ConnectionNetwork>? networks,
    this.customNetworkOptions,
  })  : networks = networks ?? [],
        defaultConnection = networks
                ?.firstWhereOrNull(
                  (n) => n.connection.id == defaultConnectionId,
                )
                ?.connection ??
            networks?.firstOrNull?.connection ??
            defaultPresetNetwork;

  final List<ConnectionNetwork> networks;
  final List<CustomNetworkOption>? customNetworkOptions;

  late final ConnectionData defaultConnection;

  late final String defaultConnectionId = defaultConnection.id;

  late final connections = [
    for (final network in networks) network.connection,
  ];

  late final transports = Map.fromEntries([
    for (final network in networks)
      MapEntry(
        network.connection.group,
        network.transport,
      ),
  ]);

  late final List<NetworkType>? customNetworkOptionTypes =
      customNetworkOptions == null
          ? [NetworkType.ever, NetworkType.tycho, NetworkType.custom]
          : [
              for (final option in customNetworkOptions!) option.networkType,
            ];
}
