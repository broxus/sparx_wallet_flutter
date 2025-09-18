import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/wallet_deploy_confirm_view.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/wallet_deploy_confirm_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/common/common.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class WalletDeployConfirmScreen extends InjectedElementaryParametrizedWidget<
    WalletDeployConfirmWidgetModel, WalletDeployConfirmRouteData> {
  const WalletDeployConfirmScreen({
    required WalletDeployConfirmRouteData deploymentData,
    super.key,
  }) : super(
          wmFactoryParam: deploymentData,
        );

  @override
  Widget build(WalletDeployConfirmWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.colors.background0,
      appBar: DefaultAppBar(
        titleText: LocaleKeys.confirmDeployment.tr(),
        backgroundColor: wm.colors.background0,
        onClosePressed: (context) => context.compassBack(),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: wm.isLoadingState,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return const Center(
              child: ProgressIndicatorWidget(size: DimensSizeV2.d16),
            );
          }

          return ValueListenableBuilder<String?>(
            valueListenable: wm.errorMessageState,
            builder: (context, errorMessage, _) {
              if (errorMessage != null) {
                return _ErrorState(
                  errorMessage: errorMessage,
                  onRetry: wm.onRetry,
                  colors: wm.colors,
                  textStyles: wm.textStyles,
                );
              }

              return MultiListenerRebuilder(
                listenableList: [
                  wm.accountState,
                  wm.balanceState,
                  wm.feeState,
                  wm.currencyState,
                  wm.deployTypeState,
                  wm.requireConfirmationsState,
                  wm.custodiansState,
                  wm.publicKeyState,
                ],
                builder: (_) {
                  final account = wm.accountState.value;
                  final balance = wm.balanceState.value;
                  final fee = wm.feeState.value;
                  final currency = wm.currencyState.value;
                  final deployType = wm.deployTypeState.value;
                  final requireConfirmations =
                      wm.requireConfirmationsState.value;
                  final custodians = wm.custodiansState.value;
                  final publicKey = wm.publicKeyState.value;

                  return WalletDeployConfirmView(
                    publicKey: publicKey,
                    balance: balance,
                    fee: fee,
                    custodians: deployType == WalletDeployType.standard
                        ? null
                        : custodians,
                    requireConfirmations:
                        deployType == WalletDeployType.standard
                            ? null
                            : requireConfirmations,
                    tonIconPath: wm.tonIconPath,
                    currency: Currencies()[wm.ticker],
                    customCurrency: currency,
                    account: account,
                    ledgerAuthInput: wm.ledgerAuthInput,
                    onConfirmed: wm.onConfirmDeploy,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.errorMessage,
    required this.onRetry,
    required this.colors,
    required this.textStyles,
  });

  final String errorMessage;
  final VoidCallback onRetry;
  final ColorsPaletteV2 colors;
  final TextStylesV2 textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimensSizeV2.d24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: DimensSizeV2.d64,
            color: colors.warning,
          ),
          const SizedBox(height: DimensSizeV2.d16),
          Text(
            LocaleKeys.errorOccurred.tr(),
            style: textStyles.headingMedium.copyWith(
              color: colors.content0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DimensSizeV2.d8),
          Text(
            errorMessage,
            style: textStyles.paragraphMedium.copyWith(
              color: colors.content1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DimensSizeV2.d24),
          PrimaryButton(
            buttonShape: ButtonShape.pill,
            onPressed: onRetry,
            title: LocaleKeys.tryAgain.tr(),
          ),
        ],
      ),
    );
  }
}
