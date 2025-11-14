// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_data_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignDataPayloadCell _$SignDataPayloadCellFromJson(Map<String, dynamic> json) =>
    SignDataPayloadCell(
      schema: json['schema'] as String,
      cell: json['cell'] as String,
      network: $enumDecodeNullable(_$TonNetworkEnumMap, json['network']),
      from: json['from'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SignDataPayloadCellToJson(
  SignDataPayloadCell instance,
) => <String, dynamic>{
  'schema': instance.schema,
  'cell': instance.cell,
  'network': _$TonNetworkEnumMap[instance.network],
  'from': instance.from,
  'type': instance.$type,
};

const _$TonNetworkEnumMap = {
  TonNetwork.mainnet: '-239',
  TonNetwork.testnet: '-3',
};

SignDataPayloadText _$SignDataPayloadTextFromJson(Map<String, dynamic> json) =>
    SignDataPayloadText(
      text: json['text'] as String,
      network: $enumDecodeNullable(_$TonNetworkEnumMap, json['network']),
      from: json['from'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SignDataPayloadTextToJson(
  SignDataPayloadText instance,
) => <String, dynamic>{
  'text': instance.text,
  'network': _$TonNetworkEnumMap[instance.network],
  'from': instance.from,
  'type': instance.$type,
};

SignDataPayloadBinary _$SignDataPayloadBinaryFromJson(
  Map<String, dynamic> json,
) => SignDataPayloadBinary(
  bytes: json['bytes'] as String,
  network: $enumDecodeNullable(_$TonNetworkEnumMap, json['network']),
  from: json['from'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SignDataPayloadBinaryToJson(
  SignDataPayloadBinary instance,
) => <String, dynamic>{
  'bytes': instance.bytes,
  'network': _$TonNetworkEnumMap[instance.network],
  'from': instance.from,
  'type': instance.$type,
};
