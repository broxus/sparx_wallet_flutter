part of 'account_transactions_tab_cubit.dart';

@freezed
sealed class AccountTransactionsTabState with _$AccountTransactionsTabState {
  const factory AccountTransactionsTabState.empty() =
      AccountTransactionsTabStateEmpty;

  const factory AccountTransactionsTabState.loading() =
      AccountTransactionsTabStateLoading;

  /// isLoading means that user scrolled to the end of list
  const factory AccountTransactionsTabState.transactions({
    required List<AccountTransactionItem<Object>> transactions,
    required bool isLoading,
    required bool canLoadMore,
    required Fixed price,
  }) = AccountTransactionsTabStateTransactions;
}
