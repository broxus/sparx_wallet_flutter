// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_bookmark_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrowserBookmarkItemImpl _$$BrowserBookmarkItemImplFromJson(
        Map<String, dynamic> json) =>
    _$BrowserBookmarkItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      uri: uriJsonConverter.fromJson(json['uri'] as String),
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
    );

Map<String, dynamic> _$$BrowserBookmarkItemImplToJson(
        _$BrowserBookmarkItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'uri': uriJsonConverter.toJson(instance.uri),
      'sortingOrder': instance.sortingOrder,
    };
