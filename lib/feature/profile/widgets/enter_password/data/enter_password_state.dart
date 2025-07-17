import 'package:freezed_annotation/freezed_annotation.dart';

part 'enter_password_state.freezed.dart';

@freezed
sealed class EnterPasswordState with _$EnterPasswordState {
  /// User tries to auth via biometry
  /// If [isFace] is true, auth by face, else by fingerprint (or other, but
  /// we display finger icon)
  const factory EnterPasswordState.biometry({required bool isFace}) =
      EnterPasswordStateBiometry;

  /// User tries to auth via entering password
  const factory EnterPasswordState.password() = EnterPasswordStatePassword;

  const factory EnterPasswordState.ledger() = EnterPasswordStateLedger;
}
