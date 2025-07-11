// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrowserGroup _$BrowserGroupFromJson(Map<String, dynamic> json) =>
    _BrowserGroup(
      id: json['id'] as String,
      title: json['title'] as String?,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      tabsIds: (json['tabsIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isEditable: json['isEditable'] as bool? ?? true,
    );

Map<String, dynamic> _$BrowserGroupToJson(_BrowserGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sortingOrder': instance.sortingOrder,
      'tabsIds': instance.tabsIds,
      'isEditable': instance.isEditable,
    };
