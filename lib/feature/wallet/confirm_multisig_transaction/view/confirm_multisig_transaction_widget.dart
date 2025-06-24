import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/data/data.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_confirm.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_prepare.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows confirm multisig transaction for [TonWallet].
/// This pages displays only for outgoing transaction.
class ConfirmMultisigTransactionWidget
    extends InjectedElementaryWidget<ConfirmMultisigTransactionWidgetModel> {
  ConfirmMultisigTransactionWidget({
    /// Address of wallet which will be used to confirm transaction
    required Address walletAddress,

    /// Local custodians that CAN CONFIRM transaction (not all local)
    required List<PublicKey> localCustodians,

    /// Transaction that should be confirmed
    required String transactionId,
    required String? transactionIdHash,

    /// Amount of transaction
    required BigInt amount,

    /// Destination where funds should be sent (this page won't displayed for
    /// incoming transaction)
    required Address destination,

    /// Comment of transaction
    String? comment,
    super.key,
  }) : super(
          wmFactoryParam: ConfirmMultisigTransactionWmParams(
            walletAddress: walletAddress,
            localCustodians: localCustodians,
            transactionId: transactionId,
            amount: amount,
            destination: destination,
            comment: comment,
            transactionIdHash: transactionIdHash,
          ),
        );

  @override
  Widget build(ConfirmMultisigTransactionWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.state,
      builder: (_, state) {
        if (state == null) return const SizedBox.shrink();

        final appBar = switch (state) {
          ConfirmMultisigTransactionStateSending() => null,
          _ => DefaultAppBar(titleText: LocaleKeys.confirmTransaction.tr()),
        };

        final body = switch (state) {
          ConfirmMultisigTransactionStatePrepare() =>
            TonWalletConfirmTransactionPrepare(
              localCustodians: wm.localCustodians,
              custodianNames: wm.custodianNames,
              onCustodianSelected: wm.onCustodianSelected,
            ),
          ConfirmMultisigTransactionStateError(:final error) =>
            Center(child: WalletSubscribeErrorWidget(error: error)),
          ConfirmMultisigTransactionStateSending(:final canClose) => Padding(
              padding: const EdgeInsets.all(DimensSize.d16),
              child: TransactionSendingWidget(
                canClose: canClose,
                popOnComplete: false,
              ),
            ),
          ConfirmMultisigTransactionStateReady(:final custodian) =>
            TonWalletConfirmTransactionConfirmView(
              transactionIdHash: wm.transactionIdHash,
              recipient: wm.destination,
              comment: wm.comment,
              publicKey: custodian,
              account: wm.account,
              amount: wm.amount,
              currency: wm.currency,
              fees: wm.fees,
              error: wm.error,
              txErrors: wm.txErrors,
              isLoading: wm.isLoading,
              onPasswordEntered: wm.onPasswordEntered,
            ),
        };

        return Scaffold(appBar: appBar, body: body);
      },
    );
  }
}
