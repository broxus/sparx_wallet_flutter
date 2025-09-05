// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gasless_estimate_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GaslessEstimateRequestDto _$GaslessEstimateRequestDtoFromJson(
        Map<String, dynamic> json) =>
    GaslessEstimateRequestDto(
      walletAddress: Address.fromJson(json['walletAddress'] as String),
      walletPublicKey: PublicKey.fromJson(json['walletPublicKey'] as String),
      messages:
          (json['messages'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GaslessEstimateRequestDtoToJson(
        GaslessEstimateRequestDto instance) =>
    <String, dynamic>{
      'walletAddress': instance.walletAddress.toJson(),
      'walletPublicKey': instance.walletPublicKey.toJson(),
      'messages': instance.messages,
    };

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      boc: json['boc'] as String,
    );

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'boc': instance.boc,
    };
