import 'package:app/app/service/connection/data/work_chain/connection_work_chain_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_network.freezed.dart';

part 'connection_network.g.dart';

@freezed
abstract class ConnectionNetwork  with _$ConnectionNetwork {
  factory ConnectionNetwork({
    required String id,
    required String networkName,
    required int defaultWorkchainId,
    required List<ConnectionWorkChainData> workChains,
    required double sortingOrder,
  }) = _ConnectionNetwork;


  factory ConnectionNetwork.fromJson(Map<String, dynamic> json) =>
      _$ConnectionNetworkFromJson(json);
}
