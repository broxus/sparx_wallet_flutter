// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gasless_send_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GaslessSendRequestDto _$GaslessSendRequestDtoFromJson(
  Map<String, dynamic> json,
) => GaslessSendRequestDto(
  walletPublicKey: PublicKey.fromJson(json['wallet_public_key'] as String),
  boc: json['boc'] as String,
);

Map<String, dynamic> _$GaslessSendRequestDtoToJson(
  GaslessSendRequestDto instance,
) => <String, dynamic>{
  'wallet_public_key': instance.walletPublicKey.toJson(),
  'boc': instance.boc,
};
