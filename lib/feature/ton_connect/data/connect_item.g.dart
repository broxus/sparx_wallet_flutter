// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TonAddressItem _$TonAddressItemFromJson(Map<String, dynamic> json) =>
    TonAddressItem(
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$TonAddressItemToJson(TonAddressItem instance) =>
    <String, dynamic>{
      'name': instance.$type,
    };

TonProofItem _$TonProofItemFromJson(Map<String, dynamic> json) => TonProofItem(
      payload: json['payload'] as String,
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$TonProofItemToJson(TonProofItem instance) =>
    <String, dynamic>{
      'payload': instance.payload,
      'name': instance.$type,
    };
