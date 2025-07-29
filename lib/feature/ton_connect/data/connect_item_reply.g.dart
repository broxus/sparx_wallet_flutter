// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_item_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TonAddressItemReply _$TonAddressItemReplyFromJson(Map<String, dynamic> json) =>
    TonAddressItemReply(
      address: Address.fromJson(json['address'] as String),
      network: $enumDecode(_$TonNetworkEnumMap, json['network']),
      publicKey: PublicKey.fromJson(json['publicKey'] as String),
      walletStateInit: json['walletStateInit'] as String,
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$TonAddressItemReplyToJson(
        TonAddressItemReply instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'network': _$TonNetworkEnumMap[instance.network]!,
      'publicKey': instance.publicKey.toJson(),
      'walletStateInit': instance.walletStateInit,
      'name': instance.$type,
    };

const _$TonNetworkEnumMap = {
  TonNetwork.mainnet: '-239',
  TonNetwork.testnet: '-3',
};

TonProofItemReplySuccess _$TonProofItemReplySuccessFromJson(
        Map<String, dynamic> json) =>
    TonProofItemReplySuccess(
      proof: TonProof.fromJson(json['proof'] as Map<String, dynamic>),
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$TonProofItemReplySuccessToJson(
        TonProofItemReplySuccess instance) =>
    <String, dynamic>{
      'proof': instance.proof.toJson(),
      'name': instance.$type,
    };
