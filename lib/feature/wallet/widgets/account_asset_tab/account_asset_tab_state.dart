part of 'account_asset_tab_cubit.dart';

@freezed
sealed class AccountAssetTabState with _$AccountAssetTabState {
  /// No account found for selected address
  const factory AccountAssetTabState.empty() = AccountAssetTabStateEmpty;

  /// This state will produce new additionalAssets with account when it will
  /// change
  const factory AccountAssetTabState.accounts(
    TonWalletAsset tonWallet,
    List<TokenContractAsset>? tokens,
    int? numberNewTokens,
  ) = AccountAssetTabStateAccounts;
}
