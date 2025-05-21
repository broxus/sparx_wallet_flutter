// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrowserGroupImpl _$$BrowserGroupImplFromJson(Map<String, dynamic> json) =>
    _$BrowserGroupImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      tabsIds: (json['tabsIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const <String>{},
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      isCanRemoved: json['isCanRemoved'] as bool? ?? false,
      isCanEditTitle: json['isCanEditTitle'] as bool? ?? false,
    );

Map<String, dynamic> _$$BrowserGroupImplToJson(_$BrowserGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tabsIds': instance.tabsIds.toList(),
      'sortingOrder': instance.sortingOrder,
      'isCanRemoved': instance.isCanRemoved,
      'isCanEditTitle': instance.isCanEditTitle,
    };
