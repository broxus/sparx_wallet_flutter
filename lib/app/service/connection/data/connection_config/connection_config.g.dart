// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ConnectionConfigToJson(_ConnectionConfig instance) =>
    <String, dynamic>{
      'defaultConnectionId': instance.defaultConnectionId,
      'defaultSettings': instance.defaultSettings.toJson(),
      'connections': instance.connections.map((e) => e.toJson()).toList(),
      'startConnections':
          instance.startConnections.map((e) => e.toJson()).toList(),
      'customNetworkOptions':
          instance.customNetworkOptions.map((e) => e.toJson()).toList(),
    };
