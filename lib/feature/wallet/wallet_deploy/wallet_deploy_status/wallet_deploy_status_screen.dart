import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/ton_wallet_send/widgets/transaction_sending_widget.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_wm.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletDeployStatusScreen extends InjectedElementaryParametrizedWidget<
    WalletDeployStatusWidgetModel, WalletDeployStatusRouteData> {
  const WalletDeployStatusScreen({
    required WalletDeployStatusRouteData routeData,
    super.key,
  }) : super(wmFactoryParam: routeData);

  @override
  Widget build(WalletDeployStatusWidgetModel wm) {
    return PopCapture(
      onPop: wm.navigateToWallet,
      child: Scaffold(
        body: ValueListenableBuilder<bool>(
          valueListenable: wm.canCloseState,
          builder: (context, canClose, _) {
            return TransactionSendingWidget(
              canClose: canClose,
              popOnComplete: false,
              isDeploying: true,
              onClose: wm.onClose,
            );
          },
        ),
      ),
    );
  }
}
