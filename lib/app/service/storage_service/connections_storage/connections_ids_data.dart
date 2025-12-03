import 'package:freezed_annotation/freezed_annotation.dart';

part 'connections_ids_data.freezed.dart';

part 'connections_ids_data.g.dart';

@freezed
abstract class ConnectionIdsData with _$ConnectionIdsData {
  factory ConnectionIdsData({
    required String connectionId,
    required int workchainId,
    required int networkId,
  }) = _ConnectionIdsData;

  factory ConnectionIdsData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionIdsDataFromJson(json);
}

extension ConnectionIdsDataExt on ConnectionIdsData {
  String get fullId => '$connectionId$workchainId';
}
