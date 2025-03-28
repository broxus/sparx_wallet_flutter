// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_connect_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TonConnectErrorImpl _$$TonConnectErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$TonConnectErrorImpl(
      code: $enumDecode(_$TonConnectErrorCodeEnumMap, json['code']),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$TonConnectErrorImplToJson(
        _$TonConnectErrorImpl instance) =>
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
