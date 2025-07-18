// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_data_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignDataPayload _$SignDataPayloadFromJson(Map<String, dynamic> json) =>
    _SignDataPayload(
      schema: (json['schema_crc'] as num).toInt(),
      cell: json['cell'] as String,
      publicKey: json['publicKey'] == null
          ? null
          : PublicKey.fromJson(json['publicKey'] as String),
    );

Map<String, dynamic> _$SignDataPayloadToJson(_SignDataPayload instance) =>
    <String, dynamic>{
      'schema_crc': instance.schema,
      'cell': instance.cell,
      'publicKey': instance.publicKey?.toJson(),
    };
