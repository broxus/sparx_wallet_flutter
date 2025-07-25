// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Permissions _$PermissionsFromJson(Map<String, dynamic> json) => _Permissions(
      basic: json['basic'] as bool?,
      accountInteraction: json['accountInteraction'] == null
          ? null
          : AccountInteraction.fromJson(
              json['accountInteraction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PermissionsToJson(_Permissions instance) =>
    <String, dynamic>{
      if (instance.basic case final value?) 'basic': value,
      if (instance.accountInteraction?.toJson() case final value?)
        'accountInteraction': value,
    };
