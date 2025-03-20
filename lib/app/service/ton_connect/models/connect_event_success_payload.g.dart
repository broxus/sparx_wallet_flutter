// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_event_success_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectEventSuccessPayloadImpl _$$ConnectEventSuccessPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectEventSuccessPayloadImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => ConnectItemReply.fromJson(e as Map<String, dynamic>))
          .toList(),
      device: DeviceInfo.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ConnectEventSuccessPayloadImplToJson(
        _$ConnectEventSuccessPayloadImpl instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'device': instance.device.toJson(),
    };
