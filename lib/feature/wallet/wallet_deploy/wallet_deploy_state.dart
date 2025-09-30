import 'package:app/data/models/custom_currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'wallet_deploy_state.freezed.dart';

@freezed
sealed class WalletDeployState with _$WalletDeployState {
  /// Page that displays standard wallet deploy
  const factory WalletDeployState.standard() = WalletDeployStateStandard;

  /// Page that displays multisig wallet deploy.
  /// [custodians] and [requireConfirmations] is just a cache from wm, and
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
    required SignInputAuthLedger ledgerAuthInput,
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

  const factory WalletDeployState.subscribeError(Object error) =
      WalletDeployStateSubscribeError;
}
