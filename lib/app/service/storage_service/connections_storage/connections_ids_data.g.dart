// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connections_ids_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectionIdsData _$ConnectionIdsDataFromJson(Map<String, dynamic> json) =>
    _ConnectionIdsData(
      connectionId: json['connectionId'] as String,
      workchainId: (json['workchainId'] as num).toInt(),
      networkId: (json['networkId'] as num).toInt(),
    );

Map<String, dynamic> _$ConnectionIdsDataToJson(_ConnectionIdsData instance) =>
    <String, dynamic>{
      'connectionId': instance.connectionId,
      'workchainId': instance.workchainId,
      'networkId': instance.networkId,
    };
