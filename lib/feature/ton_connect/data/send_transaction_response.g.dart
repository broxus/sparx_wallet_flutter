// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendTransactionResponseSuccess _$SendTransactionResponseSuccessFromJson(
        Map<String, dynamic> json) =>
    SendTransactionResponseSuccess(
      id: json['id'] as String,
      result: json['result'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SendTransactionResponseSuccessToJson(
        SendTransactionResponseSuccess instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
      'runtimeType': instance.$type,
    };

SendTransactionResponseError _$SendTransactionResponseErrorFromJson(
        Map<String, dynamic> json) =>
    SendTransactionResponseError(
      id: json['id'] as String,
      error: TonConnectError.fromJson(json['error'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SendTransactionResponseErrorToJson(
        SendTransactionResponseError instance) =>
    <String, dynamic>{
      'id': instance.id,
      'error': instance.error.toJson(),
      'runtimeType': instance.$type,
    };
