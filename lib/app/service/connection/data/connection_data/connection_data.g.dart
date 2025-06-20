// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionDataGqlImpl _$$ConnectionDataGqlImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionDataGqlImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      group: json['group'] as String,
      endpoints:
          (json['endpoints'] as List<dynamic>).map((e) => e as String).toList(),
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
      latencyDetectionInterval:
          (json['latencyDetectionInterval'] as num?)?.toInt(),
      maxLatency: (json['maxLatency'] as num?)?.toInt(),
      endpointSelectionRetryCount:
          (json['endpointSelectionRetryCount'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConnectionDataGqlImplToJson(
        _$ConnectionDataGqlImpl instance) =>
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

_$ConnectionDataProtoImpl _$$ConnectionDataProtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionDataProtoImpl(
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

Map<String, dynamic> _$$ConnectionDataProtoImplToJson(
        _$ConnectionDataProtoImpl instance) =>
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

_$ConnectionDataJrpcImpl _$$ConnectionDataJrpcImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionDataJrpcImpl(
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

Map<String, dynamic> _$$ConnectionDataJrpcImplToJson(
        _$ConnectionDataJrpcImpl instance) =>
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
