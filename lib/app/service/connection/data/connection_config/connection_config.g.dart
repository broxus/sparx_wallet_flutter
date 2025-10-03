// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ConnectionConfigToJson(_ConnectionConfig instance) =>
    <String, dynamic>{
      'defaultConnectionId': instance.defaultConnectionId,
      'connections': instance.connections?.map((e) => e.toJson()).toList(),
      'customNetworkOptions':
          instance.customNetworkOptions?.map((e) => e.toJson()).toList(),
    };
