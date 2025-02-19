// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_item_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TonAddressImpl _$$TonAddressImplFromJson(Map<String, dynamic> json) =>
    _$TonAddressImpl(
      address: Address.fromJson(json['address'] as String),
      network: json['network'] as String,
      publicKey: json['publicKey'] as String,
      walletStateInit: json['walletStateInit'] as String,
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$$TonAddressImplToJson(_$TonAddressImpl instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'network': instance.network,
      'publicKey': instance.publicKey,
      'walletStateInit': instance.walletStateInit,
      'name': instance.$type,
    };

_$TonProofSuccessImpl _$$TonProofSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$TonProofSuccessImpl(
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$$TonProofSuccessImplToJson(
        _$TonProofSuccessImpl instance) =>
    <String, dynamic>{
      'name': instance.$type,
    };
