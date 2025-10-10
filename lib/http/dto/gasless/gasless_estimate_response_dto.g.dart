// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gasless_estimate_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GaslessEstimateResponseDto _$GaslessEstimateResponseDtoFromJson(
  Map<String, dynamic> json,
) => GaslessEstimateResponseDto(
  protocolName: json['protocol_name'] as String,
  relayAddress: Address.fromJson(json['relay_address'] as String),
  from: Address.fromJson(json['from'] as String),
  messages: (json['messages'] as List<dynamic>)
      .map((e) => SignRawMessageDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  commission: BigInt.parse(json['commission'] as String),
  validUntil: (json['valid_until'] as num).toInt(),
);

Map<String, dynamic> _$GaslessEstimateResponseDtoToJson(
  GaslessEstimateResponseDto instance,
) => <String, dynamic>{
  'protocol_name': instance.protocolName,
  'relay_address': instance.relayAddress.toJson(),
  'commission': instance.commission.toString(),
  'from': instance.from.toJson(),
  'valid_until': instance.validUntil,
  'messages': instance.messages.map((e) => e.toJson()).toList(),
};

SignRawMessageDto _$SignRawMessageDtoFromJson(Map<String, dynamic> json) =>
    SignRawMessageDto(
      address: Address.fromJson(json['address'] as String),
      amount: BigInt.parse(json['amount'] as String),
      payload: json['payload'] as String?,
      stateInit: json['stateInit'] as String?,
    );

Map<String, dynamic> _$SignRawMessageDtoToJson(SignRawMessageDto instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'amount': instance.amount.toString(),
      'payload': instance.payload,
      'stateInit': instance.stateInit,
    };
