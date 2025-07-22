import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/token_wallet_send/data/data.dart';
import 'package:app/feature/wallet/token_wallet_send/view/token_wallet_send_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows to send not native token from TokenWallet to
/// destination address.
/// For correct work subscription for TokenWallet and TonWallet with
/// the specified owner address must be created.
class TokenWalletSendWidget extends InjectedElementaryParametrizedWidget<
    TokenWalletSendWidgetModel, TokenWalletSendWmParams> {
  TokenWalletSendWidget({
    required Address owner,
    required Address rootTokenContract,
    required PublicKey publicKey,
    required Address destination,
    required BigInt amount,
    required BigInt? attachedAmount,
    required String? comment,
    required String? resultMessage,
    required bool? notifyReceiver,
    super.key,
  }) : super(
          wmFactoryParam: TokenWalletSendWmParams(
            owner: owner,
            rootTokenContract: rootTokenContract,
            publicKey: publicKey,
            destination: destination,
            amount: amount,
            attachedAmount: attachedAmount,
            comment: comment,
            resultMessage: resultMessage,
            notifyReceiver: notifyReceiver,
          ),
        );

  @override
  Widget build(TokenWalletSendWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.state,
      builder: (_, state) {
        if (state == null) return const SizedBox.shrink();

        final appBar = switch (state) {
          TokenWalletSendStateSending() => null,
          TokenWalletSendStateError() =>
            DefaultAppBar(titleText: LocaleKeys.confirmTransaction.tr()),
          TokenWalletSendStateReady() => DefaultAppBar(
              titleText: LocaleKeys.confirmTransaction.tr(),
            ),
        };

        final body = switch (state) {
          TokenWalletSendStateError(:final error) =>
            Center(child: WalletSubscribeErrorWidget(error: error)),
          TokenWalletSendStateSending(:final canClose) => Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              child: TransactionSendingWidget(
                canClose: canClose,
                popOnComplete: false,
              ),
            ),
          TokenWalletSendStateReady() => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
              ),
              child: TokenWalletSendConfirmView(
                recipient: wm.destination,
                rootTokenContract: wm.rootTokenContract,
                comment: wm.comment,
                publicKey: wm.publicKey,
                attachedAmount: wm.attachedAmount,
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
