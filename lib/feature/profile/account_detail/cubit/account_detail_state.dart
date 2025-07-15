part of 'account_detail_cubit.dart';

@freezed
sealed class AccountDetailState with _$AccountDetailState {
  const factory AccountDetailState.initial() = AccountDetailStateInitial;

  const factory AccountDetailState.empty() = AccountDetailStateEmpty;

  const factory AccountDetailState.data(
    KeyAccount account,
    Money balance,
    List<SeedKey> custodians,
  ) = AccountDetailStateData;
}
