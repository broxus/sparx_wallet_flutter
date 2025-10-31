// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NftInformation _$NftInformationFromJson(Map<String, dynamic> json) =>
    _NftInformation(
      marketplaceUrl: json['marketplaceUrl'] as String?,
      apiBaseUrl: json['apiBaseUrl'] as String?,
      defaultCollections: (json['defaultCollections'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$NftInformationToJson(_NftInformation instance) =>
    <String, dynamic>{
      'marketplaceUrl': instance.marketplaceUrl,
      'apiBaseUrl': instance.apiBaseUrl,
      'defaultCollections': instance.defaultCollections
          ?.map((e) => e.toJson())
          .toList(),
    };
