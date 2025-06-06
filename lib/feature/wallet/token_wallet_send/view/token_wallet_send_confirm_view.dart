import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// View that allows confirm send token transaction by entering password
class TokenWalletSendConfirmView extends StatefulWidget {
  const TokenWalletSendConfirmView({
    required this.recipient,
    required this.rootTokenContract,
    required this.amount,
    required this.currency,
    required this.comment,
    required this.publicKey,
    required this.account,
    required this.fees,
    required this.error,
    required this.txErrors,
    required this.isLoading,
    required this.attachedAmount,
    required this.onPasswordEntered,
    super.key,
  });

  final Address recipient;
  final Address rootTokenContract;
  final Currency currency;
  final String? comment;
  final PublicKey publicKey;
  final KeyAccount? account;
  final ListenableState<Money> amount;
  final ListenableState<BigInt> attachedAmount;
  final ListenableState<bool> isLoading;
  final ListenableState<String> error;
  final ListenableState<BigInt> fees;
  final ListenableState<List<TxTreeSimulationErrorItem>> txErrors;
  final void Function(String) onPasswordEntered;

  @override
  State<TokenWalletSendConfirmView> createState() =>
      _TokenWalletSendConfirmViewState();
}

class _TokenWalletSendConfirmViewState
    extends State<TokenWalletSendConfirmView> {
  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DimensSizeV2.d8,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SeparatedColumn(
              mainAxisSize: MainAxisSize.min,
              spacing: DimensSize.d16,
              children: [
                if (widget.account != null)
                  AccountInfo(account: widget.account!),
                MultiListenerRebuilder(
                  listenableList: [
                    widget.fees,
                    widget.error,
                    widget.attachedAmount,
                    widget.amount,
                  ],
                  builder: (_) => TokenTransferInfoWidget(
                    amount: widget.amount.value,
                    recipient: widget.recipient,
                    fee: widget.fees.value,
                    feeError: widget.error.value,
                    attachedAmount: widget.attachedAmount.value,
                    comment: widget.comment,
                    rootTokenContract: widget.rootTokenContract,
                  ),
                ),
              ],
            ),
          ),
        ),
        TripleSourceBuilder(
          firstSource: widget.isLoading,
          secondSource: widget.txErrors,
          thirdSource: widget.error,
          builder: (_, isLoading, txErrors, error) {
            return Column(
              spacing: DimensSizeV2.d8,
              children: [
                if (txErrors != null && txErrors.isNotEmpty)
                  TxTreeSimulationErrorWidget(
                    txErrors: txErrors,
                    symbol: widget.currency.symbol,
                    isConfirmed: isConfirmed,
                    onConfirm: (value) => setState(
                      () => isConfirmed = value,
                    ),
                  ),
                EnterPasswordWidgetV2(
                  publicKey: widget.publicKey,
                  title: LocaleKeys.confirm.tr(),
                  isLoading: isLoading,
                  isDisabled: error != null ||
                      ((txErrors?.isNotEmpty ?? false) && !isConfirmed),
                  onPasswordEntered: widget.onPasswordEntered,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: DimensSize.d16),
      ],
    );
  }
}
