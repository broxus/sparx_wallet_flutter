// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NftInformationImpl _$$NftInformationImplFromJson(Map<String, dynamic> json) =>
    _$NftInformationImpl(
      marketplaceUrl: json['marketplaceUrl'] as String?,
      defaultCollections: (json['defaultCollections'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$$NftInformationImplToJson(
        _$NftInformationImpl instance) =>
    <String, dynamic>{
      'marketplaceUrl': instance.marketplaceUrl,
      'defaultCollections':
          instance.defaultCollections?.map((e) => e.toJson()).toList(),
    };
