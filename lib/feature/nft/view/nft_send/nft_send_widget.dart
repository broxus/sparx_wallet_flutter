import 'package:app/app/router/router.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows send funds from TonWalelt (native token).
class NftSendWidget extends ElementaryWidget<NftSendWidgetModel> {
  const NftSendWidget({
    required this.data,
    Key? key,
    WidgetModelFactory wmFactory = defaultNftSendWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final NftSendRouteData data;

  @override
  Widget build(NftSendWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.state,
      builder: (_, state) {
        if (state == null) return const SizedBox.shrink();

        final appBar = switch (state) {
          NftSendStateSending() => null,
          NftSendStateError() =>
            DefaultAppBar(titleText: LocaleKeys.confirmTransaction.tr()),
          NftSendStateReady() => DefaultAppBar(
              onClosePressed: (context) => context.compassBack(),
              titleText: LocaleKeys.confirmTransaction.tr(),
            ),
        };

        final body = switch (state) {
          NftSendStateError(:final error) =>
            Center(child: WalletSubscribeErrorWidget(error: error)),
          NftSendStateSending(:final canClose) => Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              child: TransactionSendingWidget(
                canClose: canClose,
                popOnComplete: false,
                routeData: const NftRouteData(),
              ),
            ),
          NftSendStateReady() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
              child: NftSendConfirm(
                item: wm.item,
                collection: wm.collection,
                recipient: data.destination,
                attachedAmount: wm.attachedAmount,
                publicKey: data.publicKey,
                currency: wm.currency,
                account: wm.account,
                amount: data.amount,
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
