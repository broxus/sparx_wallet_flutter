// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_event_success_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectEventSuccessPayload _$ConnectEventSuccessPayloadFromJson(
        Map<String, dynamic> json) =>
    _ConnectEventSuccessPayload(
      items: (json['items'] as List<dynamic>)
          .map((e) => ConnectItemReply.fromJson(e as Map<String, dynamic>))
          .toList(),
      device: DeviceInfo.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConnectEventSuccessPayloadToJson(
        _ConnectEventSuccessPayload instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'device': instance.device.toJson(),
    };
