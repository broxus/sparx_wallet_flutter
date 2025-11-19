// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CollectionMeta _$CollectionMetaFromJson(Map<String, dynamic> json) =>
    _CollectionMeta(
      address: Address.fromJson(json['address'] as String),
      networkGroup: json['networkGroup'] as String,
      isVisible: json['isVisible'] as bool? ?? true,
    );

Map<String, dynamic> _$CollectionMetaToJson(_CollectionMeta instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'networkGroup': instance.networkGroup,
      'isVisible': instance.isVisible,
    };
