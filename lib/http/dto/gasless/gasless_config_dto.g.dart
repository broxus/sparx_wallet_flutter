// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gasless_config_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GaslessConfigDto _$GaslessConfigDtoFromJson(Map<String, dynamic> json) =>
    GaslessConfigDto(
      relayAddress: Address.fromJson(json['relayAddress'] as String),
      gasJettons: (json['gasJettons'] as List<dynamic>)
          .map((e) => GasJettonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GaslessConfigDtoToJson(GaslessConfigDto instance) =>
    <String, dynamic>{
      'relayAddress': instance.relayAddress.toJson(),
      'gasJettons': instance.gasJettons.map((e) => e.toJson()).toList(),
    };

GasJettonDto _$GasJettonDtoFromJson(Map<String, dynamic> json) => GasJettonDto(
      masterId: Address.fromJson(json['masterId'] as String),
    );

Map<String, dynamic> _$GasJettonDtoToJson(GasJettonDto instance) =>
    <String, dynamic>{
      'masterId': instance.masterId.toJson(),
    };
