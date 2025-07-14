// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SendTransactionResponseSuccessImpl
    _$$SendTransactionResponseSuccessImplFromJson(Map<String, dynamic> json) =>
        _$SendTransactionResponseSuccessImpl(
          id: json['id'] as String,
          result: json['result'] as String,
          $type: json['runtimeType'] as String?,
        );

Map<String, dynamic> _$$SendTransactionResponseSuccessImplToJson(
        _$SendTransactionResponseSuccessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
      'runtimeType': instance.$type,
    };

_$SendTransactionResponseErrorImpl _$$SendTransactionResponseErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$SendTransactionResponseErrorImpl(
      id: json['id'] as String,
      error: TonConnectError.fromJson(json['error'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SendTransactionResponseErrorImplToJson(
        _$SendTransactionResponseErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'error': instance.error.toJson(),
      'runtimeType': instance.$type,
    };
