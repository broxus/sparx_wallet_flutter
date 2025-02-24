// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_proof.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TonProofImpl _$$TonProofImplFromJson(Map<String, dynamic> json) =>
    _$TonProofImpl(
      timestamp: json['timestamp'] as String,
      signature: json['signature'] as String,
      payload: json['payload'] as String,
      domain: TonProofDomain.fromJson(json['domain'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TonProofImplToJson(_$TonProofImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'signature': instance.signature,
      'payload': instance.payload,
      'domain': instance.domain.toJson(),
    };
