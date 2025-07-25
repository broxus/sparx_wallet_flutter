part of 'enter_password_cubit.dart';

@freezed
sealed class EnterPasswordState with _$EnterPasswordState {
  const factory EnterPasswordState.initial() = EnterPasswordStateInitial;

  /// User tries to auth via biometry
  /// If [isFace] is true, auth by face, else by fingerprint (or other, but
  /// we display finger icon)
  const factory EnterPasswordState.biometry({required bool isFace}) =
      EnterPasswordStateBiometry;

  /// User tries to auth via entering password
  const factory EnterPasswordState.password() = EnterPasswordStatePassword;

  /// User authorized via biometry or password
  /// if [fromBiometry] is true, then display biometry widget, else password.
  /// [isFaceBiometry] is used only for biometry widget.
  const factory EnterPasswordState.entered({
    required String password,
    required bool fromBiometry,
    required bool isFaceBiometry,
  }) = EnterPasswordStateEntered;
}
