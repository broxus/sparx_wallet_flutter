import 'package:app/feature/ledger/ledger.dart';
import 'package:app/generated/generated.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [VerifyLedgerWidget].
ModalRoute<void> showVerifyLedgerSheet(KeyAccount account) {
  return commonBottomSheetRoute(
    title: LocaleKeys.ledgerVerifyTitle.tr(),
    subtitle: LocaleKeys.ledgerVerifySubtitle.tr(),
    subtitleMargin: const EdgeInsets.only(
      left: DimensSize.d24,
      right: DimensSize.d24,
      bottom: DimensSize.d24,
    ),
    centerTitle: true,
    centerSubtitle: true,
    body: (_, controller) =>
        VerifyLedgerWidget(account: account, controller: controller),
  );
}

class VerifyLedgerWidget extends ElementaryWidget<VerifyLedgerWidgetModel> {
  const VerifyLedgerWidget({
    required this.account,
    required this.controller,
    Key? key,
    WidgetModelFactory wmFactory = defaultVerifyLedgerWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final KeyAccount account;
  final ScrollController controller;

  @override
  Widget build(VerifyLedgerWidgetModel wm) {
    final theme = wm.theme;
    final address = account.address.toRaw();

    return SingleChildScrollView(
      controller: controller,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: DimensSize.d24,
        children: [
          PrimaryCard(
            color: theme.colors.background2,
            borderRadius: BorderRadius.circular(DimensRadius.radius16),
            padding: const EdgeInsets.all(DimensSize.d24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(DimensSize.d12),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(DimensSize.d8),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(DimensSize.d16),
                      child: BarcodeWidget(
                        width: DimensSize.d124,
                        height: DimensSize.d124,
                        data: address,
                        barcode: Barcode.qrCode(),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: DimensSize.d20),
                Text(
                  LocaleKeys.addressWord.tr(),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                ),
                const SizedBox(height: DimensSize.d4),
                Text(address, style: theme.textStyles.labelXSmall),
                const SizedBox(height: DimensSize.d20),
                PrimaryButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.copyWord.tr(),
                  icon: LucideIcons.copy,
                  onPressed: wm.onCopy,
                ),
              ],
            ),
          ),
          StateNotifierBuilder(
            listenableState: wm.isVerifyingState,
            builder: (_, isVerifying) {
              if (isVerifying ?? false) {
                return _State(state: wm.interactionState);
              }

              return AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.verify.tr(),
                onPressed: wm.onVerify,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _State extends StatelessWidget {
  const _State({required this.state});

  final ListenableState<LedgerInteractionState> state;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Padding(
      padding: const EdgeInsets.only(bottom: DimensSize.d28),
      child: Center(
        child: StateNotifierBuilder(
          listenableState: state,
          builder: (_, state) {
            if (state == null) return const SizedBox.shrink();

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensSize.d8),
                color: switch (state) {
                  LedgerInteractionState.done =>
                    theme.colors.backgroundPositive,
                  LedgerInteractionState.cancelled =>
                    theme.colors.backgroundNegative,
                  _ => theme.colors.background3,
                },
              ),
              padding: const EdgeInsets.symmetric(
                vertical: DimensSize.d6,
                horizontal: DimensSize.d8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  switch (state) {
                    LedgerInteractionState.done => Icon(
                      LucideIcons.circleCheck,
                      color: theme.colors.contentPositive,
                      size: DimensSize.d16,
                    ),
                    LedgerInteractionState.cancelled => Icon(
                      LucideIcons.circleX,
                      color: theme.colors.contentNegative,
                      size: DimensSize.d16,
                    ),
                    _ => ProgressIndicatorWidget(
                      size: DimensSize.d16,
                      color: theme.colors.content4,
                    ),
                  },
                  const SizedBox(width: DimensSize.d6),
                  switch (state) {
                    LedgerInteractionState.connecting => Text(
                      LocaleKeys.ledgerStepConnectTitle.tr(),
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.content4,
                      ),
                    ),
                    LedgerInteractionState.initializing => Text(
                      LocaleKeys.ledgerStepAppTitle.tr(),
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.content4,
                      ),
                    ),
                    LedgerInteractionState.confirming => Text(
                      LocaleKeys.ledgerVerifyWaiting.tr(),
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.content4,
                      ),
                    ),
                    LedgerInteractionState.done => Text(
                      LocaleKeys.ledgerVerifyConfirmed.tr(),
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.contentPositive,
                      ),
                    ),
                    LedgerInteractionState.cancelled => Text(
                      LocaleKeys.ledgerVerifyCancelled.tr(),
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.contentNegative,
                      ),
                    ),
                  },
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
