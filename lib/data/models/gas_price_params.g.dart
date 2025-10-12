// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_price_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GasPriceParams _$GasPriceParamsFromJson(Map<String, dynamic> json) =>
    _GasPriceParams(
      tag1: json['tag1'] as String,
      tag2: json['tag2'] as String,
      gasPrice: BigInt.parse(json['gasPrice'] as String),
      gasLimit: BigInt.parse(json['gasLimit'] as String),
      specialGasLimit: BigInt.parse(json['specialGasLimit'] as String),
      gasCredit: BigInt.parse(json['gasCredit'] as String),
      blockGasLimit: BigInt.parse(json['blockGasLimit'] as String),
      freezeDueLimit: BigInt.parse(json['freezeDueLimit'] as String),
      deleteDueLimit: BigInt.parse(json['deleteDueLimit'] as String),
      flatGasLimit: BigInt.parse(json['flatGasLimit'] as String),
      flatGasPrice: BigInt.parse(json['flatGasPrice'] as String),
    );

Map<String, dynamic> _$GasPriceParamsToJson(_GasPriceParams instance) =>
    <String, dynamic>{
      'tag1': instance.tag1,
      'tag2': instance.tag2,
      'gasPrice': instance.gasPrice.toString(),
      'gasLimit': instance.gasLimit.toString(),
      'specialGasLimit': instance.specialGasLimit.toString(),
      'gasCredit': instance.gasCredit.toString(),
      'blockGasLimit': instance.blockGasLimit.toString(),
      'freezeDueLimit': instance.freezeDueLimit.toString(),
      'deleteDueLimit': instance.deleteDueLimit.toString(),
      'flatGasLimit': instance.flatGasLimit.toString(),
      'flatGasPrice': instance.flatGasPrice.toString(),
    };
