// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomCurrency _$CustomCurrencyFromJson(Map<String, dynamic> json) =>
    _CustomCurrency(
      address: Address.fromJson(json['address'] as String),
      price: json['price'] as String,
      networkType: json['networkType'] as String,
      networkGroup: json['networkGroup'] as String,
    );

Map<String, dynamic> _$CustomCurrencyToJson(_CustomCurrency instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'price': instance.price,
      'networkType': instance.networkType,
      'networkGroup': instance.networkGroup,
    };
