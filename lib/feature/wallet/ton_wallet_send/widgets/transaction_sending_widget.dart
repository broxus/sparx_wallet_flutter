import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that allows display process of sending transaction to blockchain.
/// If [canClose] is true, then 'Okay' button will be visible and user will be
/// able to navigate to wallet root page.
class TransactionSendingWidget extends StatelessWidget {
  const TransactionSendingWidget({
    required this.canClose,
    required this.popOnComplete,
    this.routeData = const WalletRouteData(),
    this.isDeploying = false,
    this.onClose,
    super.key,
  });

  final bool canClose;
  final bool isDeploying;
  final bool popOnComplete;
  final VoidCallback? onClose;
  final CompassRouteData routeData;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRect(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: RiveWidgetBuilder(
                      fileLoader: FileLoader.fromAsset(
                        isDeploying
                            ? Assets.animations.deploy
                            : Assets.animations.rocket,
                        riveFactory: Factory.rive,
                      ),
                      builder: (context, state) => switch (state) {
                        RiveLoading() => const CircularProgressIndicator(),
                        RiveFailed() => const SizedBox(),
                        RiveLoaded() => RiveWidget(
                          controller: state.controller,
                          fit: Fit.cover,
                        ),
                      },
                    ),
                  ),
                ),
                Column(
                  spacing: DimensSizeV2.d32,
                  children: [
                    Text(
                      isDeploying
                          ? LocaleKeys.deploymentInProgress.tr()
                          : LocaleKeys.transactionIsSending.tr(),
                      style: theme.textStyles.headingLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (canClose)
          Padding(
            padding: const EdgeInsets.only(
              top: DimensSizeV2.d8,
              bottom: DimensSizeV2.d24,
            ),
            child: AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.okayWord.tr(),
              onPressed: () {
                onClose?.call();
                if (popOnComplete) {
                  context.compassBack(true);
                } else {
                  context.compassPointNamed(routeData);
                }
              },
            ),
          ),
      ],
    );
  }
}
