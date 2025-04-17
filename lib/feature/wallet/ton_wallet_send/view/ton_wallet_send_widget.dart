import 'package:app/feature/wallet/ton_wallet_send/data/data.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_confirm_view.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows send funds from TonWalelt (native token).
class TonWalletSendWidget extends ElementaryWidget<TonWalletSendWidgetModel> {
  const TonWalletSendWidget({
    required this.address,
    required this.publicKey,
    required this.destination,
    required this.amount,
    this.comment,
    this.payload,
    this.attachedAmount,
    this.resultMessage,
    this.completeCloseCallback,
    Key? key,
    WidgetModelFactory wmFactory = defaultTonWalletSendWidgetModelFactory,
  }) : super(wmFactory, key: key);

  /// Address of TonWallet that will be used to send funds
  final Address address;

  /// Custodian of [address] that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where funds should be sent
  final Address destination;

  /// Amount of tokens that should be sent, to convert Fixed to BigInt, use
  /// [Fixed.minorUnits].
  final BigInt amount;

  /// Ammount that will be just added to [amount]
  final BigInt? attachedAmount;

  /// Comment for transaction
  final String? comment;

  /// Transaction payload
  final String? payload;

  /// Message that will be shown when transaction sending completed
  final String? resultMessage;

  /// Callback that could be used to change default behavior for closing
  /// this screen when user achieved last step of sending when transaction is
  /// ready.
  final ValueChanged<BuildContext>? completeCloseCallback;

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
                completeCloseCallback: completeCloseCallback,
              ),
            ),
          TonWalletSendStateReady() => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
              ),
              child: TonWalletSendConfirmView(
                recipient: destination,
                attachedAmount: attachedAmount,
                comment: comment,
                payload: payload,
                publicKey: publicKey,
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
