part of 'select_new_asset_cubit.dart';

@freezed
sealed class SelectNewAssetState with _$SelectNewAssetState {
  /// Screen should be closed
  const factory SelectNewAssetState.completed() = SelectNewAssetStateCompleted;

  const factory SelectNewAssetState.data({
    required SelectNewAssetTabs tab,
    // loading blocks actions
    required bool isLoading,
    required bool showButton,
    KeyAccount? account,
    List<(TokenContractAsset, bool)>? contracts,
  }) = SelectNewAssetStateData;
}
