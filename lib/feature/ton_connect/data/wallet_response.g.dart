// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletResponseSuccess _$WalletResponseSuccessFromJson(
  Map<String, dynamic> json,
) => WalletResponseSuccess(
  id: json['id'] as String,
  result: json['result'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$WalletResponseSuccessToJson(
  WalletResponseSuccess instance,
) => <String, dynamic>{
  'id': instance.id,
  'result': instance.result,
  'runtimeType': instance.$type,
};

WalletResponseError _$WalletResponseErrorFromJson(Map<String, dynamic> json) =>
    WalletResponseError(
      id: json['id'] as String,
      error: TonConnectError.fromJson(json['error'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$WalletResponseErrorToJson(
  WalletResponseError instance,
) => <String, dynamic>{
  'id': instance.id,
  'error': instance.error.toJson(),
  'runtimeType': instance.$type,
};
