// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectRequest _$ConnectRequestFromJson(Map<String, dynamic> json) =>
    _ConnectRequest(
      manifestUrl: json['manifestUrl'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ConnectItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConnectRequestToJson(_ConnectRequest instance) =>
    <String, dynamic>{
      'manifestUrl': instance.manifestUrl,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
