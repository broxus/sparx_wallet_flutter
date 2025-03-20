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
      manifestUrl: json['manifestUrl'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TonAppConnectionRemoteImplToJson(
        _$TonAppConnectionRemoteImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'sessionCrypto': instance.sessionCrypto.toJson(),
      'replyItems': instance.replyItems.map((e) => e.toJson()).toList(),
      'walletAddress': instance.walletAddress.toJson(),
      'manifestUrl': instance.manifestUrl,
      'runtimeType': instance.$type,
    };

_$TonAppConnectionInjectedImpl _$$TonAppConnectionInjectedImplFromJson(
        Map<String, dynamic> json) =>
    _$TonAppConnectionInjectedImpl(
      replyItems:
          ConnectItemReply.fromJson(json['replyItems'] as Map<String, dynamic>),
      walletAddress: Address.fromJson(json['walletAddress'] as String),
      manifestUrl: json['manifestUrl'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TonAppConnectionInjectedImplToJson(
        _$TonAppConnectionInjectedImpl instance) =>
    <String, dynamic>{
      'replyItems': instance.replyItems.toJson(),
      'walletAddress': instance.walletAddress.toJson(),
      'manifestUrl': instance.manifestUrl,
      'runtimeType': instance.$type,
    };
