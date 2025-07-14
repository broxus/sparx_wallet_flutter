// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_nft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PendingNftImpl _$$PendingNftImplFromJson(Map<String, dynamic> json) =>
    _$PendingNftImpl(
      id: json['id'] as String,
      collection: Address.fromJson(json['collection'] as String),
      networkGroup: json['networkGroup'] as String,
      owner: Address.fromJson(json['owner'] as String),
    );

Map<String, dynamic> _$$PendingNftImplToJson(_$PendingNftImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collection': instance.collection.toJson(),
      'networkGroup': instance.networkGroup,
      'owner': instance.owner.toJson(),
    };
