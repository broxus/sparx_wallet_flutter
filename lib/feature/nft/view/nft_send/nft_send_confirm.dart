import 'package:app/core/wm/not_null_safe_notifier.dart';
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
    required this.itemState,
    required this.collectionState,
    required this.recipient,
    required this.amount,
    required this.publicKey,
    required this.currency,
    required this.feesState,
    required this.errorState,
    required this.txErrorsState,
    required this.loadingState,
    required this.onConfirmed,
    required this.attachedAmount,
    required this.account,
    required this.getLedgerAuthInput,
    super.key,
  });

  final Address recipient;
  final BigInt? amount;
  final Currency currency;
  final PublicKey publicKey;
  final KeyAccount? account;
  final ListenableState<NftItem> itemState;
  final ListenableState<NftCollection> collectionState;
  final ListenableState<BigInt> attachedAmount;
  final ListenableState<bool> loadingState;
  final ListenableState<String> errorState;
  final ListenableState<BigInt> feesState;
  final ListenableState<List<TxTreeSimulationErrorItem>> txErrorsState;
  final GetLedgerAuthInput getLedgerAuthInput;
  final ValueChanged<SignInputAuth> onConfirmed;

  @override
  State<NftSendConfirm> createState() => _NftSendConfirmState();
}

class _NftSendConfirmState extends State<NftSendConfirm> {
  final _confirmedState = NotNullNotifier<bool>(false);

  @override
  void dispose() {
    _confirmedState.dispose();
    super.dispose();
  }

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
                  itemState: widget.itemState,
                  collectionState: widget.collectionState,
                  recipient: widget.recipient,
                  amount: widget.amount,
                  attachedAmountState: widget.attachedAmount,
                  feesState: widget.feesState,
                  feeErrorState: widget.errorState,
                ),
              ],
            ),
          ),
        ),
        TripleSourceBuilder(
          firstSource: widget.txErrorsState,
          secondSource: widget.errorState,
          thirdSource: _confirmedState,
          builder: (_, txErrors, error, isConfirmed) {
            isConfirmed ??= false;
            return Column(
              spacing: DimensSizeV2.d8,
              children: [
                if (txErrors != null && txErrors.isNotEmpty)
                  TxTreeSimulationErrorWidget(
                    txErrors: txErrors,
                    symbol: widget.currency.symbol,
                    isConfirmed: isConfirmed,
                    onConfirm: (value) => setState(() => isConfirmed = value),
                  ),
                StateNotifierBuilder(
                  listenableState: widget.loadingState,
                  builder: (_, isLoading) {
                    return EnterPasswordWidget.auth(
                      getLedgerAuthInput: widget.getLedgerAuthInput,
                      publicKey: widget.publicKey,
                      title: LocaleKeys.confirm.tr(),
                      isLoading: isLoading ?? false,
                      isDisabled:
                          error != null ||
                          ((txErrors?.isNotEmpty ?? false) && !isConfirmed!),
                      onConfirmed: widget.onConfirmed,
                    );
                  },
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
