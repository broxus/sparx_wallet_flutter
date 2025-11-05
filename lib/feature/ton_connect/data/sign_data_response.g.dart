// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignDataResponseSuccess _$SignDataResponseSuccessFromJson(
  Map<String, dynamic> json,
) => SignDataResponseSuccess(
  id: json['id'] as String,
  result: SignDataResult.fromJson(json['result'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SignDataResponseSuccessToJson(
  SignDataResponseSuccess instance,
) => <String, dynamic>{
  'id': instance.id,
  'result': instance.result.toJson(),
  'runtimeType': instance.$type,
};

SignDataResponseError _$SignDataResponseErrorFromJson(
  Map<String, dynamic> json,
) => SignDataResponseError(
  id: json['id'] as String,
  error: TonConnectError.fromJson(json['error'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SignDataResponseErrorToJson(
  SignDataResponseError instance,
) => <String, dynamic>{
  'id': instance.id,
  'error': instance.error.toJson(),
  'runtimeType': instance.$type,
};
