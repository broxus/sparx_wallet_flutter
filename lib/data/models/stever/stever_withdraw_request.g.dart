// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stever_withdraw_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StEverWithdrawRequest _$StEverWithdrawRequestFromJson(
        Map<String, dynamic> json) =>
    _StEverWithdrawRequest(
      nonce: json['nonce'] as String,
      data: StEverWithdrawRequestData.fromJson(
          json['data'] as Map<String, dynamic>),
      accountAddress: Address.fromJson(json['accountAddress'] as String),
    );

Map<String, dynamic> _$StEverWithdrawRequestToJson(
        _StEverWithdrawRequest instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'data': instance.data.toJson(),
      'accountAddress': instance.accountAddress.toJson(),
    };

_StEverWithdrawRequestData _$StEverWithdrawRequestDataFromJson(
        Map<String, dynamic> json) =>
    _StEverWithdrawRequestData(
      amount: amountJsonConverter.fromJson(json['amount'] as String),
      timestamp: timestampFromStringJsonConverter
          .fromJson(json['timestamp'] as String),
    );

Map<String, dynamic> _$StEverWithdrawRequestDataToJson(
        _StEverWithdrawRequestData instance) =>
    <String, dynamic>{
      'amount': amountJsonConverter.toJson(instance.amount),
      'timestamp': timestampFromStringJsonConverter.toJson(instance.timestamp),
    };
