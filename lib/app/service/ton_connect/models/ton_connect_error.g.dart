// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_connect_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TonConnectError _$TonConnectErrorFromJson(Map<String, dynamic> json) =>
    _TonConnectError(
      code: $enumDecode(_$TonConnectErrorCodeEnumMap, json['code']),
      message: json['message'] as String,
    );

Map<String, dynamic> _$TonConnectErrorToJson(_TonConnectError instance) =>
    <String, dynamic>{
      'code': _$TonConnectErrorCodeEnumMap[instance.code]!,
      'message': instance.message,
    };

const _$TonConnectErrorCodeEnumMap = {
  TonConnectErrorCode.unknownError: 0,
  TonConnectErrorCode.badRequest: 1,
  TonConnectErrorCode.appManifestNotFound: 2,
  TonConnectErrorCode.appManifestContentError: 3,
  TonConnectErrorCode.unknownApp: 100,
  TonConnectErrorCode.userDeclined: 300,
  TonConnectErrorCode.methodNotSupported: 400,
};
