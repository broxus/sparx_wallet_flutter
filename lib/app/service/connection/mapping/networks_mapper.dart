import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/mapping/transports_mapper.dart';
import 'package:app/utils/json/json_utils.dart';
import 'package:app/utils/parse_utils.dart';

List<ConnectionNetwork> mapToConnectionDataList(
  List<Map<String, dynamic>> list,
) {
  final result = <ConnectionNetwork>[];

  for (final network in list) {
    print('!!! $network');
    final connection = network['connection'] as Map<String, dynamic>;
    final transport = mapToTransport(
      network['transport'] as Map<String, dynamic>,
    );

    final type = connection['type'] as String;

    ConnectionData? data;

    final id = castToString(connection['id']);
    final name = castToString(connection['name']);
    final group = castToString(connection['group']);
    final isUsedOnStart = castTo<bool>(connection['isUsedOnStart']) ?? true;
    final endpoints = castJsonList<String>(connection['endpoints']);
    final networkType = castToString(connection['networkType']);
    final blockExplorerUrl = castToString(connection['blockExplorerUrl']);
    final manifestUrl = castTo<String?>(connection['manifestUrl']);
    final sortingOrder = parseToDouble(connection['sortingOrder']) ?? 1;

    if (id == null ||
        name == null ||
        group == null ||
        networkType == null ||
        blockExplorerUrl == null ||
        transport == null) {
      continue;
    }

    switch (type) {
      case 'proto':
        data = ConnectionData.protoPreset(
          id: id,
          name: name,
          group: group,
          endpoint: endpoints.first,
          networkType: NetworkType.fromJson(networkType),
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          sortingOrder: sortingOrder,
          isUsedOnStart: isUsedOnStart,
        );
      case 'gql':
        data = ConnectionData.gqlPreset(
          id: id,
          name: name,
          group: group,
          endpoints: endpoints,
          networkType: NetworkType.fromJson(networkType),
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          sortingOrder: sortingOrder,
          isUsedOnStart: isUsedOnStart,
          latencyDetectionInterval:
              parseToInt(network['latencyDetectionInterval']),
          maxLatency: parseToInt(network['maxLatency']),
          endpointSelectionRetryCount:
              parseToInt(network['endpointSelectionRetryCount']),
        );
      case 'jrpc':
        data = ConnectionData.jrpcPreset(
          id: id,
          name: name,
          group: group,
          endpoint: endpoints.first,
          networkType: NetworkType.fromJson(networkType),
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          sortingOrder: sortingOrder,
          isUsedOnStart: isUsedOnStart,
        );
      default:
        continue;
    }

    result.add(
      ConnectionNetwork(
        connection: data,
        transport: transport,
      ),
    );
  }

  return result;
}
