import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/ton_wallet_send/widgets/transaction_sending_widget.dart';
import 'package:app/feature/wallet/wallet_deploy/view/wallet_deploy_confirm_view.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_state.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_wm.dart';
import 'package:app/feature/wallet/wallet_deploy/widgets/wallet_deploy_multisig_body.dart';
import 'package:app/feature/wallet/wallet_deploy/widgets/wallet_deploy_standard_body.dart';
import 'package:app/feature/wallet/widgets/wallet_subscribe_error_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletDeployScreen extends InjectedElementaryParametrizedWidget<
    WalletDeployWidgetModel, WalletDeployParams> {
  WalletDeployScreen({
    required Address address,
    required PublicKey publicKey,
    super.key,
  }) : super(
          wmFactoryParam: WalletDeployParams(
            address: address,
            publicKey: publicKey,
          ),
        );

  @override
  Widget build(WalletDeployWidgetModel wm) {
    return StateNotifierBuilder<WalletDeployState>(
      listenableState: wm.state,
      builder: (context, state) {
        return switch (state!) {
          WalletDeployStateSubscribeError(:final error) => _Body(
              child: WalletSubscribeErrorWidget(error: error),
            ),
          WalletDeployStateStandard() => _Body(
              child: WalletDeployStandardBody(
                onDeploy: wm.handlePrepareStandard,
                onChangeType: wm.changeDeployType,
              ),
            ),
          WalletDeployStateMultisig(
            :final custodians,
            :final requireConfirmations,
            :final hours,
            :final walletType,
          ) =>
            _Body(
              child: WalletDeployMultisigBody(
                custodians: custodians,
                requireConfirmations: requireConfirmations,
                hours: hours,
                walletType: walletType,
                onUpdateMultisigData: wm.updateMultisigData,
                onChangeType: wm.changeDeployType,
                onDeploy: wm.handlePrepareMultisig,
              ),
            ),
          WalletDeployStateCalculatingError(
            :final error,
            :final balance,
            :final fee,
            :final custodians,
            :final requireConfirmations,
            :final tonIconPath,
            :final ticker,
            :final currency,
          ) =>
            _Body(
              onPrev: wm.goPrevStep,
              child: WalletDeployConfirmView(
                publicKey: wm.publicKeyState,
                balance: balance,
                feeError: error,
                fee: fee,
                custodians: custodians,
                requireConfirmations: requireConfirmations,
                tonIconPath: tonIconPath,
                currency: Currencies()[ticker ?? ''],
                customCurrency: currency,
                onConfirmed: wm.confirmDeploy,
              ),
            ),
          WalletDeployStateReadyToDeploy(
            :final balance,
            :final fee,
            :final custodians,
            :final requireConfirmations,
            :final tonIconPath,
            :final ticker,
            :final currency,
            :final account,
            :final ledgerAuthInput,
          ) =>
            _Body(
              onPrev: wm.goPrevStep,
              child: WalletDeployConfirmView(
                publicKey: wm.publicKeyState,
                balance: balance,
                fee: fee,
                custodians: custodians,
                requireConfirmations: requireConfirmations,
                tonIconPath: tonIconPath,
                currency: Currencies()[ticker ?? ''],
                customCurrency: currency,
                account: account,
                ledgerAuthInput: ledgerAuthInput,
                onConfirmed: wm.confirmDeploy,
              ),
            ),
          WalletDeployStateDeploying(:final canClose) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(DimensSizeV2.d16),
                child: TransactionSendingWidget(
                  canClose: canClose,
                  popOnComplete: false,
                  isDeploying: true,
                ),
              ),
            ),
        };
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.child,
    this.onPrev,
  });

  final Widget child;
  final VoidCallback? onPrev;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colors.background0,
        appBar: DefaultAppBar(
          titleText: onPrev != null
              ? LocaleKeys.deployWallet.tr()
              : LocaleKeys.selectWalletType.tr(),
          onClosePressed: onPrev != null ? (_) => onPrev!() : null,
        ),
        body: child,
      ),
    );
  }
}
