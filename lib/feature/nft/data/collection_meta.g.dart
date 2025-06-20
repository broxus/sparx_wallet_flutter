// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionMetaImpl _$$CollectionMetaImplFromJson(Map<String, dynamic> json) =>
    _$CollectionMetaImpl(
      collection: Address.fromJson(json['collection'] as String),
      networkGroup: json['networkGroup'] as String,
      isVisible: json['isVisible'] as bool? ?? true,
    );

Map<String, dynamic> _$$CollectionMetaImplToJson(
        _$CollectionMetaImpl instance) =>
    <String, dynamic>{
      'collection': instance.collection.toJson(),
      'networkGroup': instance.networkGroup,
      'isVisible': instance.isVisible,
    };
