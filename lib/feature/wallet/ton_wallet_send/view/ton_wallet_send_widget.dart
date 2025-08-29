import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/ton_wallet_send/data/data.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_confirm_view.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows send funds from TonWalelt (native token).
class TonWalletSendWidget extends InjectedElementaryParametrizedWidget<
    TonWalletSendWidgetModel, TonWalletSendRouteData> {
  const TonWalletSendWidget({
    required TonWalletSendRouteData data,
    super.key,
  }) : super(wmFactoryParam: data);

  @override
  Widget build(TonWalletSendWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.sendState,
      builder: (_, state) {
        if (state == null) return const SizedBox.shrink();

        final appBar = switch (state) {
          TonWalletSendStateSending() => null,
          TonWalletSendStateError() =>
            DefaultAppBar(titleText: LocaleKeys.confirmTransaction.tr()),
          TonWalletSendStateReady() => DefaultAppBar(
              titleText: LocaleKeys.confirmTransaction.tr(),
            ),
        };

        final body = switch (state) {
          TonWalletSendStateError(:final error) =>
            Center(child: WalletSubscribeErrorWidget(error: error)),
          TonWalletSendStateSending(:final canClose) => Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              child: TransactionSendingWidget(
                canClose: canClose,
                popOnComplete: wm.popOnComplete,
              ),
            ),
          TonWalletSendStateReady() => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
              ),
              child: TonWalletSendConfirmView(
                recipient: wm.destination,
                attachedAmount: wm.attachedAmount,
                comment: wm.comment,
                payload: wm.payload,
                publicKey: wm.publicKey,
                currency: wm.currency,
                account: wm.account,
                amount: wm.amount,
                fees: wm.feesState,
                error: wm.errorState,
                txErrors: wm.txErrorsState,
                isLoading: wm.isLoadingState,
                getLedgerAuthInput: wm.getLedgerAuthInput,
                onConfirmed: wm.onConfirmed,
              ),
            ),
        };

        return Scaffold(appBar: appBar, body: body);
      },
    );
  }
}
