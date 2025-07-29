part of 'add_new_local_account_type_cubit.dart';

@freezed
sealed class AddNewLocalAccountTypeState with _$AddNewLocalAccountTypeState {
  const factory AddNewLocalAccountTypeState.initial() =
      AddNewLocalAccountTypeStateInitial;

  const factory AddNewLocalAccountTypeState.data({
    required List<WalletType> availableAccounts,
    required WalletType defaultAccount,
    required List<WalletType> createdAccounts,
    required WalletType? currentSelected,
    required bool isCompleted,
  }) = AddNewLocalAccountTypeStateData;
}
