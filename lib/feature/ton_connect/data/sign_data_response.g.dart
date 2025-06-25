// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignDataResponseSuccessImpl _$$SignDataResponseSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$SignDataResponseSuccessImpl(
      id: json['id'] as String,
      result: SignDataResult.fromJson(json['result'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SignDataResponseSuccessImplToJson(
        _$SignDataResponseSuccessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result.toJson(),
      'runtimeType': instance.$type,
    };

_$SignDataResponseErrorImpl _$$SignDataResponseErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$SignDataResponseErrorImpl(
      id: json['id'] as String,
      error: TonConnectError.fromJson(json['error'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SignDataResponseErrorImplToJson(
        _$SignDataResponseErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'error': instance.error.toJson(),
      'runtimeType': instance.$type,
    };
