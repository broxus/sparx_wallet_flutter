import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Page that allows user to stake his native token.
class StakingPageWidget
    extends
        InjectedElementaryParametrizedWidget<StakingPageWidgetModel, Address> {
  const StakingPageWidget({required Address accountAddress, super.key})
    : super(wmFactoryParam: accountAddress);

  @override
  Widget build(StakingPageWidgetModel wm) {
    final theme = wm.theme;

    return GestureDetector(
      onTap: wm.unfocus,
      child: Scaffold(
        appBar: const DefaultAppBar(),
        body: Stack(
          children: [
            Positioned.fill(
              bottom: DimensSizeV2.d90,
              child: _StakingViewWidget(wm: wm),
            ),
            Positioned(
              bottom: DimensSizeV2.d0,
              right: DimensSizeV2.d0,
              left: DimensSizeV2.d0,
              child: Container(
                padding: const EdgeInsets.all(DimensSizeV2.d16),
                color: theme.colors.background0,
                child: _ButtonWidget(wm: wm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StakingViewWidget extends StatelessWidget {
  const _StakingViewWidget({required this.wm});

  final StakingPageWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    final theme = wm.theme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d16,
        vertical: DimensSizeV2.d8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.simpleLiquidStaking.tr(),
            style: theme.textStyles.headingXLarge,
          ),
          const SizedBox(height: DimensSizeV2.d12),
          EntityStateNotifierBuilder(
            listenableEntityState: wm.infoState,
            loadingBuilder: (_, __) => const Center(
              child: Padding(
                padding: EdgeInsets.all(DimensSizeV2.d16),
                child: CommonCircularProgressIndicator(
                  size: CircularIndicatorSize.large,
                ),
              ),
            ),
            errorBuilder: (_, __, ___) => Center(
              child: Padding(
                padding: const EdgeInsets.all(DimensSizeV2.d16),
                child: Text(
                  LocaleKeys.stakingInitError.tr(),
                  style: theme.textStyles.paragraphMedium.copyWith(
                    color: theme.colors.negative,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            builder: (_, info) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: LocaleKeys.stakeEverReceiverStever.tr(
                          args: [
                            wm.currency.symbol,
                            info?.tokenWallet.currency.symbol ?? '',
                          ],
                        ),
                        style: theme.textStyles.paragraphMedium.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: DimensSizeV2.d4)),
                      TextSpan(
                        text: LocaleKeys.howItWorks.tr(),
                        style: theme.textStyles.paragraphMedium.copyWith(
                          color: theme.colors.primaryA,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = wm.showHowItWorksSheet,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DimensSizeV2.d24),
                StateNotifierBuilder(
                  listenableState: wm.dataState,
                  builder: (_, data) => StakingView(
                    info: info!,
                    data: data!,
                    receive: wm.receiveState,
                    requests: wm.requestsState,
                    inputController: wm.inputController,
                    onMaxAmount: wm.onMaxAmount,
                    onTabChanged: wm.onTabChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({required this.wm});

  final StakingPageWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return DoubleValueListenableBuilder(
      firstValue: wm.tabState,
      secondValue: wm.isLoadingState,
      builder: (_, tab, isLoading) => StateNotifierBuilder(
        listenableState: wm.validationState,
        builder: (_, validation) => _InnerButtonWidget(
          tab: tab,
          isLoading: isLoading,
          validation: validation,
          onSubmit: wm.onSubmit,
        ),
      ),
    );
  }
}

class _InnerButtonWidget extends StatelessWidget {
  const _InnerButtonWidget({
    required this.tab,
    required this.isLoading,
    required this.validation,
    required this.onSubmit,
  });

  final StakingTab tab;
  final bool isLoading;
  final ValidationState? validation;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final title = switch (tab) {
      StakingTab.stake => LocaleKeys.stakeWord.tr(),
      StakingTab.unstake => LocaleKeys.unstakeWord.tr(),
      _ => null,
    };

    if (title == null) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (validation?.message != null)
          Padding(
            padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
            child: PrimaryCard(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
              color: theme.colors.backgroundNegative,
              child: Text(
                validation!.message!,
                style: theme.textStyles.labelSmall.copyWith(
                  color: theme.colors.contentNegative,
                ),
              ),
            ),
          ),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: title,
          isLoading: isLoading,
          onPressed: (validation?.isValid ?? false) ? onSubmit : null,
        ),
      ],
    );
  }
}
