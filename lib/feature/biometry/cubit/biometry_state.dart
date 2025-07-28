part of 'biometry_cubit.dart';

@freezed
sealed class BiometryState with _$BiometryState {
  const factory BiometryState.init() = BiometryStateInit;

  /// Display page to ask biometry with fingerprint or face
  const factory BiometryState.ask({
    required bool isFaceBiometry,
  }) = BiometryStateAsk;

  /// Close screen
  const factory BiometryState.completed() = BiometryStateCompleted;
}
