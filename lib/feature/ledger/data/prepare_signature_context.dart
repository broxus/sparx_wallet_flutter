import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'prepare_signature_context.freezed.dart';

@freezed
sealed class PrepareSignatureContext with _$PrepareSignatureContext {
  const factory PrepareSignatureContext.deploy({
    required final TonWallet wallet,
    required final String asset,
    required final int decimals,
  }) = PrepareSignatureContextDeploy;

  const factory PrepareSignatureContext.confirm({
    required final TonWallet wallet,
    required final String asset,
    required final int decimals,
  }) = PrepareSignatureContextConfirm;

  const factory PrepareSignatureContext.transfer({
    required final TonWallet wallet,
    required final String asset,
    required final int decimals,
    required final PublicKey custodian,
  }) = PrepareSignatureContextTransfer;
}
