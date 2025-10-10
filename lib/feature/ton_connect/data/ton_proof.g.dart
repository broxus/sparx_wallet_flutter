// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_proof.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TonProof _$TonProofFromJson(Map<String, dynamic> json) => _TonProof(
  timestamp: json['timestamp'] as String,
  signature: json['signature'] as String,
  payload: json['payload'] as String,
  domain: TonProofDomain.fromJson(json['domain'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TonProofToJson(_TonProof instance) => <String, dynamic>{
  'timestamp': instance.timestamp,
  'signature': instance.signature,
  'payload': instance.payload,
  'domain': instance.domain.toJson(),
};
