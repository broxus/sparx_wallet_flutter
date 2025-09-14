import 'package:app/data/models/custom_currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_wallet_transactions_state.freezed.dart';

@freezed
sealed class TokenWalletTransactionsState with _$TokenWalletTransactionsState {
  const factory TokenWalletTransactionsState.empty() =
      TokenWalletTransactionsStateEmpty;

  const factory TokenWalletTransactionsState.loading() =
      TokenWalletTransactionsStateLoading;

  const factory TokenWalletTransactionsState.transactions({
    required List<TokenWalletOrdinaryTransaction> transactions,
    required Currency tokenCurrency,
    required bool isLoading,
    required bool canLoadMore,
    required CustomCurrency? tokenCustomCurrency,
  }) = TokenWalletTransactionsStateTransactions;
}
