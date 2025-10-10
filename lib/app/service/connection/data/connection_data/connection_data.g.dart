// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionDataGql _$ConnectionDataGqlFromJson(Map<String, dynamic> json) =>
    ConnectionDataGql(
      id: json['id'] as String,
      name: json['name'] as String,
      group: json['group'] as String,
      endpoints: (json['endpoints'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      networkType: NetworkType.fromJson(json['networkType'] as String),
      isLocal: json['isLocal'] as bool,
      blockExplorerUrl: json['blockExplorerUrl'] as String,
      nativeTokenTicker: json['nativeTokenTicker'] as String,
      isPreset: json['isPreset'] as bool,
      canBeEdited: json['canBeEdited'] as bool,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      isUsedOnStart: json['isUsedOnStart'] as bool? ?? true,
      manifestUrl: json['manifestUrl'] as String? ?? '',
      nativeTokenDecimals: (json['nativeTokenDecimals'] as num?)?.toInt() ?? 9,
      latencyDetectionInterval: (json['latencyDetectionInterval'] as num?)
          ?.toInt(),
      maxLatency: (json['maxLatency'] as num?)?.toInt(),
      endpointSelectionRetryCount: (json['endpointSelectionRetryCount'] as num?)
          ?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ConnectionDataGqlToJson(ConnectionDataGql instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'group': instance.group,
      'endpoints': instance.endpoints,
      'networkType': instance.networkType.toJson(),
      'isLocal': instance.isLocal,
      'blockExplorerUrl': instance.blockExplorerUrl,
      'nativeTokenTicker': instance.nativeTokenTicker,
      'isPreset': instance.isPreset,
      'canBeEdited': instance.canBeEdited,
      'sortingOrder': instance.sortingOrder,
      'isUsedOnStart': instance.isUsedOnStart,
      'manifestUrl': instance.manifestUrl,
      'nativeTokenDecimals': instance.nativeTokenDecimals,
      'latencyDetectionInterval': instance.latencyDetectionInterval,
      'maxLatency': instance.maxLatency,
      'endpointSelectionRetryCount': instance.endpointSelectionRetryCount,
      'runtimeType': instance.$type,
    };

ConnectionDataProto _$ConnectionDataProtoFromJson(Map<String, dynamic> json) =>
    ConnectionDataProto(
      id: json['id'] as String,
      name: json['name'] as String,
      group: json['group'] as String,
      endpoint: json['endpoint'] as String,
      networkType: NetworkType.fromJson(json['networkType'] as String),
      blockExplorerUrl: json['blockExplorerUrl'] as String,
      nativeTokenTicker: json['nativeTokenTicker'] as String,
      isPreset: json['isPreset'] as bool,
      canBeEdited: json['canBeEdited'] as bool,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      isUsedOnStart: json['isUsedOnStart'] as bool? ?? true,
      manifestUrl: json['manifestUrl'] as String? ?? '',
      nativeTokenDecimals: (json['nativeTokenDecimals'] as num?)?.toInt() ?? 9,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ConnectionDataProtoToJson(
  ConnectionDataProto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'group': instance.group,
  'endpoint': instance.endpoint,
  'networkType': instance.networkType.toJson(),
  'blockExplorerUrl': instance.blockExplorerUrl,
  'nativeTokenTicker': instance.nativeTokenTicker,
  'isPreset': instance.isPreset,
  'canBeEdited': instance.canBeEdited,
  'sortingOrder': instance.sortingOrder,
  'isUsedOnStart': instance.isUsedOnStart,
  'manifestUrl': instance.manifestUrl,
  'nativeTokenDecimals': instance.nativeTokenDecimals,
  'runtimeType': instance.$type,
};

ConnectionDataJrpc _$ConnectionDataJrpcFromJson(Map<String, dynamic> json) =>
    ConnectionDataJrpc(
      id: json['id'] as String,
      name: json['name'] as String,
      group: json['group'] as String,
      endpoint: json['endpoint'] as String,
      networkType: NetworkType.fromJson(json['networkType'] as String),
      blockExplorerUrl: json['blockExplorerUrl'] as String,
      nativeTokenTicker: json['nativeTokenTicker'] as String,
      isPreset: json['isPreset'] as bool,
      canBeEdited: json['canBeEdited'] as bool,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      isUsedOnStart: json['isUsedOnStart'] as bool? ?? true,
      manifestUrl: json['manifestUrl'] as String? ?? '',
      nativeTokenDecimals: (json['nativeTokenDecimals'] as num?)?.toInt() ?? 9,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ConnectionDataJrpcToJson(ConnectionDataJrpc instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'group': instance.group,
      'endpoint': instance.endpoint,
      'networkType': instance.networkType.toJson(),
      'blockExplorerUrl': instance.blockExplorerUrl,
      'nativeTokenTicker': instance.nativeTokenTicker,
      'isPreset': instance.isPreset,
      'canBeEdited': instance.canBeEdited,
      'sortingOrder': instance.sortingOrder,
      'isUsedOnStart': instance.isUsedOnStart,
      'manifestUrl': instance.manifestUrl,
      'nativeTokenDecimals': instance.nativeTokenDecimals,
      'runtimeType': instance.$type,
    };
