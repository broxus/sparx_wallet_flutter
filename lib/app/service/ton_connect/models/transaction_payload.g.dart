// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionPayloadImpl _$$TransactionPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionPayloadImpl(
      messages: (json['messages'] as List<dynamic>)
          .map((e) =>
              TransactionPayloadMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      validUntil: (json['valid_until'] as num?)?.toInt(),
      network: $enumDecodeNullable(_$TonNetworkEnumMap, json['network']),
      from: json['from'] == null
          ? null
          : Address.fromJson(json['from'] as String),
    );

Map<String, dynamic> _$$TransactionPayloadImplToJson(
        _$TransactionPayloadImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'valid_until': instance.validUntil,
      'network': _$TonNetworkEnumMap[instance.network],
      'from': instance.from?.toJson(),
    };

const _$TonNetworkEnumMap = {
  TonNetwork.mainnet: '-239',
  TonNetwork.testnet: '-3',
};
