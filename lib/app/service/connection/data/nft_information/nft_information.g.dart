// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NftInformation _$NftInformationFromJson(Map<String, dynamic> json) =>
    _NftInformation(
      marketplaceUrl: json['marketplaceUrl'] as String?,
      defaultCollections: _$JsonConverterFromJson<List<dynamic>, List<Address>>(
        json['defaultCollections'],
        const AddressListConverter().fromJson,
      ),
    );

Map<String, dynamic> _$NftInformationToJson(_NftInformation instance) =>
    <String, dynamic>{
      'marketplaceUrl': instance.marketplaceUrl,
      'defaultCollections': _$JsonConverterToJson<List<dynamic>, List<Address>>(
        instance.defaultCollections,
        const AddressListConverter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
