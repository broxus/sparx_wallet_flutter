// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_transaction_with_additional_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PendingTransactionWithAdditionalInfo
_$PendingTransactionWithAdditionalInfoFromJson(Map<String, dynamic> json) =>
    _PendingTransactionWithAdditionalInfo(
      transaction: PendingTransaction.fromJson(
        json['transaction'] as Map<String, dynamic>,
      ),
      amount: json['amount'] == null
          ? null
          : BigInt.parse(json['amount'] as String),
      createdAt: (json['createdAt'] as num).toInt(),
      dst: json['dst'] as String?,
    );

Map<String, dynamic> _$PendingTransactionWithAdditionalInfoToJson(
  _PendingTransactionWithAdditionalInfo instance,
) => <String, dynamic>{
  'transaction': instance.transaction.toJson(),
  'amount': instance.amount?.toString(),
  'createdAt': instance.createdAt,
  'dst': instance.dst,
};
