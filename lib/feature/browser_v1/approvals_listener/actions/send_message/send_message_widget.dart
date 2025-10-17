import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/send_message/send_message_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SendMessageWidget
    extends
        InjectedElementaryParametrizedWidget<
          SendMessageWidgetModel,
          SendMessageWmParams
        > {
  SendMessageWidget({
    required Uri origin,
    required Address sender,
    required Address recipient,
    required BigInt amount,
    required bool bounce,
    required FunctionCall? payload,
    required KnownPayload? knownPayload,
    required this.scrollController,
    List<IgnoreTransactionTreeSimulationError>? ignoredComputePhaseCodes,
    List<IgnoreTransactionTreeSimulationError>? ignoredActionPhaseCodes,
    super.key,
  }) : super(
         wmFactoryParam: SendMessageWmParams(
           origin: origin,
           sender: sender,
           recipient: recipient,
           amount: amount,
           bounce: bounce,
           payload: payload,
           knownPayload: knownPayload,
           ignoredComputePhaseCodes: ignoredComputePhaseCodes,
           ignoredActionPhaseCodes: ignoredActionPhaseCodes,
         ),
       );

  final ScrollController scrollController;

  @override
  Widget build(SendMessageWidgetModel wm) {
    final theme = wm.theme;

    return SeparatedColumn(
      spacing: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (wm.account != null)
                  StateNotifierBuilder(
                    listenableState: wm.balanceState,
                    builder: (_, balance) => AccountInfo(
                      account: wm.account!,
                      color: theme.colors.background2,
                      subtitle: balance?.let(
                        (value) => AmountWidget.fromMoney(
                          amount: value,
                          style: theme.textStyles.labelXSmall.copyWith(
                            color: theme.colors.content3,
                          ),
                          useDefaultFormat: false,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: DimensSizeV2.d12),
                ValueListenableBuilder(
                  valueListenable: wm.originState,
                  builder: (_, origin, __) {
                    return WebsiteInfoWidget(uri: origin);
                  },
                ),
                DoubleSourceBuilder(
                  firstSource: wm.publicKeyState,
                  secondSource: wm.custodiansState,
                  builder: (_, publicKey, custodians) =>
                      custodians == null || custodians.length < 2
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: DimensSizeV2.d12),
                          child: CommonSelectDropdown<PublicKey>(
                            values: [
                              for (final c in custodians)
                                CommonSheetDropdownItem<PublicKey>(
                                  value: c,
                                  title:
                                      wm.getSeedName(c) ?? c.toEllipseString(),
                                ),
                            ],
                            titleText: LocaleKeys.custodianWord.tr(),
                            currentValue: publicKey,
                            onChanged: wm.onChangedCustodian,
                          ),
                        ),
                ),
                const SizedBox(height: DimensSizeV2.d12),
                MultiListenerRebuilder(
                  listenableList: [wm.dataState, wm.recipientState],
                  builder: (_) {
                    final data = wm.dataState.value;
                    final recipient = wm.recipientState.value;

                    return data?.let(
                          (data) => TokenTransferInfoWidget(
                            key: UniqueKey(),
                            color: theme.colors.background2,
                            amount: data.amount,
                            attachedAmount: data.attachedAmount,
                            rootTokenContract: data.rootTokenContract,
                            recipient: recipient,
                            fee: wm.feeState,
                            numberUnconfirmedTransactions:
                                data.numberUnconfirmedTransactions,
                          ),
                        ) ??
                        const SizedBox.shrink();
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: wm.payloadState,
                  builder: (_, payload, __) {
                    if (payload == null) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.only(top: DimensSizeV2.d12),
                      child: ExpandableCard(
                        collapsedHeight: DimensSizeV2.d256,
                        child: SeparatedColumn(
                          spacing: DimensSizeV2.d16,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              LocaleKeys.metadata.tr(),
                              style: theme.textStyles.labelSmall.copyWith(
                                color: theme.colors.content3,
                              ),
                            ),
                            FunctionCallBody(payload: payload),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        if (wm.account != null)
          MultiListenerRebuilder(
            listenableList: [
              wm.feeState,
              wm.txErrorsState,
              wm.isConfirmedState,
            ],
            builder: (_) {
              final isConfirmed = wm.isConfirmedState.value;
              final txErrors = wm.txErrorsState.value;
              final fees = wm.feeState.value;
              final hasTxError = txErrors?.isNotEmpty ?? false;

              return SeparatedColumn(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasTxError)
                    TxTreeSimulationErrorWidget(
                      txErrors: txErrors!,
                      symbol: wm.symbol,
                      isConfirmed: isConfirmed ?? false,
                      onConfirm: wm.onConfirmed,
                    ),
                  StateNotifierBuilder(
                    listenableState: wm.isLoadingState,
                    builder: (_, isLoading) => EnterPasswordWidget.auth(
                      getLedgerAuthInput: wm.getLedgerAuthInput,
                      isLoading: isLoading ?? false,
                      publicKey: wm.account!.publicKey,
                      title: LocaleKeys.sendWord.tr(),
                      isDisabled:
                          wm.numberUnconfirmedTransactions == null ||
                          wm.numberUnconfirmedTransactions! >= 5 ||
                          fees.isErrorState ||
                          (hasTxError && isConfirmed != true),
                      onConfirmed: wm.onSubmit,
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}
