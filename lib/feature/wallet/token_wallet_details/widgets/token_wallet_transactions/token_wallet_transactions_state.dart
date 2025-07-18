// ignore_for_file: type=lint
part of 'token_wallet_transactions_cubit.dart';

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
