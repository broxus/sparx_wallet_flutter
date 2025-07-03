import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NftSendConfirm extends StatefulWidget {
  const NftSendConfirm({
    required this.item,
    required this.collection,
    required this.recipient,
    required this.amount,
    required this.publicKey,
    required this.currency,
    required this.fees,
    required this.error,
    required this.txErrors,
    required this.isLoading,
    required this.onPasswordEntered,
    required this.attachedAmount,
    required this.account,
    super.key,
  });

  final Address recipient;
  final BigInt? amount;
  final Currency currency;
  final PublicKey publicKey;
  final KeyAccount? account;
  final ListenableState<NftItem> item;
  final ListenableState<NftCollection> collection;
  final ListenableState<BigInt> attachedAmount;
  final ListenableState<bool> isLoading;
  final ListenableState<String> error;
  final ListenableState<BigInt> fees;
  final ListenableState<List<TxTreeSimulationErrorItem>> txErrors;
  final void Function(String) onPasswordEntered;

  @override
  State<NftSendConfirm> createState() => _NftSendConfirmState();
}

class _NftSendConfirmState extends State<NftSendConfirm> {
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
              spacing: DimensSize.d16,
              children: [
                if (widget.account != null)
                  AccountInfo(account: widget.account!),
                NftTransferInfoWidget(
                  item: widget.item,
                  collection: widget.collection,
                  recipient: widget.recipient,
                  amount: widget.amount,
                  attachedAmount: widget.attachedAmount,
                  fees: widget.fees,
                  feeError: widget.error,
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
        const SizedBox(height: DimensSize.d24),
      ],
    );
  }
}
