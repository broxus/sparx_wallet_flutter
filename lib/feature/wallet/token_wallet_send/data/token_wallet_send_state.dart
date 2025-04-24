import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_wallet_send_state.freezed.dart';

@freezed
sealed class TokenWalletSendState with _$TokenWalletSendState {
  const factory TokenWalletSendState.error({
    required Object error,
  }) = TokenWalletSendStateError;

  const factory TokenWalletSendState.ready() = TokenWalletSendStateReady;

  const factory TokenWalletSendState.sending({
    required bool canClose,
  }) = TokenWalletSendStateSending;
}
