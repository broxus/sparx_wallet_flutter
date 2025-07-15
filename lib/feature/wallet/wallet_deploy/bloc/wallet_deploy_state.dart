part of 'wallet_deploy_bloc.dart';

@freezed
sealed class WalletDeployState with _$WalletDeployState {
  /// Page that displays standard wallet deploy
  const factory WalletDeployState.standard() = WalletDeployStateStandard;

  /// Page that displays multisig wallet deploy.
  /// [custodians] and [requireConfirmations] is just a cache from bloc, and
  /// its data validated only in UI.
  const factory WalletDeployState.multisig(
    List<PublicKey> custodians,
    int requireConfirmations,
    int hours,
    WalletType walletType,
  ) = WalletDeployStateMultisig;

  /// Error during calculating fee process
  const factory WalletDeployState.calculatingError({
    required String error,
    BigInt? fee,
    BigInt? balance,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    String? tonIconPath,
    String? ticker,
    CustomCurrency? currency,
  }) = WalletDeployStateCalculatingError;

  /// Fee calculated, allow user subscribe transaction
  const factory WalletDeployState.readyToDeploy({
    required BigInt fee,
    required BigInt balance,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    String? tonIconPath,
    String? ticker,
    CustomCurrency? currency,
    KeyAccount? account,
    int? hours,
  }) = WalletDeployStateReadyToDeploy;

  const factory WalletDeployState.deploying({
    required bool canClose,
  }) = WalletDeployStateDeploying;

  /// Transaction sent successfully
  const factory WalletDeployState.deployed({
    required BigInt fee,
    required BigInt balance,
    required Transaction transaction,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    String? tonIconPath,
  }) = WalletDeployStateDeployed;

  const factory WalletDeployState.subscribeError(Object error) =
      WalletDeployStateSubscribeError;
}
