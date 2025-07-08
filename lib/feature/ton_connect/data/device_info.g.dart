// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceInfoImpl _$$DeviceInfoImplFromJson(Map<String, dynamic> json) =>
    _$DeviceInfoImpl(
      platform: json['platform'] as String,
      appName: json['appName'] as String,
      appVersion: json['appVersion'] as String,
      maxProtocolVersion: (json['maxProtocolVersion'] as num).toInt(),
      features: (json['features'] as List<dynamic>)
          .map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DeviceInfoImplToJson(_$DeviceInfoImpl instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'appName': instance.appName,
      'appVersion': instance.appVersion,
      'maxProtocolVersion': instance.maxProtocolVersion,
      'features': instance.features.map((e) => e.toJson()).toList(),
    };
