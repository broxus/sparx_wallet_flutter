// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_meta_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SiteMetaData _$SiteMetaDataFromJson(Map<String, dynamic> json) =>
    _SiteMetaData(
      url: json['url'] as String,
      title: json['title'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SiteMetaDataToJson(_SiteMetaData instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'image': instance.image,
      'description': instance.description,
    };
