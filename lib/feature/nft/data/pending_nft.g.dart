// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_nft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PendingNft _$PendingNftFromJson(Map<String, dynamic> json) => _PendingNft(
  id: json['id'] as String,
  collection: Address.fromJson(json['collection'] as String),
  networkGroup: json['networkGroup'] as String,
  owner: Address.fromJson(json['owner'] as String),
);

Map<String, dynamic> _$PendingNftToJson(_PendingNft instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collection': instance.collection.toJson(),
      'networkGroup': instance.networkGroup,
      'owner': instance.owner.toJson(),
    };
