import 'package:freezed_annotation/freezed_annotation.dart';

part 'nft_send_state.freezed.dart';

@freezed
sealed class NftSendState with _$NftSendState {
  const factory NftSendState.error({
    required Object error,
  }) = NftSendStateError;

  const factory NftSendState.ready() = NftSendStateReady;

  const factory NftSendState.sending({
    required bool canClose,
  }) = NftSendStateSending;
}
