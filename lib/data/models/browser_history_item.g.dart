// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrowserHistoryItemDto _$BrowserHistoryItemDtoFromJson(
  Map<String, dynamic> json,
) => _BrowserHistoryItemDto(
  id: json['id'] as String,
  title: json['title'] as String,
  url: Uri.parse(json['url'] as String),
  visitTime: DateTime.parse(json['visitTime'] as String),
);

Map<String, dynamic> _$BrowserHistoryItemDtoToJson(
  _BrowserHistoryItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'url': instance.url.toString(),
  'visitTime': instance.visitTime.toIso8601String(),
};
