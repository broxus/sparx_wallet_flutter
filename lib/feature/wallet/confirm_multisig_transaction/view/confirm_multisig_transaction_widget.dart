import 'package:app/feature/wallet/confirm_multisig_transaction/data/data.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_confirm.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_prepare.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows confirm multisig transaction for [TonWallet].
/// This pages displays only for outgoing transaction.
class ConfirmMultisigTransactionWidget
    extends ElementaryWidget<ConfirmMultisigTransactionWidgetModel> {
  const ConfirmMultisigTransactionWidget({
    required this.walletAddress,
    required this.localCustodians,
    required this.transactionId,
    required this.amount,
    required this.destination,
    required this.comment,
    this.transactionIdHash,
    Key? key,
    WidgetModelFactory wmFactory =
        defaultConfirmMultisigTransactionWidgetModelFactory,
  }) : super(wmFactory, key: key);

  /// Address of wallet which will be used to confirm transaction
  final Address walletAddress;

  /// Local custodians that CAN CONFIRM transaction (not all local)
  final List<PublicKey> localCustodians;

  /// Transaction that should be confirmed
  final String transactionId;

  final String? transactionIdHash;

  /// Amount of transaction
  final BigInt amount;

  /// Destination where funds should be sent (this page won't displayed for
  /// incoming transaction)
  final Address destination;

  /// Comment of transaction
  final String? comment;

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
              localCustodians: localCustodians,
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
              transactionIdHash: transactionIdHash,
              recipient: destination,
              comment: comment,
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
