// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_app_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TonAppConnectionRemoteImpl _$$TonAppConnectionRemoteImplFromJson(
        Map<String, dynamic> json) =>
    _$TonAppConnectionRemoteImpl(
      clientId: json['clientId'] as String,
      sessionCrypto: SessionCrypto.fromJson(json['sessionCrypto'] as String),
      replyItems: (json['replyItems'] as List<dynamic>)
          .map((e) => ConnectItemReply.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletAddress: Address.fromJson(json['walletAddress'] as String),
      manifest: DappManifest.fromJson(json['manifest'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TonAppConnectionRemoteImplToJson(
        _$TonAppConnectionRemoteImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'sessionCrypto': instance.sessionCrypto.toJson(),
      'replyItems': instance.replyItems.map((e) => e.toJson()).toList(),
      'walletAddress': instance.walletAddress.toJson(),
      'manifest': instance.manifest.toJson(),
      'runtimeType': instance.$type,
    };

_$TonAppConnectionInjectedImpl _$$TonAppConnectionInjectedImplFromJson(
        Map<String, dynamic> json) =>
    _$TonAppConnectionInjectedImpl(
      origin: json['origin'] as String,
      replyItems: (json['replyItems'] as List<dynamic>)
          .map((e) => ConnectItemReply.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletAddress: Address.fromJson(json['walletAddress'] as String),
      manifest: DappManifest.fromJson(json['manifest'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TonAppConnectionInjectedImplToJson(
        _$TonAppConnectionInjectedImpl instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'replyItems': instance.replyItems.map((e) => e.toJson()).toList(),
      'walletAddress': instance.walletAddress.toJson(),
      'manifest': instance.manifest.toJson(),
      'runtimeType': instance.$type,
    };
