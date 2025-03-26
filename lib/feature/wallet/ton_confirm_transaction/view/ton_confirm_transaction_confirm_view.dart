import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/ton_confirm_transaction/bloc/bloc.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    this.transactionIdHash,
    this.account,
    this.money,
    this.fee,
    this.feeError,
    this.txErrors,
    super.key,
  });

  final KeyAccount? account;
  final Money? money;
  final Address recipient;
  final BigInt amount;
  final BigInt? fee;
  final String? comment;
  final String? transactionIdHash;
  final String? feeError;
  final PublicKey publicKey;
  final List<TxTreeSimulationErrorItem>? txErrors;

  @override
  State<TonWalletConfirmTransactionConfirmView> createState() =>
      _TonWalletConfirmTransactionConfirmViewState();
}

class _TonWalletConfirmTransactionConfirmViewState
    extends State<TonWalletConfirmTransactionConfirmView> {
  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TonConfirmTransactionBloc>();
    final isLoading = widget.fee == null && widget.feeError == null;
    final hasTxError = widget.txErrors?.isNotEmpty ?? false;

    return AdaptiveFooterSingleChildScrollView(
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: DimensSizeV2.d8,
              left: DimensSizeV2.d16,
              right: DimensSizeV2.d16,
            ),
            child: SeparatedColumn(
              children: [
                if (hasTxError)
                  TxTreeSimulationErrorWidget(
                    txErrors: widget.txErrors!,
                    symbol: bloc.currency.symbol,
                    isConfirmed: isConfirmed,
                    onConfirm: (value) => setState(() => isConfirmed = value),
                  ),
                EnterPasswordWidgetV2(
                  publicKey: widget.publicKey,
                  title: LocaleKeys.confirm.tr(),
                  isLoading: isLoading,
                  isDisabled: widget.feeError != null ||
                      widget.fee == null ||
                      (hasTxError && !isConfirmed),
                  onPasswordEntered: (value) {
                    Navigator.of(context).pop();
                    bloc.add(TonConfirmTransactionEvent.send(value));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: DimensSize.d16),
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
            TokenTransferInfoWidget(
              margin: const EdgeInsets.only(
                left: DimensSizeV2.d16,
                right: DimensSizeV2.d16,
              ),
              amount: widget.money,
              recipient: widget.recipient,
              fee: widget.fee,
              feeError: widget.feeError,
              comment: widget.comment,
              transactionIdHash: widget.transactionIdHash,
            ),
          ],
        ),
      ),
    );
  }
}
