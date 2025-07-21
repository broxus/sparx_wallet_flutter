import 'package:app/app/router/router.dart';
import 'package:app/feature/wallet/token_wallet_send/data/data.dart';
import 'package:app/feature/wallet/token_wallet_send/view/token_wallet_send_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows to send not native token from [TokenWallet] to
/// [destination].
/// For correct work subscription for [TokenWallet] and [TonWallet] with
/// address=[owner] must be created.
class TokenWalletSendWidget
    extends ElementaryWidget<TokenWalletSendWidgetModel> {
  const TokenWalletSendWidget({
    required this.owner,
    required this.rootTokenContract,
    required this.publicKey,
    required this.destination,
    required this.amount,
    required this.attachedAmount,
    required this.comment,
    required this.resultMessage,
    required this.notifyReceiver,
    Key? key,
    WidgetModelFactory wmFactory = defaultTokenWalletSendWidgetModelFactory,
  }) : super(wmFactory, key: key);

  /// Address of account for token.
  final Address owner;

  /// Address of contract for token
  final Address rootTokenContract;

  /// Local custodian of account, that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where tokens must be sent
  final Address destination;

  /// How many tokens must be sent, to convert Fixed to BigInt, use
  /// [Fixed.minorUnits].
  final BigInt amount;

  /// Attached amount in native tokens, that should be added to transaction.
  /// If null, then default value will be used.
  final BigInt? attachedAmount;

  /// Comment for transaction
  final String? comment;

  /// Message that will be shown when transaction completed
  final String? resultMessage;

  final bool? notifyReceiver;

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
              onClosePressed: (context) => context.compassBack(),
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
                recipient: destination,
                rootTokenContract: rootTokenContract,
                comment: comment,
                publicKey: publicKey,
                attachedAmount: wm.attachedAmount,
                currency: wm.currency,
                account: wm.account,
                amount: wm.amount,
                fees: wm.fees,
                error: wm.error,
                txErrors: wm.txErrors,
                isLoading: wm.isLoading,
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
