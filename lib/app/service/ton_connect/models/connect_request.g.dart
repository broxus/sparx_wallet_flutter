// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectRequestImpl _$$ConnectRequestImplFromJson(Map<String, dynamic> json) =>
    _$ConnectRequestImpl(
      manifestUrl: json['manifestUrl'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ConnectItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ConnectRequestImplToJson(
        _$ConnectRequestImpl instance) =>
    <String, dynamic>{
      'manifestUrl': instance.manifestUrl,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
