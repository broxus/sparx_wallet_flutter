// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectEventSuccess _$ConnectEventSuccessFromJson(Map<String, dynamic> json) =>
    ConnectEventSuccess(
      id: json['id'] as String,
      payload: ConnectEventSuccessPayload.fromJson(
        json['payload'] as Map<String, dynamic>,
      ),
      $type: json['event'] as String?,
    );

Map<String, dynamic> _$ConnectEventSuccessToJson(
  ConnectEventSuccess instance,
) => <String, dynamic>{
  'id': instance.id,
  'payload': instance.payload.toJson(),
  'event': instance.$type,
};

ConnectEventError _$ConnectEventErrorFromJson(Map<String, dynamic> json) =>
    ConnectEventError(
      id: json['id'] as String,
      payload: TonConnectError.fromJson(
        json['payload'] as Map<String, dynamic>,
      ),
      $type: json['event'] as String?,
    );

Map<String, dynamic> _$ConnectEventErrorToJson(ConnectEventError instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payload': instance.payload.toJson(),
      'event': instance.$type,
    };

DisconnectEvent _$DisconnectEventFromJson(Map<String, dynamic> json) =>
    DisconnectEvent(
      id: json['id'] as String,
      payload: json['payload'] as Map<String, dynamic>? ?? const {},
      $type: json['event'] as String?,
    );

Map<String, dynamic> _$DisconnectEventToJson(DisconnectEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payload': instance.payload,
      'event': instance.$type,
    };
