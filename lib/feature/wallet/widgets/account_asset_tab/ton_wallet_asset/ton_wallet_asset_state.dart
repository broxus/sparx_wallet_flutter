part of 'ton_wallet_asset_cubit.dart';

@freezed
sealed class TonWalletAssetState with _$TonWalletAssetState {
  const factory TonWalletAssetState.data({
    required String tokenName,
    required String iconPath,
    Money? fiatBalance,
    Money? tokenBalance,
  }) = TonWalletAssetStateData;

  const factory TonWalletAssetState.subscribeError({
    required String tokenName,
    required String iconPath,
    required Object error,
    required bool isLoading,
  }) = TonWalletAssetStateSubscribeError;
}
