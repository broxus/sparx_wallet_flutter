// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_collection_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NftCollectionSettings _$NftCollectionSettingsFromJson(
  Map<String, dynamic> json,
) => _NftCollectionSettings(
  address: Address.fromJson(json['address'] as String),
  networkGroup: json['networkGroup'] as String,
  isVisible: json['isVisible'] as bool? ?? true,
);

Map<String, dynamic> _$NftCollectionSettingsToJson(
  _NftCollectionSettings instance,
) => <String, dynamic>{
  'address': instance.address.toJson(),
  'networkGroup': instance.networkGroup,
  'isVisible': instance.isVisible,
};
