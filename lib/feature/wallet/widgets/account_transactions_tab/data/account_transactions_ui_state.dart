import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

part 'account_transactions_ui_state.freezed.dart';

@freezed
sealed class AccountTransactionsUiState with _$AccountTransactionsUiState {
  const factory AccountTransactionsUiState.loading() =
      AccountTransactionsUiLoading;

  const factory AccountTransactionsUiState.empty() = AccountTransactionsUiEmpty;

  const factory AccountTransactionsUiState.data({
    required List<AccountTransactionItem<Object>> transactions,
    required bool isLoading,
    required bool canLoadMore,
    required Fixed price,
  }) = AccountTransactionsUiData;
}
