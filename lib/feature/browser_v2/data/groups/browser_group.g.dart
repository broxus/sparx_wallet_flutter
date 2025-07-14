// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrowserGroupImpl _$$BrowserGroupImplFromJson(Map<String, dynamic> json) =>
    _$BrowserGroupImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      tabsIds: (json['tabsIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isEditable: json['isEditable'] as bool? ?? true,
    );

Map<String, dynamic> _$$BrowserGroupImplToJson(_$BrowserGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sortingOrder': instance.sortingOrder,
      'tabsIds': instance.tabsIds,
      'isEditable': instance.isEditable,
    };
