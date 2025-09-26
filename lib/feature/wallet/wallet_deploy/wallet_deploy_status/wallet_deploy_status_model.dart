import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/domain/wallet_deployment_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class WalletDeployStatusModel extends ElementaryModel {
  WalletDeployStatusModel(
    ErrorHandler errorHandler,
    this._walletDeploymentService,
  ) : super(errorHandler: errorHandler);

  final WalletDeploymentService _walletDeploymentService;

  Future<Transaction> executeDeploy({
    required Address address,
    required PublicKey publicKey,
    required WalletDeployType deployType,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    int? hours,
  }) {
    final signInputAuth = _walletDeploymentService.consumeTemporaryAuth();
    if (signInputAuth == null) {
      throw Exception('SignInputAuth not available or expired');
    }

    return _walletDeploymentService.deployWallet(
      address: address,
      publicKey: publicKey,
      deployType: deployType,
      signInputAuth: signInputAuth,
      custodians: custodians,
      requireConfirmations: requireConfirmations,
      hours: hours,
    );
  }

  void clearDeploymentData() {
    _walletDeploymentService.clearDeploymentData();
  }
}
