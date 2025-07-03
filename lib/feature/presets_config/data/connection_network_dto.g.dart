// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_network_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectionNetworkDto _$ConnectionNetworkDtoFromJson(
        Map<String, dynamic> json) =>
    _ConnectionNetworkDto(
      defaultConnectionId: json['defaultConnectionId'] as String,
      networks: (json['networks'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      transports: (json['transports'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      customNetworkOtions: (json['customNetworkOtions'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ConnectionNetworkDtoToJson(
        _ConnectionNetworkDto instance) =>
    <String, dynamic>{
      'defaultConnectionId': instance.defaultConnectionId,
      'networks': instance.networks,
      'transports': instance.transports,
      'customNetworkOtions': instance.customNetworkOtions,
    };
