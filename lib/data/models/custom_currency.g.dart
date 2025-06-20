// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomCurrencyImpl _$$CustomCurrencyImplFromJson(Map<String, dynamic> json) =>
    _$CustomCurrencyImpl(
      address: Address.fromJson(json['address'] as String),
      price: json['price'] as String,
      networkType: NetworkType.fromJson(json['networkType'] as String),
      networkGroup: json['networkGroup'] as String,
    );

Map<String, dynamic> _$$CustomCurrencyImplToJson(
        _$CustomCurrencyImpl instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'price': instance.price,
      'networkType': instance.networkType.toJson(),
      'networkGroup': instance.networkGroup,
    };
