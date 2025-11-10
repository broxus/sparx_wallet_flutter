// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_list_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftListRequestDto _$NftListRequestDtoFromJson(Map<String, dynamic> json) =>
    NftListRequestDto(
      owners: (json['owners'] as List<dynamic>)
          .map((e) => Address.fromJson(e as String))
          .toList(),
      collections: (json['collections'] as List<dynamic>)
          .map((e) => Address.fromJson(e as String))
          .toList(),
      limit: (json['limit'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$NftListRequestDtoToJson(NftListRequestDto instance) =>
    <String, dynamic>{
      'owners': instance.owners.map((e) => e.toJson()).toList(),
      'collections': instance.collections.map((e) => e.toJson()).toList(),
      'limit': instance.limit,
      'offset': instance.offset,
      'verified': instance.verified,
    };
