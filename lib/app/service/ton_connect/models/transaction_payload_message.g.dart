// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_payload_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionPayloadMessage _$TransactionPayloadMessageFromJson(
        Map<String, dynamic> json) =>
    _TransactionPayloadMessage(
      address: Address.fromJson(json['address'] as String),
      amount: json['amount'] as String,
      payload: json['payload'] as String?,
      stateInit: json['stateInit'] as String?,
    );

Map<String, dynamic> _$TransactionPayloadMessageToJson(
        _TransactionPayloadMessage instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'amount': instance.amount,
      'payload': instance.payload,
      'stateInit': instance.stateInit,
    };
