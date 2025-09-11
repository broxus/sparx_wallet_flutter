import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/website_info/website_info_widget.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TCSendMessageWidget extends InjectedElementaryParametrizedWidget<
    TCSendMessageWidgetModel, TCSendMessageWmParams> {
  TCSendMessageWidget({
    required TonAppConnection connection,
    required TransactionPayload payload,
    required this.scrollController,
    super.key,
  }) : super(
          wmFactoryParam: TCSendMessageWmParams(
            connection: connection,
            payload: payload,
          ),
        );

  final ScrollController scrollController;

  @override
  Widget build(TCSendMessageWidgetModel wm) {
    final theme = wm.theme;

    return SeparatedColumn(
      spacing: DimensSizeV2.d12,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MultiListenerRebuilder(
                  listenableList: [
                    wm.accountState,
                    wm.balanceState,
                  ],
                  builder: (_) {
                    final account = wm.accountState.value;
                    final balance = wm.balanceState.value;

                    if (account == null) {
                      return const SizedBox.shrink();
                    }

                    return AccountInfo(
                      account: account,
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
                    );
                  },
                ),
                const SizedBox(height: DimensSizeV2.d12),
                WebsiteInfoWidget(
                  uri: Uri.parse(wm.connection.manifest.url),
                  iconUrl: Uri.tryParse(wm.connection.manifest.iconUrl),
                ),
                MultiListenerRebuilder(
                  listenableList: [
                    wm.accountState,
                    wm.selectedPublicKey,
                    wm.custodiansState,
                  ],
                  builder: (_) {
                    final account = wm.accountState.value;
                    final selectedPublicKey =
                        wm.selectedPublicKey.value ?? account?.publicKey;
                    final custodians = wm.custodiansState.value;

                    if (custodians == null || custodians.length < 2) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: DimensSizeV2.d12),
                      child: CommonSelectDropdown<PublicKey>(
                        values: [
                          for (final c in custodians)
                            CommonSheetDropdownItem<PublicKey>(
                              value: c,
                              title: wm.getSeedName(c) ?? c.toEllipseString(),
                            ),
                        ],
                        titleText: LocaleKeys.custodianWord.tr(),
                        currentValue: selectedPublicKey,
                        onChanged: wm.onChangedCustodian,
                      ),
                    );
                  },
                ),
                const SizedBox(height: DimensSizeV2.d12),
                TripleSourceBuilder(
                  firstSource: wm.dataState,
                  secondSource: wm.feeState,
                  thirdSource: wm.feeErrorState,
                  builder: (_, data, fee, feeError) {
                    if (data == null) return const SizedBox.shrink();

                    final single = data.singleOrNull;
                    if (single != null) {
                      return TokenTransferInfoWidget(
                        key: UniqueKey(),
                        color: theme.colors.background2,
                        amount: single.amount,
                        recipient: single.recipient,
                        fee: fee,
                        feeError: feeError,
                        numberUnconfirmedTransactions:
                            wm.numberUnconfirmedTransactions,
                        attachedAmount: single.attachedAmount,
                        rootTokenContract: single.rootTokenContract,
                        payload: single.message.payload,
                      );
                    }

                    return _MultitransferInfo(
                      data: data,
                      totalAmount: wm.totalAmount,
                      fee: fee,
                      feeError: feeError,
                      numberUnconfirmedTransactions:
                          wm.numberUnconfirmedTransactions,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        MultiListenerRebuilder(
          listenableList: [
            wm.accountState,
            wm.txErrorsState,
            wm.isConfirmedState,
            wm.isLoadingState,
          ],
          builder: (_) {
            final account = wm.accountState.value;
            final txErrors = wm.txErrorsState.value;
            final isConfirmed = wm.isConfirmedState.value;
            final isLoading = wm.isLoadingState.value;
            final numberUnconfirmedTransactions =
                wm.numberUnconfirmedTransactions;

            if (account == null) return const SizedBox.shrink();

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
                EnterPasswordWidget.auth(
                  getLedgerAuthInput: wm.getLedgerAuthInput,
                  isLoading: isLoading ?? false,
                  publicKey: account.publicKey,
                  title: LocaleKeys.sendWord.tr(),
                  isDisabled: numberUnconfirmedTransactions == null ||
                      numberUnconfirmedTransactions >= 5 ||
                      (hasTxError && isConfirmed != true),
                  onConfirmed: wm.onSubmit,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _MultitransferInfo extends StatelessWidget {
  const _MultitransferInfo({
    required this.data,
    required this.totalAmount,
    required this.fee,
    required this.feeError,
    required this.numberUnconfirmedTransactions,
  });

  final List<TransferData> data;
  final Money totalAmount;
  final Fee? fee;
  final String? feeError;
  final int? numberUnconfirmedTransactions;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      children: [
        TokenTransferInfoWidget(
          key: UniqueKey(),
          color: context.themeStyleV2.colors.background2,
          amount: totalAmount,
          fee: fee,
          feeError: feeError,
          numberUnconfirmedTransactions: numberUnconfirmedTransactions,
        ),
        for (final item in data)
          TokenTransferInfoWidget(
            key: UniqueKey(),
            color: context.themeStyleV2.colors.background2,
            amount: item.amount,
            recipient: item.recipient,
            attachedAmount: item.attachedAmount,
            rootTokenContract: item.rootTokenContract,
            payload: item.message.payload,
          ),
      ],
    );
  }
}
