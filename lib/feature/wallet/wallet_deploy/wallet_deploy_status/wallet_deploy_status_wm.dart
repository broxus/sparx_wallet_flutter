import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_model.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_screen.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class WalletDeployStatusWidgetModel extends CustomWidgetModelParametrized<
    WalletDeployStatusScreen,
    WalletDeployStatusModel,
    WalletDeployStatusRouteData> {
  WalletDeployStatusWidgetModel(super.model);

  final _logger = Logger('WalletDeployStatusWidgetModel');

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _initializeAndDeploy();
  }

  Future<void> _initializeAndDeploy() async {
    try {
      final routeData = wmParams.value;
      final minDelay = Future<void>.delayed(const Duration(seconds: 2));

      await model.executeDeploy(
        messageHash: routeData.messageHash,
        address: routeData.address,
        amount: routeData.amount,
      );

      model.showMessage(
        Message.successful(
          message: LocaleKeys.walletDeployedSuccessfully.tr(),
        ),
      );

      await minDelay;
      navigateToWallet();
    } catch (e, s) {
      _logger.severe('Error during deployment', e, s);
      model.showMessage(Message.error(message: e.toString()));
    }
  }

  void navigateToWallet() => contextSafe?.compassPoint(const WalletRouteData());
}
