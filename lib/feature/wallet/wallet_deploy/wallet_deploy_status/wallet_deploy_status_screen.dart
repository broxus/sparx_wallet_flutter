import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/ton_wallet_send/widgets/transaction_sending_widget.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_wm.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletDeployStatusScreen
    extends
        InjectedElementaryParametrizedWidget<
          WalletDeployStatusWidgetModel,
          WalletDeployStatusRouteData
        > {
  const WalletDeployStatusScreen({
    required WalletDeployStatusRouteData routeData,
    super.key,
  }) : super(wmFactoryParam: routeData);

  @override
  Widget build(WalletDeployStatusWidgetModel wm) {
    return PopCapture(
      onPop: wm.navigateToWallet,
      child: const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(DimensSizeV2.d16),
          child: TransactionSendingWidget(
            canClose: true,
            popOnComplete: false,
            isDeploying: true,
          ),
        ),
      ),
    );
  }
}
