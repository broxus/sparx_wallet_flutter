// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => _DeviceInfo(
  platform: json['platform'] as String,
  appName: json['appName'] as String,
  appVersion: json['appVersion'] as String,
  maxProtocolVersion: (json['maxProtocolVersion'] as num).toInt(),
  features: json['features'] as List<dynamic>,
);

Map<String, dynamic> _$DeviceInfoToJson(_DeviceInfo instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'appName': instance.appName,
      'appVersion': instance.appVersion,
      'maxProtocolVersion': instance.maxProtocolVersion,
      'features': instance.features,
    };
