// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DisconnectRpcRequest _$DisconnectRpcRequestFromJson(
        Map<String, dynamic> json) =>
    DisconnectRpcRequest(
      id: json['id'] as String,
      params: json['params'] as List<dynamic>? ?? const [],
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$DisconnectRpcRequestToJson(
        DisconnectRpcRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'params': instance.params,
      'method': instance.$type,
    };

SendTransactionRpcRequest _$SendTransactionRpcRequestFromJson(
        Map<String, dynamic> json) =>
    SendTransactionRpcRequest(
      id: json['id'] as String,
      params:
          (json['params'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$SendTransactionRpcRequestToJson(
        SendTransactionRpcRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'params': instance.params,
      'method': instance.$type,
    };

SignDataRpcRequest _$SignDataRpcRequestFromJson(Map<String, dynamic> json) =>
    SignDataRpcRequest(
      id: json['id'] as String,
      params:
          (json['params'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['method'] as String?,
    );

Map<String, dynamic> _$SignDataRpcRequestToJson(SignDataRpcRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'params': instance.params,
      'method': instance.$type,
    };
