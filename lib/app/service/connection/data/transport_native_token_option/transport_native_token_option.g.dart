// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_native_token_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportNativeTokenTickerOptionFromConnection
    _$TransportNativeTokenTickerOptionFromConnectionFromJson(
            Map<String, dynamic> json) =>
        TransportNativeTokenTickerOptionFromConnection(
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$TransportNativeTokenTickerOptionFromConnectionToJson(
        TransportNativeTokenTickerOptionFromConnection instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

TransportNativeTokenTickerOptionByName
    _$TransportNativeTokenTickerOptionByNameFromJson(
            Map<String, dynamic> json) =>
        TransportNativeTokenTickerOptionByName(
          json['name'] as String,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$TransportNativeTokenTickerOptionByNameToJson(
        TransportNativeTokenTickerOptionByName instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };
