import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_confirm_view.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows send funds from TonWalelt (native token).
class TonWalletSendPage extends StatelessWidget {
  const TonWalletSendPage({
    required this.address,
    required this.publicKey,
    required this.destination,
    required this.amount,
    this.comment,
    this.payload,
    this.attachedAmount,
    this.resultMessage,
    this.completeCloseCallback,
    super.key,
  });

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
  Widget build(BuildContext context) {
    return BlocProvider<TonWalletSendBloc>(
      create: (_) => TonWalletSendBloc(
        context: context,
        destination: destination,
        amount: amount + (attachedAmount ?? BigInt.zero),
        address: address,
        comment: comment,
        payload: payload,
        publicKey: publicKey,
        nekotonRepository: inject(),
        messengerService: inject(),
        resultMessage:
            resultMessage ?? LocaleKeys.transactionSentSuccessfully.tr(),
      )..add(const TonWalletSendEvent.prepare()),
      child: BlocConsumer<TonWalletSendBloc, TonWalletSendState>(
        listener: (context, state) {
          state.whenOrNull(
            sent: (_, __) {
              if (completeCloseCallback != null) {
                completeCloseCallback!(context);
              } else {
                context.goNamed(AppRoute.wallet.name);
              }
            },
          );
        },
        builder: (context, state) {
          return state.when(
            subscribeError: (error) => Scaffold(
              appBar: DefaultAppBar(
                titleText: LocaleKeys.confirmTransaction.tr(),
              ),
              body: Center(child: WalletSubscribeErrorWidget(error: error)),
            ),
            loading: _confirmPage,
            calculatingError: (error, fee) =>
                _confirmPage(fee: fee, error: error),
            readyToSend: (fee, txErrors) =>
                _confirmPage(fee: fee, txErrors: txErrors),
            sending: _sendingPage,
            sent: (fee, _) => _sendingPage(true),
          );
        },
      ),
    );
  }

  Widget _confirmPage({
    BigInt? fee,
    String? error,
    List<TxTreeSimulationErrorItem>? txErrors,
  }) =>
      Scaffold(
        appBar: DefaultAppBar(
          onClosePressed: (context) => context.pop(),
          titleText: LocaleKeys.confirmTransaction.tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d16,
          ),
          child: TonWalletSendConfirmView(
            recipient: destination,
            amount: amount,
            attachedAmount: attachedAmount,
            comment: comment,
            payload: payload,
            publicKey: publicKey,
            fee: fee,
            feeError: error,
            txErrors: txErrors,
          ),
        ),
      );

  Widget _sendingPage(bool canClose) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(
            DimensSizeV2.d16,
          ),
          child: TransactionSendingWidget(
            canClose: canClose,
            completeCloseCallback: completeCloseCallback,
          ),
        ),
      );
}
