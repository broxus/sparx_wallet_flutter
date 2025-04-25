import 'package:app/app/router/routs/wallet/ton_wallet_send_route_data.dart';
import 'package:app/feature/wallet/ton_wallet_send/data/data.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_confirm_view.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows send funds from TonWalelt (native token).
class TonWalletSendWidget extends ElementaryWidget<TonWalletSendWidgetModel> {
  const TonWalletSendWidget({
    required this.data,
    Key? key,
    WidgetModelFactory wmFactory = defaultTonWalletSendWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final TonWalletSendRouteData data;

  @override
  Widget build(TonWalletSendWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.state,
      builder: (_, state) {
        if (state == null) return const SizedBox.shrink();

        final appBar = switch (state) {
          TonWalletSendStateSending() => null,
          TonWalletSendStateError() =>
            DefaultAppBar(titleText: LocaleKeys.confirmTransaction.tr()),
          TonWalletSendStateReady() => DefaultAppBar(
              onClosePressed: (context) => context.pop(),
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
                popOnComplete: data.popOnComplete,
              ),
            ),
          TonWalletSendStateReady() => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
              ),
              child: TonWalletSendConfirmView(
                recipient: data.destination,
                attachedAmount: data.attachedAmount,
                comment: data.comment,
                payload: data.payload,
                publicKey: data.publicKey,
                currency: wm.currency,
                account: wm.account,
                amount: wm.amount,
                fees: wm.fees,
                error: wm.error,
                txErrors: wm.txErrors,
                isLoading: wm.isLoading,
                onPasswordEntered: wm.onPasswordEntered,
              ),
            ),
        };

        return Scaffold(appBar: appBar, body: body);
      },
    );
  }
}
