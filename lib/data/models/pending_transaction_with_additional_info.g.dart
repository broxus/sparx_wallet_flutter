// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_transaction_with_additional_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PendingTransactionWithAdditionalInfo
    _$PendingTransactionWithAdditionalInfoFromJson(Map<String, dynamic> json) =>
        _PendingTransactionWithAdditionalInfo(
          transaction: PendingTransaction.fromJson(
              json['transaction'] as Map<String, dynamic>),
          amount: _$JsonConverterFromJson<String, BigInt>(
              json['amount'], amountJsonConverter.fromJson),
          createdAt: (json['createdAt'] as num).toInt(),
          dst: json['dst'] as String?,
        );

Map<String, dynamic> _$PendingTransactionWithAdditionalInfoToJson(
        _PendingTransactionWithAdditionalInfo instance) =>
    <String, dynamic>{
      'transaction': instance.transaction.toJson(),
      'amount': _$JsonConverterToJson<String, BigInt>(
          instance.amount, amountJsonConverter.toJson),
      'createdAt': instance.createdAt,
      'dst': instance.dst,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
