import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'confirm_multisig_transaction_state.freezed.dart';

@freezed
sealed class ConfirmMultisigTransactionState
    with _$ConfirmMultisigTransactionState {
  const factory ConfirmMultisigTransactionState.prepare() =
      ConfirmMultisigTransactionStatePrepare;

  const factory ConfirmMultisigTransactionState.error({required Object error}) =
      ConfirmMultisigTransactionStateError;

  const factory ConfirmMultisigTransactionState.ready({
    required PublicKey custodian,
  }) = ConfirmMultisigTransactionStateReady;

  const factory ConfirmMultisigTransactionState.sending({
    required bool canClose,
  }) = ConfirmMultisigTransactionStateSending;
}
