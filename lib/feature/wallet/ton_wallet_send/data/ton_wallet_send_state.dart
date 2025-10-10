import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_wallet_send_state.freezed.dart';

@freezed
sealed class TonWalletSendState with _$TonWalletSendState {
  const factory TonWalletSendState.error({required Object error}) =
      TonWalletSendStateError;

  const factory TonWalletSendState.ready() = TonWalletSendStateReady;

  const factory TonWalletSendState.sending({required bool canClose}) =
      TonWalletSendStateSending;
}
