import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_model.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class WalletDeployStatusWidgetModel
    extends
        CustomWidgetModelParametrized<
          WalletDeployStatusScreen,
          WalletDeployStatusModel,
          WalletDeployStatusRouteData
        > {
  WalletDeployStatusWidgetModel(super.model);

  final _logger = Logger('WalletDeployStatusWidgetModel');

  late final ValueNotifier<bool> _isDeployingState = createValueNotifier(false);
  late final ValueNotifier<bool> _canCloseState = createValueNotifier(false);
  ValueListenable<bool> get canCloseState => _canCloseState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _initializeAndDeploy();
  }

  Future<void> _initializeAndDeploy() async {
    try {
      _isDeployingState.value = true;
      _canCloseState.value = false;

      final routeData = wmParams.value;
      final deployType = routeData.deployType;

      final custodians =
          routeData.custodians != null && routeData.custodians!.isNotEmpty
          ? routeData.custodians!
                .split(',')
                .map((e) => PublicKey(publicKey: e))
                .toList()
          : null;

      await model.executeDeploy(
        address: Address(address: routeData.address),
        publicKey: PublicKey(publicKey: routeData.publicKey),
        deployType: deployType,
        custodians: custodians,
        requireConfirmations: routeData.requireConfirmations,
        hours: routeData.hours,
      );

      _canCloseState.value = true;
      _isDeployingState.value = false;

      await Future<void>.delayed(const Duration(seconds: 2));
      navigateToWallet();
    } catch (e, s) {
      _isDeployingState.value = false;
      _canCloseState.value = true;
      _logger.severe('Error during deployment', e, s);
    }
  }

  Future<void> startDeployment() async {
    await _initializeAndDeploy();
  }

  void navigateToWallet() {
    model.clearDeploymentData();
    context.compassPoint(const WalletRouteData());
  }

  void onRetry() {
    startDeployment();
  }

  void onClose() {
    model.clearDeploymentData();
  }
}
