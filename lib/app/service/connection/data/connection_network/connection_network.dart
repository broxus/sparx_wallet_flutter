import 'package:app/app/service/connection/connection.dart';
import 'package:collection/collection.dart';

class ConnectionNetwork {
  ConnectionNetwork({
    required String defaultConnectionId,
    List<ConnectionData>? networks,
    Map<NetworkGroup, ConnectionTransportData>? transports,
    this.customNetworkOptions,
  })  : networks = networks ?? [],
        transports = transports ?? {},
        defaultNetwork = networks?.firstWhereOrNull(
              (n) => n.id == defaultConnectionId,
            ) ??
            networks?.firstOrNull ??
            defaultPresetNetwork;

  final List<ConnectionData> networks;
  final Map<NetworkGroup, ConnectionTransportData> transports;
  final List<CustomNetworkOption>? customNetworkOptions;

  late final ConnectionData defaultNetwork;

  late final String defaultConnectionId = defaultNetwork.id;

  late final List<NetworkType>? customNetworkOptionTypes =
      customNetworkOptions == null
          ? [NetworkType.ever, NetworkType.tycho, NetworkType.custom]
          : [
              for (final option in customNetworkOptions!) option.networkType,
            ];
}
