// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SendTransactionImpl _$$SendTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$SendTransactionImpl(
      maxMessages: (json['maxMessages'] as num).toInt(),
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$$SendTransactionImplToJson(
        _$SendTransactionImpl instance) =>
    <String, dynamic>{
      'maxMessages': instance.maxMessages,
      'name': instance.$type,
    };

_$SignDataImpl _$$SignDataImplFromJson(Map<String, dynamic> json) =>
    _$SignDataImpl(
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$$SignDataImplToJson(_$SignDataImpl instance) =>
    <String, dynamic>{
      'name': instance.$type,
    };
