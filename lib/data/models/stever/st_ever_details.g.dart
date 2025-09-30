// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'st_ever_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StEverDetails _$StEverDetailsFromJson(Map<String, dynamic> json) =>
    _StEverDetails(
      stEverSupply: BigInt.parse(json['stEverSupply'] as String),
      totalAssets: BigInt.parse(json['totalAssets'] as String),
      withdrawHoldTime: json['withdrawHoldTime'] as String,
    );

Map<String, dynamic> _$StEverDetailsToJson(_StEverDetails instance) =>
    <String, dynamic>{
      'stEverSupply': instance.stEverSupply.toString(),
      'totalAssets': instance.totalAssets.toString(),
      'withdrawHoldTime': instance.withdrawHoldTime,
    };
