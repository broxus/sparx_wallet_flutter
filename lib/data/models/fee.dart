import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'fee.freezed.dart';

@freezed
sealed class Fee with _$Fee {
  const factory Fee.estimating() = FeeEstimating;

  const factory Fee.native(Money amount) = FeeNative;

  const factory Fee.token({
    required Money amount,
    required Address tokenRootAddress,
  }) = FeeToken;

  const Fee._();

  BigInt get minorUnits {
    return switch (this) {
      FeeEstimating() => BigInt.zero,
      FeeNative(:final amount) || FeeToken(:final amount) => amount.minorUnits,
    };
  }
}
