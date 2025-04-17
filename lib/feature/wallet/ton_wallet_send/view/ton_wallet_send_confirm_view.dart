import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// View that allows confirm send transaction by entering password
class TonWalletSendConfirmView extends StatefulWidget {
  const TonWalletSendConfirmView({
    required this.recipient,
    required this.amount,
    required this.publicKey,
    required this.currency,
    required this.fees,
    required this.error,
    required this.txErrors,
    required this.isLoading,
    required this.onPasswordEntered,
    this.comment,
    this.payload,
    this.attachedAmount,
    this.account,
    super.key,
  });

  final Address recipient;
  final Money amount;
  final Currency currency;
  final BigInt? attachedAmount;
  final String? comment;
  final String? payload;
  final PublicKey publicKey;
  final KeyAccount? account;
  final ListenableState<bool> isLoading;
  final ListenableState<String> error;
  final ListenableState<BigInt> fees;
  final ListenableState<List<TxTreeSimulationErrorItem>> txErrors;
  final void Function(String) onPasswordEntered;

  @override
  State<TonWalletSendConfirmView> createState() =>
      _TonWalletSendConfirmViewState();
}

class _TonWalletSendConfirmViewState extends State<TonWalletSendConfirmView> {
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
              separatorSize: DimensSize.d16,
              children: [
                if (widget.account != null)
                  AccountInfo(account: widget.account!),
                DoubleSourceBuilder(
                  firstSource: widget.fees,
                  secondSource: widget.error,
                  builder: (_, fees, error) => TokenTransferInfoWidget(
                    amount: widget.amount,
                    recipient: widget.recipient,
                    fee: fees,
                    feeError: error,
                    attachedAmount: widget.attachedAmount,
                    comment: widget.comment,
                    payload: widget.payload,
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
