// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectEventSuccessImpl _$$ConnectEventSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectEventSuccessImpl(
      id: json['id'] as String,
      payload: ConnectEventSuccessPayload.fromJson(
          json['payload'] as Map<String, dynamic>),
      $type: json['event'] as String?,
    );

Map<String, dynamic> _$$ConnectEventSuccessImplToJson(
        _$ConnectEventSuccessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payload': instance.payload.toJson(),
      'event': instance.$type,
    };

_$ConnectEventErrorImpl _$$ConnectEventErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectEventErrorImpl(
      id: json['id'] as String,
      payload:
          TonConnectError.fromJson(json['payload'] as Map<String, dynamic>),
      $type: json['event'] as String?,
    );

Map<String, dynamic> _$$ConnectEventErrorImplToJson(
        _$ConnectEventErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payload': instance.payload.toJson(),
      'event': instance.$type,
    };

_$DisconnectEventImpl _$$DisconnectEventImplFromJson(
        Map<String, dynamic> json) =>
    _$DisconnectEventImpl(
      id: json['id'] as String,
      payload: json['payload'] as Map<String, dynamic>? ?? const {},
      $type: json['event'] as String?,
    );

Map<String, dynamic> _$$DisconnectEventImplToJson(
        _$DisconnectEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payload': instance.payload,
      'event': instance.$type,
    };
