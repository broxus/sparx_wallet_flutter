part of 'key_detail_cubit.dart';

@freezed
class KeyDetailState with _$KeyDetailState {
  const factory KeyDetailState.initial() = KeyDetailStateInitial;

  const factory KeyDetailState.empty() = KeyDetailStateEmpty;

  const factory KeyDetailState.data(
    SeedKey key,
    String ownerSeedName,
    KeyDetailAccountsTab accountsTab,
  ) = KeyDetailStateData;
}
