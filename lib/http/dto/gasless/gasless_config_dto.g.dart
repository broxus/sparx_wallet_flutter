// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gasless_config_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GaslessConfigDto _$GaslessConfigDtoFromJson(Map<String, dynamic> json) =>
    GaslessConfigDto(
      relayAddress: Address.fromJson(json['relay_address'] as String),
      gasJettons: (json['gas_jettons'] as List<dynamic>)
          .map((e) => GasJettonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GaslessConfigDtoToJson(GaslessConfigDto instance) =>
    <String, dynamic>{
      'relay_address': instance.relayAddress.toJson(),
      'gas_jettons': instance.gasJettons.map((e) => e.toJson()).toList(),
    };

GasJettonDto _$GasJettonDtoFromJson(Map<String, dynamic> json) => GasJettonDto(
      masterId: Address.fromJson(json['master_id'] as String),
    );

Map<String, dynamic> _$GasJettonDtoToJson(GasJettonDto instance) =>
    <String, dynamic>{
      'master_id': instance.masterId.toJson(),
    };
