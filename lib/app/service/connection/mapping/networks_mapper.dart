import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/utils/json/json_utils.dart';
import 'package:app/utils/parse_utils.dart';

List<ConnectionData> mapToConnectionDataList(
  List<Map<String, dynamic>> list,
) {
  final result = <ConnectionData>[];

  for (final network in list) {
    final type = network['type'] as String;

    ConnectionData? data;

    final id = castToString(network['id']);
    final name = castToString(network['name']);
    final group = castToString(network['group']);
    final isUsedOnStart = castTo<bool>(network['isUsedOnStart']) ?? true;
    final endpoints = castJsonList<String>(network['endpoints']);
    final networkType = castToString(network['networkType']);
    final blockExplorerUrl = castToString(network['blockExplorerUrl']);
    final manifestUrl = castTo<String?>(network['manifestUrl']);
    final sortingOrder = parseToDouble(network['sortingOrder']) ?? 1;

    if (id == null ||
        name == null ||
        group == null ||
        networkType == null ||
        blockExplorerUrl == null) {
      continue;
    }

    switch (type) {
      case 'proto':
        data = ConnectionData.protoPreset(
          id: id,
          name: name,
          group: group,
          endpoint: endpoints.first,
          networkType: networkType,
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
          networkType: networkType,
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
          networkType: networkType,
          blockExplorerUrl: blockExplorerUrl,
          manifestUrl: manifestUrl,
          canBeEdited: false,
          sortingOrder: sortingOrder,
          isUsedOnStart: isUsedOnStart,
        );
      default:
        continue;
    }

    result.add(data);
  }

  return result;
}
