// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_active_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DefaultActiveAsset _$DefaultActiveAssetFromJson(Map<String, dynamic> json) =>
    _DefaultActiveAsset(
      address:
          const AddressStringConverter().fromJson(json['address'] as String),
    );

Map<String, dynamic> _$DefaultActiveAssetToJson(_DefaultActiveAsset instance) =>
    <String, dynamic>{
      'address': const AddressStringConverter().toJson(instance.address),
    };
