part of 'token_wallet_asset_cubit.dart';

@freezed
sealed class TokenWalletAssetState with _$TokenWalletAssetState {
  const factory TokenWalletAssetState.data({
    Money? fiatBalance,
    Money? tokenBalance,
  }) = TokenWalletAssetStateData;

  const factory TokenWalletAssetState.subscribeError({
    required Object error,
    required bool isLoading,
  }) = TokenWalletAssetStateSubscribeError;
}
