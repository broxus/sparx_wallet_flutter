part of 'ton_wallet_details_cubit.dart';

@freezed
sealed class TonWalletDetailsState with _$TonWalletDetailsState {
  const factory TonWalletDetailsState.initial() = TonWalletDetailsStateInitial;

  const factory TonWalletDetailsState.empty() = TonWalletDetailsStateEmpty;

  const factory TonWalletDetailsState.subscribeError({
    required String symbol,
    required KeyAccount account,
    required Object error,
    required bool isLoading,
  }) = TonWalletDetailsStateSubscribeError;

  const factory TonWalletDetailsState.data({
    required String symbol,
    required KeyAccount account,
    required Money tokenBalance,
    required Money fiatBalance,
  }) = TonWalletDetailsStateData;
}
