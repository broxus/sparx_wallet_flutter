// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_item_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TonAddressItemReplyImpl _$$TonAddressItemReplyImplFromJson(
        Map<String, dynamic> json) =>
    _$TonAddressItemReplyImpl(
      address: Address.fromJson(json['address'] as String),
      network: $enumDecode(_$TonNetworkEnumMap, json['network']),
      publicKey: PublicKey.fromJson(json['publicKey'] as String),
      walletStateInit: json['walletStateInit'] as String,
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$$TonAddressItemReplyImplToJson(
        _$TonAddressItemReplyImpl instance) =>
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

_$TonProofItemReplySuccessImpl _$$TonProofItemReplySuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$TonProofItemReplySuccessImpl(
      proof: TonProof.fromJson(json['proof'] as Map<String, dynamic>),
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$$TonProofItemReplySuccessImplToJson(
        _$TonProofItemReplySuccessImpl instance) =>
    <String, dynamic>{
      'proof': instance.proof.toJson(),
      'name': instance.$type,
    };
