import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/adaptive_footer_single_child_scroll_view.dart';

/// View that allows confirm confirming transaction transaction by entering
/// password
class TonWalletConfirmTransactionConfirmView extends StatefulWidget {
  const TonWalletConfirmTransactionConfirmView({
    required this.recipient,
    required this.amount,
    required this.comment,
    required this.publicKey,
    required this.currency,
    required this.fees,
    required this.error,
    required this.txErrors,
    required this.isLoading,
    required this.getLedgerAuthInput,
    required this.onConfirmed,
    this.transactionIdHash,
    this.account,
    super.key,
  });

  final KeyAccount? account;
  final Address recipient;
  final Money amount;
  final PublicKey publicKey;
  final Currency currency;
  final String? comment;
  final String? transactionIdHash;
  final ListenableState<bool> isLoading;
  final ListenableState<String> error;
  final ListenableState<BigInt> fees;
  final ListenableState<List<TxTreeSimulationErrorItem>> txErrors;
  final GetLedgerAuthInput getLedgerAuthInput;
  final void Function(SignInputAuth) onConfirmed;

  @override
  State<TonWalletConfirmTransactionConfirmView> createState() =>
      _TonWalletConfirmTransactionConfirmViewState();
}

class _TonWalletConfirmTransactionConfirmViewState
    extends State<TonWalletConfirmTransactionConfirmView> {
  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return AdaptiveFooterSingleChildScrollView(
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: DimensSizeV2.d8,
              left: DimensSizeV2.d16,
              right: DimensSizeV2.d16,
              bottom: DimensSize.d16,
            ),
            child: TripleSourceBuilder(
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
                    EnterPasswordWidget.auth(
                      getLedgerAuthInput: widget.getLedgerAuthInput,
                      publicKey: widget.publicKey,
                      title: LocaleKeys.confirm.tr(),
                      isLoading: isLoading ?? false,
                      isDisabled: error != null ||
                          ((txErrors?.isNotEmpty ?? false) && !isConfirmed),
                      onConfirmed: widget.onConfirmed,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: DimensSizeV2.d12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.account != null)
              Padding(
                padding: const EdgeInsets.only(
                  left: DimensSizeV2.d16,
                  right: DimensSizeV2.d16,
                  bottom: DimensSizeV2.d16,
                ),
                child: AccountInfo(account: widget.account!),
              ),
            DoubleSourceBuilder(
              firstSource: widget.fees,
              secondSource: widget.error,
              builder: (_, fees, error) => TokenTransferInfoWidget(
                margin: const EdgeInsets.only(
                  left: DimensSizeV2.d16,
                  right: DimensSizeV2.d16,
                ),
                amount: widget.amount,
                recipient: widget.recipient,
                fee: fees,
                feeError: error,
                comment: widget.comment,
                transactionIdHash: widget.transactionIdHash,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
