import 'package:app/app/router/router.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that allows display process of sending transaction to blockchain.
/// If [canClose] is true, then 'Okay' button will be visible and user will be
/// able to navigate to wallet root page.
class TransactionSendingWidget extends StatelessWidget {
  const TransactionSendingWidget({
    required this.canClose,
    this.completeCloseCallback,
    this.isDeploying = false,
    super.key,
  });

  final bool canClose;
  final bool isDeploying;

  /// Callback that could be used to change default behavior for closing
  /// this screen when user achieved last step of sending when transaction is
  /// ready.
  final ValueChanged<BuildContext>? completeCloseCallback;

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
                if (isDeploying)
                  Assets.images.deploymentProgress.image()
                else
                  ClipRect(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: RiveAnimation.asset(
                        Assets.animations.rocket,
                        fit: BoxFit.cover,
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
                    if (isDeploying)
                      const ProgressIndicatorWidget(size: DimensSizeV2.d32),
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
                if (completeCloseCallback != null) {
                  completeCloseCallback!(context);
                } else {
                  context.goNamed(AppRoute.wallet.name);
                }
              },
            ),
          ),
      ],
    );
  }
}
