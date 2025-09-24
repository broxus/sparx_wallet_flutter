// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_tab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrowserTab _$BrowserTabFromJson(Map<String, dynamic> json) => _BrowserTab(
      id: json['id'] as String,
      url: Uri.parse(json['url'] as String),
      title: json['title'] as String?,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
    );

Map<String, dynamic> _$BrowserTabToJson(_BrowserTab instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url.toString(),
      'title': instance.title,
      'sortingOrder': instance.sortingOrder,
    };
