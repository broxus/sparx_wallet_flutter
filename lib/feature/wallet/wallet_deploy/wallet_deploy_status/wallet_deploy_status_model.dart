import 'package:app/feature/messenger/messenger.dart';
import 'package:app/feature/wallet/wallet_deploy/domain/wallet_deployment_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class WalletDeployStatusModel extends ElementaryModel {
  WalletDeployStatusModel(
    ErrorHandler errorHandler,
    this._walletDeploymentService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final WalletDeploymentService _walletDeploymentService;
  final MessengerService _messengerService;

  @override
  void dispose() {
    _walletDeploymentService.clearStoredMessage();
    super.dispose();
  }

  Future<Transaction> executeDeploy({
    required String messageHash,
    required Address address,
    required BigInt amount,
  }) => _walletDeploymentService.deploy(
    messageHash: messageHash,
    address: address,
    amount: amount,
  );

  void showMessage(Message message) => _messengerService.show(message);
}
