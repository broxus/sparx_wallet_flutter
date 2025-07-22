import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_item.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TokenTransferInfoWidget extends InjectedElementaryParametrizedWidget<
    TokenTransferInfoWidgetModel, TokenTransferInfoWmParams> {
  TokenTransferInfoWidget({
    Money? amount,
    Address? recipient,
    BigInt? fee,
    BigInt? attachedAmount,
    Address? rootTokenContract,
    String? transactionIdHash,
    String? comment,
    String? payload,
    String? feeError,
    int? numberUnconfirmedTransactions,
    bool hasFee = true,
    this.color,
    this.margin = EdgeInsets.zero,
    super.key,
  }) : super(
          wmFactoryParam: TokenTransferInfoWmParams(
            recipient: recipient,
            amount: amount,
            attachedAmount: attachedAmount,
            rootTokenContract: rootTokenContract,
            transactionIdHash: transactionIdHash,
            comment: comment,
            payload: payload,
            fee: fee,
            feeError: feeError,
            numberUnconfirmedTransactions: numberUnconfirmedTransactions,
            hasFee: hasFee,
          ),
        );

  final EdgeInsets margin;
  final Color? color;

  @override
  Widget build(TokenTransferInfoWidgetModel wm) {
    final theme = wm.theme;
    final labelSmallContent3 = theme.textStyles.labelSmall.copyWith(
      color: theme.colors.content3,
    );

    return PrimaryCard(
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      margin: margin,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: wm.amount,
            builder: (_, amount, __) {
              if (amount == null) return const SizedBox.shrink();

              return _InfoRow(
                label: LocaleKeys.token.tr(),
                child: Text(
                  amount.currency.symbolFixed,
                  style: theme.textStyles.labelSmall,
                ),
              );
            },
          ),
          MultiListenerRebuilder(
            listenableList: [
              wm.amount,
              wm.tokenAsset,
              wm.isNative,
              wm.amountUSDPrice,
            ],
            builder: (_) {
              final amount = wm.amount.value;
              final asset = wm.tokenAsset.value;
              final isNative = wm.isNative.value;
              final price = wm.amountUSDPrice.value;

              if (amount == null) return const SizedBox.shrink();

              final icon = asset?.let(
                    (asset) => TokenWalletIconWidget(
                      address: asset.address,
                      logoURI: asset.logoURI,
                      version: asset.version,
                      size: DimensSizeV2.d20,
                    ),
                  ) ??
                  TonWalletIconWidget(
                    path: isNative
                        ? wm.nativeTokenIcon
                        : Assets.images.tokenDefaultIcon.path,
                    size: DimensSizeV2.d20,
                  );

              return _InfoRow(
                margin: const EdgeInsets.only(top: DimensSizeV2.d16),
                label: LocaleKeys.amountWord.tr(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AmountWidget.fromMoney(
                      amount: amount,
                      icon: icon,
                      includeSymbol: false,
                      useDefaultFormat: false,
                    ),
                    if (price != null)
                      Padding(
                        padding: const EdgeInsets.only(top: DimensSizeV2.d4),
                        child: AmountWidget.dollars(
                          amount: amount.exchangeToUSD(price),
                          style: theme.textStyles.labelXSmall.copyWith(
                            color: theme.colors.content3,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          MultiListenerRebuilder(
            listenableList: [
              wm.attachedAmount,
              wm.nativeUSDPrice,
            ],
            builder: (_) {
              final attachedAmount = wm.attachedAmount.value;
              final price = wm.nativeUSDPrice.value;

              if (attachedAmount == null) return const SizedBox.shrink();

              return _InfoRow(
                margin: const EdgeInsets.only(top: DimensSizeV2.d16),
                label: LocaleKeys.attachedAmount.tr(),
                child: SeparatedColumn(
                  spacing: DimensSize.d4,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AmountWidget.fromMoney(
                      amount: attachedAmount,
                      icon: TonWalletIconWidget(
                        path: wm.nativeTokenIcon,
                        size: DimensSizeV2.d20,
                      ),
                      includeSymbol: false,
                    ),
                    if (price != null)
                      AmountWidget.dollars(
                        amount: attachedAmount.exchangeToUSD(price),
                        style: theme.textStyles.labelXSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          MultiListenerRebuilder(
            listenableList: [
              wm.fee,
              wm.feeError,
              wm.nativeUSDPrice,
              wm.numberUnconfirmedTransactions,
            ],
            builder: (_) {
              final fee = wm.fee.value;
              final feeError = wm.feeError.value;
              final nativeUSDPrice = wm.nativeUSDPrice.value;
              final numberUnconfirmedTransactions =
                  wm.numberUnconfirmedTransactions.value;

              if (fee == null) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: SeparatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: DimensSizeV2.d4,
                  children: [
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.networkFee.tr(),
                      valueWidget: AmountWidget.fromMoney(
                        amount: fee,
                        sign: '~ ',
                        includeSymbol: false,
                      ),
                      iconPath: wm.nativeTokenIcon,
                      convertedValueWidget: nativeUSDPrice?.let(
                        (price) => AmountWidget.dollars(
                          amount: fee.exchangeToUSD(price, 5),
                          style: theme.textStyles.labelXSmall.copyWith(
                            color: theme.colors.content3,
                          ),
                        ),
                      ),
                    ),
                    if ((numberUnconfirmedTransactions ?? 0) >= 5)
                      Text(
                        LocaleKeys.errorMessageMaxUnconfirmedTransactions.tr(),
                        style: theme.textStyles.labelSmall.copyWith(
                          color: theme.colors.negative,
                        ),
                      )
                    else if (feeError != null)
                      Text(
                        feeError,
                        style: theme.textStyles.labelSmall.copyWith(
                          color: theme.colors.negative,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: wm.recipient,
            builder: (_, recipient, __) {
              if (recipient == null) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: SeparatedColumn(
                  spacing: DimensSizeV2.d2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.recipientWord.tr(),
                      style: labelSmallContent3,
                    ),
                    Text(
                      recipient.address,
                      style: theme.textStyles.labelSmall,
                    ),
                  ],
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: wm.transactionIdHash,
            builder: (_, transactionIdHash, __) {
              if (transactionIdHash == null) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: SeparatedColumn(
                  spacing: DimensSizeV2.d2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.transactionId.tr(),
                      style: labelSmallContent3,
                    ),
                    Text(
                      transactionIdHash,
                      style: theme.textStyles.labelSmall,
                    ),
                  ],
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: wm.comment,
            builder: (_, comment, __) {
              if (comment == null || comment.isEmpty) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: SeparatedColumn(
                  spacing: DimensSizeV2.d2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.commentWord.tr(),
                      style: labelSmallContent3,
                    ),
                    Text(
                      comment,
                      style: theme.textStyles.labelSmall,
                    ),
                  ],
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: wm.payload,
            builder: (_, payload, __) {
              if (payload == null) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: SeparatedColumn(
                  spacing: DimensSizeV2.d2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.payloadWord.tr(),
                      style: labelSmallContent3,
                    ),
                    Text(
                      payload,
                      style: theme.textStyles.labelSmall,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.child,
    this.margin = EdgeInsets.zero,
  });

  final EdgeInsetsGeometry margin;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Padding(
      padding: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DimensSizeV2.d8,
        children: [
          Text(
            label,
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
          Flexible(child: child),
        ],
      ),
    );
  }
}
