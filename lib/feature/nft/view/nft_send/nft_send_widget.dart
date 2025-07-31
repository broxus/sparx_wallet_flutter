import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows send funds from TonWalelt (native token).
class NftSendWidget extends InjectedElementaryParametrizedWidget<
    NftSendWidgetModel, NftSendRouteData> {
  const NftSendWidget({
    required this.data,
    super.key,
  }) : super(
          wmFactoryParam: data,
        );

  final NftSendRouteData data;

  @override
  Widget build(NftSendWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.sendState,
      builder: (_, state) {
        if (state == null) return const SizedBox.shrink();

        final appBar = switch (state) {
          NftSendStateSending() => null,
          NftSendStateError() =>
            DefaultAppBar(titleText: LocaleKeys.confirmTransaction.tr()),
          NftSendStateReady() => DefaultAppBar(
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
                item: wm.itemState,
                collection: wm.collectionState,
                recipient: data.destination,
                attachedAmount: wm.attachedAmountState,
                publicKey: data.publicKey,
                currency: wm.currency,
                account: wm.account,
                amount: data.amount,
                fees: wm.feesState,
                error: wm.errorState,
                txErrors: wm.txErrorsState,
                isLoading: wm.loadingState,
                onPasswordEntered: wm.onPasswordEntered,
              ),
            ),
        };

        return Scaffold(appBar: appBar, body: body);
      },
    );
  }
}
