// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'st_ever_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StEverDetails _$StEverDetailsFromJson(Map<String, dynamic> json) =>
    _StEverDetails(
      stEverSupply:
          amountJsonConverter.fromJson(json['stEverSupply'] as String),
      totalAssets: amountJsonConverter.fromJson(json['totalAssets'] as String),
      withdrawHoldTime: json['withdrawHoldTime'] as String,
    );

Map<String, dynamic> _$StEverDetailsToJson(_StEverDetails instance) =>
    <String, dynamic>{
      'stEverSupply': amountJsonConverter.toJson(instance.stEverSupply),
      'totalAssets': amountJsonConverter.toJson(instance.totalAssets),
      'withdrawHoldTime': instance.withdrawHoldTime,
    };
