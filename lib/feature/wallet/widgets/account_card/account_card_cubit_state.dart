part of 'account_card_cubit.dart';

@freezed
class AccountCardState with _$AccountCardState {
  const factory AccountCardState.data({
    required KeyAccount account,
    // name of WalletType
    required String walletName,
    Money? balance,
    String? custodiansString,
  }) = _Data;

  const factory AccountCardState.subscribeError({
    required KeyAccount account,
    // name of WalletType
    required String walletName,
    required Object error,
    required bool isLoading,
  }) = _SubscribeError;
}
