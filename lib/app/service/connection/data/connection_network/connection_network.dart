import 'package:app/app/service/connection/data/work_chain/connection_work_chain_data.dart';
import 'package:app/utils/json/json.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_network.freezed.dart';

part 'connection_network.g.dart';

@freezed
abstract class ConnectionNetwork with _$ConnectionNetwork {
  factory ConnectionNetwork({
    required String id,
    required String networkName,
    required int defaultWorkchainId,
    required List<ConnectionWorkchainData> workchains,
    required double sortingOrder,
  }) = _ConnectionNetwork;

  factory ConnectionNetwork.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final networkName = json['networkName'] as String;

    final workchainsJson = castJsonList<Map<String, dynamic>>(
      json['workchains'],
    );

    final workchains = [
      for (final w in workchainsJson)
        ConnectionWorkchainData.fromJsonCustom(
          json: w,
          parentId: id,
          networkName: networkName,
        ),
    ];

    return ConnectionNetwork(
      id: id,
      networkName: networkName,
      defaultWorkchainId: (json['defaultWorkchainId'] as num).toInt(),
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      workchains: workchains,
    );
  }

  ConnectionNetwork._();

// @override
// @JsonKey(
//   includeFromJson: false,
//   includeToJson: false,
// )
// late final Map<int, ConnectionData> _connectionCache =
//     <int, ConnectionData>{};

// ConnectionData? getConnectionDataByWorkchain(int id) {
//   final connection = _connectionCache[id];
//
//   if (connection != null) {
//     return connection;
//   }
//
//   final workchain = workchains.firstWhereOrNull((w) => w.id == id);
//
//   if (workchain == null) {
//     return null;
//   }
//
//   return _connectionCache[id] = ConnectionData.proto(
//     name: networkName,
//     group: workchain.networkGroup,
//     endpoint: workchain.endpoints.first,
//     networkType: workchain.networkType,
//     blockExplorerUrl: workchain.blockExplorerUrl,
//     nativeTokenTicker: workchain.nativeTokenTicker,
//     isPreset: workchain.isPreset,
//     canBeEdited: workchain.canBeEdited,
//     isUsedOnStart: workchain.isUsedOnStart,
//     manifestUrl: workchain.manifestUrl,
//     nativeTokenDecimals: workchain.nativeTokenDecimals,
//   );
// }
}
