import 'package:app/app/router/router.dart';
import 'package:app/app/router/routs/wallet/ton_wallet_send_route_data.dart';
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
    required this.data,
    super.key,
  });

  final TonWalletSendRouteData data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TonWalletSendBloc>(
      create: (_) => TonWalletSendBloc(
        context: context,
        destination: data.destination,
        amount: data.amount + (data.attachedAmount ?? BigInt.zero),
        address: data.address,
        comment: data.comment,
        payload: data.payload,
        publicKey: data.publicKey,
        nekotonRepository: inject(),
        messengerService: inject(),
        resultMessage:
            data.resultMessage ?? LocaleKeys.transactionSentSuccessfully.tr(),
      )..add(const TonWalletSendEvent.prepare()),
      child: BlocConsumer<TonWalletSendBloc, TonWalletSendState>(
        listener: (context, state) {
          state.whenOrNull(
            sent: (_, __) {
              if (data.popOnComplete) {
                context.pop(true);
              } else {
                context.goNamed(AppRoute.wallet.name);
              }
            },
          );
        },
        builder: (context, state) {
          return state.when(
            subscribeError: _SubscribeErrorPage.new,
            loading: () => _ConfirmPage(data: data),
            calculatingError: (error, fee) => _ConfirmPage(
              data: data,
              fee: fee,
              error: error,
            ),
            readyToSend: (fee, txErrors) => _ConfirmPage(
              data: data,
              fee: fee,
              txErrors: txErrors,
            ),
            sending: (canClose) => _SendingPage(
              canClose: canClose,
              popOnComplete: data.popOnComplete,
            ),
            sent: (fee, _) => _SendingPage(
              canClose: true,
              popOnComplete: data.popOnComplete,
            ),
          );
        },
      ),
    );
  }
}

class _ConfirmPage extends StatelessWidget {
  const _ConfirmPage({
    required this.data,
    this.fee,
    this.error,
    this.txErrors,
  });

  final BigInt? fee;
  final String? error;
  final List<TxTreeSimulationErrorItem>? txErrors;
  final TonWalletSendRouteData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        onClosePressed: (context) => context.pop(),
        titleText: LocaleKeys.confirmTransaction.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d16,
        ),
        child: TonWalletSendConfirmView(
          recipient: data.destination,
          amount: data.amount,
          attachedAmount: data.attachedAmount,
          comment: data.comment,
          payload: data.payload,
          publicKey: data.publicKey,
          fee: fee,
          feeError: error,
          txErrors: txErrors,
        ),
      ),
    );
  }
}

class _SubscribeErrorPage extends StatelessWidget {
  const _SubscribeErrorPage(this.error);

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.confirmTransaction.tr(),
      ),
      body: Center(child: WalletSubscribeErrorWidget(error: error)),
    );
  }
}

class _SendingPage extends StatelessWidget {
  const _SendingPage({
    required this.canClose,
    required this.popOnComplete,
  });

  final bool canClose;
  final bool popOnComplete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimensSizeV2.d16,
        ),
        child: TransactionSendingWidget(
          canClose: canClose,
          popOnComplete: popOnComplete,
        ),
      ),
    );
  }
}
