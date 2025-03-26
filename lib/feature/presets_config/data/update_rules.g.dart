// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateRulesImpl _$$UpdateRulesImplFromJson(Map<String, dynamic> json) =>
    _$UpdateRulesImpl(
      blockingVersion: json['blockingVersion'] as String,
      warningVersion: json['warningVersion'] as String,
      warningShowTimes: (json['warningShowTimes'] as num).toInt(),
      warningShowDelayS: (json['warningShowDelayS'] as num).toInt(),
    );

Map<String, dynamic> _$$UpdateRulesImplToJson(_$UpdateRulesImpl instance) =>
    <String, dynamic>{
      'blockingVersion': instance.blockingVersion,
      'warningVersion': instance.warningVersion,
      'warningShowTimes': instance.warningShowTimes,
      'warningShowDelayS': instance.warningShowDelayS,
    };
