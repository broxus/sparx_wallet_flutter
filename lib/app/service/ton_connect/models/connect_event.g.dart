// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectEventSuccessImpl _$$ConnectEventSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectEventSuccessImpl(
      id: json['id'] as num,
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
      $type: json['event'] as String?,
    );

Map<String, dynamic> _$$ConnectEventErrorImplToJson(
        _$ConnectEventErrorImpl instance) =>
    <String, dynamic>{
      'event': instance.$type,
    };
