import 'package:app/app/service/ton_connect/ton_connect.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TCSendMessageWidget extends ElementaryWidget<TCSendMessageWidgetModel> {
  const TCSendMessageWidget({
    required this.connection,
    required this.payload,
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultTCSendMessageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final TonAppConnection connection;
  final TransactionPayload payload;
  final ScrollController scrollController;

  @override
  Widget build(TCSendMessageWidgetModel wm) {
    final theme = wm.theme;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (wm.account != null)
                  StateNotifierBuilder(
                    listenableState: wm.balance,
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
                StateNotifierBuilder(
                  listenableState: wm.manifest,
                  builder: (_, origin) =>
                      origin?.let(
                        (value) => WebsiteInfoWidget(
                          uri: Uri.parse(value.url),
                          iconUrl: Uri.tryParse(value.iconUrl),
                        ),
                      ) ??
                      const SizedBox.shrink(),
                ),
                DoubleSourceBuilder(
                  firstSource: wm.publicKey,
                  secondSource: wm.custodians,
                  builder: (_, publicKey, custodians) => custodians == null ||
                          custodians.length < 2
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
                TripleSourceBuilder(
                  firstSource: wm.data,
                  secondSource: wm.fee,
                  thirdSource: wm.feeError,
                  builder: (_, data, fee, feeError) {
                    return data?.let(
                          (data) => TokenTransferInfoWidget(
                            key: UniqueKey(),
                            color: theme.colors.background2,
                            amount: data.amount,
                            recipient: data.recipient,
                            fee: fee,
                            feeError: feeError,
                            numberUnconfirmedTransactions:
                                data.numberUnconfirmedTransactions,
                          ),
                        ) ??
                        const SizedBox.shrink();
                  },
                ),
                StateNotifierBuilder(
                  listenableState: wm.data,
                  builder: (_, data) {
                    if (data == null ||
                        (data.messages.length == 1 &&
                            data.messages.first.payload == null)) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: DimensSizeV2.d12),
                      child: ExpandableCard(
                        collapsedHeight: DimensSizeV2.d256,
                        child: SeparatedColumn(
                          separatorSize: DimensSizeV2.d16,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (final message in data.messages)
                              _MessageData(
                                message: message,
                                currency: data.currency,
                              ),
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
          TripleSourceBuilder(
            firstSource: wm.isLoading,
            secondSource: wm.txErrors,
            thirdSource: wm.isConfirmed,
            builder: (_, isLoading, txErrors, isConfirmed) {
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
                  EnterPasswordWidgetV2(
                    isLoading: isLoading,
                    publicKey: wm.account!.publicKey,
                    title: LocaleKeys.sendWord.tr(),
                    isDisabled: wm.numberUnconfirmedTransactions == null ||
                        wm.numberUnconfirmedTransactions! >= 5 ||
                        (hasTxError && isConfirmed != true),
                    onPasswordEntered: wm.onSubmit,
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}

class _MessageData extends StatelessWidget {
  const _MessageData({
    required this.message,
    required this.currency,
  });

  final TransactionPayloadMessage message;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return PrimaryCard(
      color: theme.colors.background3,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
      child: SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeparatedColumn(
            separatorSize: DimensSizeV2.d2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.recipientWord.tr(),
                style: theme.textStyles.labelSmall.copyWith(
                  color: theme.colors.content3,
                ),
              ),
              Text(
                message.address.address,
                style: theme.textStyles.labelSmall,
              ),
            ],
          ),
          SeparatedColumn(
            separatorSize: DimensSizeV2.d2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.amountWord.tr(),
                style: theme.textStyles.labelSmall.copyWith(
                  color: theme.colors.content3,
                ),
              ),
              AmountWidget.fromMoney(
                amount: Money.fromBigIntWithCurrency(
                  BigInt.parse(message.amount),
                  currency,
                ),
                style: theme.textStyles.labelSmall,
              ),
            ],
          ),
          if (message.payload != null)
            SeparatedColumn(
              separatorSize: DimensSizeV2.d2,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.payloadWord.tr(),
                  style: theme.textStyles.labelSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                ),
                Text(
                  message.payload!,
                  style: theme.textStyles.paragraphSmall,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
