// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftListResponseDto _$NftListResponseDtoFromJson(Map<String, dynamic> json) =>
    NftListResponseDto(
      totalCount: (json['totalCount'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => NftItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NftListResponseDtoToJson(NftListResponseDto instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

NftItemDto _$NftItemDtoFromJson(Map<String, dynamic> json) => NftItemDto(
  address: Address.fromJson(json['address'] as String),
  collection: Address.fromJson(json['collection'] as String),
  owner: Address.fromJson(json['owner'] as String),
  manager: json['manager'] == null
      ? null
      : Address.fromJson(json['manager'] as String),
  name: json['name'] as String?,
  description: json['description'] as String?,
  nftId: json['nftId'] as String?,
  image: json['image'] as String?,
  mimetype: json['mimetype'] as String?,
  fullImage: json['fullImage'] as String?,
  fullImageMimetype: json['fullImageMimetype'] as String?,
);

Map<String, dynamic> _$NftItemDtoToJson(NftItemDto instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'collection': instance.collection.toJson(),
      'owner': instance.owner.toJson(),
      'manager': instance.manager?.toJson(),
      'name': instance.name,
      'description': instance.description,
      'nftId': instance.nftId,
      'image': instance.image,
      'mimetype': instance.mimetype,
      'fullImage': instance.fullImage,
      'fullImageMimetype': instance.fullImageMimetype,
    };
