// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_data_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignDataResult _$SignDataResultFromJson(Map<String, dynamic> json) =>
    _SignDataResult(
      signature: json['signature'] as String,
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$SignDataResultToJson(_SignDataResult instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'timestamp': instance.timestamp,
    };
