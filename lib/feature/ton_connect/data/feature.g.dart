// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendTransaction _$SendTransactionFromJson(Map<String, dynamic> json) =>
    _SendTransaction(
      maxMessages: (json['maxMessages'] as num).toInt(),
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$SendTransactionToJson(_SendTransaction instance) =>
    <String, dynamic>{
      'maxMessages': instance.maxMessages,
      'name': instance.$type,
    };

_SignData _$SignDataFromJson(Map<String, dynamic> json) =>
    _SignData($type: json['name'] as String?);

Map<String, dynamic> _$SignDataToJson(_SignData instance) => <String, dynamic>{
  'name': instance.$type,
};
