import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain_data.dart';
import 'package:app/app/service/connection/mapping/transports_mapper.dart';
import 'package:app/utils/json/json_utils.dart';
import 'package:app/utils/parse_utils.dart';

List<ConnectionNetwork> mapToNetworkList(
  List<Map<String, dynamic>> list,
) {
  final result = <ConnectionNetwork>[];

  for (final network in list) {
    final networkName = castToString(network['networkName']);
    final selectedWorkChainId = castToString(network['selectedWorkChainId']);
    final sortingOrder = parseToDouble(network['sortingOrder']) ?? 1;

    if (networkName == null || selectedWorkChainId == null) {
      return [];
    }

    result.add(
      ConnectionNetwork(
        networkName: networkName,
        defaultWorkchainId: defaultWorkchainId,
        workChains: mapToWorkChainsList(
          castJsonList<Map<String, dynamic>>(
            network['workChains'],
          ),
        ),
        sortingOrder: sortingOrder,
      ),
    );
  }

  return result;
}

List<ConnectionWorkChainData> mapToWorkChainsList(
  List<Map<String, dynamic>> workChains,
) {
  final result = <ConnectionWorkChainData>[];

  for (final workChain in workChains) {
    final connection = workChain['connection'] as Map<String, dynamic>;
    final transport = mapToTransport(
      workChain['transport'] as Map<String, dynamic>,
    );

    final type = connection['type'] as String;

    final id = castToString(connection['id']);
    final group = castToString(connection['group']);
    final isUsedOnStart = castTo<bool>(connection['isUsedOnStart']) ?? true;
    final endpoints = castJsonList<String>(connection['endpoints']);
    final networkType = castToString(connection['networkType']);
    final blockExplorerUrl = castToString(connection['blockExplorerUrl']);
    final manifestUrl = castTo<String?>(connection['manifestUrl']);

    if (id == null ||
        group == null ||
        networkType == null ||
        blockExplorerUrl == null ||
        transport == null) {
      continue;
    }

    ConnectionData? data;

    switch (type) {
      case 'proto':
        data = ConnectionData.protoPreset(
          id: id,
          group: group,
          endpoint: endpoints.first,
          networkType: NetworkType.fromJson(networkType),
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          isUsedOnStart: isUsedOnStart,
        );
      case 'gql':
        data = ConnectionData.gqlPreset(
          id: id,
          group: group,
          endpoints: endpoints,
          networkType: NetworkType.fromJson(networkType),
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          isUsedOnStart: isUsedOnStart,
          latencyDetectionInterval:
              parseToInt(connection['latencyDetectionInterval']),
          maxLatency: parseToInt(connection['maxLatency']),
          endpointSelectionRetryCount:
              parseToInt(connection['endpointSelectionRetryCount']),
        );
      case 'jrpc':
        data = ConnectionData.jrpcPreset(
          id: id,
          group: group,
          endpoint: endpoints.first,
          networkType: NetworkType.fromJson(networkType),
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          isUsedOnStart: isUsedOnStart,
        );
      default:
        continue;
    }

    result.add(
      ConnectionWorkChainData(
        connection: data,
        transport: transport,
      ),
    );
  }

  return result;
}
