// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DisconnectRpcRequestImpl _$$DisconnectRpcRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$DisconnectRpcRequestImpl(
      id: json['id'] as String,
      params: json['params'] as List<dynamic>? ?? const [],
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$DisconnectRpcRequestImplToJson(
        _$DisconnectRpcRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'params': instance.params,
      'method': instance.$type,
    };

_$SendTransactionRpcRequestImpl _$$SendTransactionRpcRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SendTransactionRpcRequestImpl(
      id: json['id'] as String,
      params:
          (json['params'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$SendTransactionRpcRequestImplToJson(
        _$SendTransactionRpcRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'params': instance.params,
      'method': instance.$type,
    };

_$SignDataRpcRequestImpl _$$SignDataRpcRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SignDataRpcRequestImpl(
      id: json['id'] as String,
      params:
          (json['params'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$$SignDataRpcRequestImplToJson(
        _$SignDataRpcRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'params': instance.params,
      'method': instance.$type,
    };
