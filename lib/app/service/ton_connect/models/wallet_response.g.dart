// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletResponseSuccessImpl _$$WalletResponseSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletResponseSuccessImpl(
      id: json['id'] as String,
      result: json['result'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WalletResponseSuccessImplToJson(
        _$WalletResponseSuccessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
      'runtimeType': instance.$type,
    };

_$WalletResponseErrorImpl _$$WalletResponseErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletResponseErrorImpl(
      id: json['id'] as String,
      error: TonConnectError.fromJson(json['error'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WalletResponseErrorImplToJson(
        _$WalletResponseErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'error': instance.error.toJson(),
      'runtimeType': instance.$type,
    };
