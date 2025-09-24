import 'package:freezed_annotation/freezed_annotation.dart';

part 'gas_price_params.freezed.dart';
part 'gas_price_params.g.dart';

@immutable
@freezed
abstract class GasPriceParams with _$GasPriceParams {
  const factory GasPriceParams({
    /// Flat tag
    required String tag1,

    /// Ext tag
    required String tag2,

    /// The price of gas unit
    required BigInt gasPrice,

    /// The maximum amount of gas available for a compute phase of
    /// an ordinary transaction
    required BigInt gasLimit,

    /// The maximum amount of gas available for a compute phase of
    /// a special transaction
    required BigInt specialGasLimit,

    /// The maximum amount of gas available before `ACCEPT`
    required BigInt gasCredit,

    /// The maximum amount of gas units per block
    required BigInt blockGasLimit,

    /// Amount of debt (in tokens) after which the account will be frozen
    required BigInt freezeDueLimit,

    /// Amount of debt (in tokens) after which the contract will be deleted
    required BigInt deleteDueLimit,

    /// Size of the first portion of gas with different price
    required BigInt flatGasLimit,

    /// The gas price for the first portion determinted by flatGasLimit
    required BigInt flatGasPrice,
  }) = _GasPriceParams;

  factory GasPriceParams.fromJson(Map<String, dynamic> json) =>
      _$GasPriceParamsFromJson(json);
}
