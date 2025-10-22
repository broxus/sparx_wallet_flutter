// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateRules _$UpdateRulesFromJson(Map<String, dynamic> json) => _UpdateRules(
  blockingVersion: json['blockingVersion'] as String,
  warningVersion: json['warningVersion'] as String,
  warningShowTimes: (json['warningShowTimes'] as num).toInt(),
  warningShowDelayS: (json['warningShowDelayS'] as num).toInt(),
);

Map<String, dynamic> _$UpdateRulesToJson(_UpdateRules instance) =>
    <String, dynamic>{
      'blockingVersion': instance.blockingVersion,
      'warningVersion': instance.warningVersion,
      'warningShowTimes': instance.warningShowTimes,
      'warningShowDelayS': instance.warningShowDelayS,
    };
