// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_data_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignDataResult _$SignDataResultFromJson(Map<String, dynamic> json) =>
    _SignDataResult(
      signature: json['signature'] as String,
      address: Address.fromJson(json['address'] as String),
      timestamp: (json['timestamp'] as num).toInt(),
      domain: json['domain'] as String,
      payload: SignDataPayload.fromJson(
        json['payload'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SignDataResultToJson(_SignDataResult instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'address': instance.address.toJson(),
      'timestamp': instance.timestamp,
      'domain': instance.domain,
      'payload': instance.payload.toJson(),
    };
