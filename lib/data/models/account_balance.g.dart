// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountBalanceModel _$AccountBalanceModelFromJson(Map<String, dynamic> json) =>
    _AccountBalanceModel(
      rootTokenContract: Address.fromJson(json['rootTokenContract'] as String),
      fiatBalance: moneyFromStringJsonConverter
          .fromJson(json['fiatBalance'] as Map<String, dynamic>),
      tokenBalance: moneyFromStringJsonConverter
          .fromJson(json['tokenBalance'] as Map<String, dynamic>),
      isNative: json['isNative'] as bool? ?? false,
    );

Map<String, dynamic> _$AccountBalanceModelToJson(
        _AccountBalanceModel instance) =>
    <String, dynamic>{
      'rootTokenContract': instance.rootTokenContract.toJson(),
      'fiatBalance': moneyFromStringJsonConverter.toJson(instance.fiatBalance),
      'tokenBalance':
          moneyFromStringJsonConverter.toJson(instance.tokenBalance),
      'isNative': instance.isNative,
    };
