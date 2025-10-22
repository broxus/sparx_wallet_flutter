// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_bookmark_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrowserBookmarkItem _$BrowserBookmarkItemFromJson(Map<String, dynamic> json) =>
    _BrowserBookmarkItem(
      id: json['id'] as String,
      title: json['title'] as String,
      url: Uri.parse(json['url'] as String),
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
    );

Map<String, dynamic> _$BrowserBookmarkItemToJson(
  _BrowserBookmarkItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'url': instance.url.toString(),
  'sortingOrder': instance.sortingOrder,
};
