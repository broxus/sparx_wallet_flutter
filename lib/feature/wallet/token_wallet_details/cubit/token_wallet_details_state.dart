part of 'token_wallet_details_cubit.dart';

@freezed
sealed class TokenWalletDetailsState with _$TokenWalletDetailsState {
  const factory TokenWalletDetailsState.initial() =
      TokenWalletDetailsStateInitial;

  const factory TokenWalletDetailsState.empty() = TokenWalletDetailsStateEmpty;

  const factory TokenWalletDetailsState.subscribeError({
    required String contractName,
    required Object error,
    required bool isLoading,
  }) = TokenWalletDetailsStateSubscribeError;

  const factory TokenWalletDetailsState.data({
    required String contractName,
    required Money tokenBalance,
    required Money fiatBalance,
    required bool canSend,
  }) = TokenWalletDetailsStateData;
}
