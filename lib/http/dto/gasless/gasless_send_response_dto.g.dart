// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gasless_send_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GaslessSendResponseDto _$GaslessSendResponseDtoFromJson(
        Map<String, dynamic> json) =>
    GaslessSendResponseDto(
      protocolName: json['protocol_name'] as String,
      transactionHash: json['transaction_hash'] as String,
    );

Map<String, dynamic> _$GaslessSendResponseDtoToJson(
        GaslessSendResponseDto instance) =>
    <String, dynamic>{
      'protocol_name': instance.protocolName,
      'transaction_hash': instance.transactionHash,
    };
