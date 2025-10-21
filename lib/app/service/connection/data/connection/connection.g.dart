// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ConnectionToJson(Connection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'networkName': instance.networkName,
      'defaultWorkchainId': instance.defaultWorkchainId,
      'workchains': instance.workchains.map((e) => e.toJson()).toList(),
      'isPreset': instance.isPreset,
      'canBeEdited': instance.canBeEdited,
    };
