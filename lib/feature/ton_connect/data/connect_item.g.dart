// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TonAddressItemImpl _$$TonAddressItemImplFromJson(Map<String, dynamic> json) =>
    _$TonAddressItemImpl(
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$$TonAddressItemImplToJson(
        _$TonAddressItemImpl instance) =>
    <String, dynamic>{
      'name': instance.$type,
    };

_$TonProofItemImpl _$$TonProofItemImplFromJson(Map<String, dynamic> json) =>
    _$TonProofItemImpl(
      payload: json['payload'] as String,
      $type: json['name'] as String?,
    );

Map<String, dynamic> _$$TonProofItemImplToJson(_$TonProofItemImpl instance) =>
    <String, dynamic>{
      'payload': instance.payload,
      'name': instance.$type,
    };
