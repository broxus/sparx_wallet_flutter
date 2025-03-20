// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_connect_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TonConnectErrorImpl _$$TonConnectErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$TonConnectErrorImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$TonConnectErrorImplToJson(
        _$TonConnectErrorImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
