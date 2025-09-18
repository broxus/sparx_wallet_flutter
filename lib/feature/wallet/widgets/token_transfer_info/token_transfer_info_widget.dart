import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/wallet.dart';
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
    EntityValueListenable<Fee>? fee,
    BigInt? attachedAmount,
    Address? rootTokenContract,
    String? transactionIdHash,
    String? comment,
    String? payload,
    int? numberUnconfirmedTransactions,
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
            numberUnconfirmedTransactions: numberUnconfirmedTransactions,
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
            valueListenable: wm.amountState,
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
              wm.amountState,
              wm.tokenAssetState,
              wm.isNativeState,
              wm.amountUSDPriceState,
            ],
            builder: (_) {
              final amount = wm.amountState.value;
              final asset = wm.tokenAssetState.value;
              final isNative = wm.isNativeState.value;
              final price = wm.amountUSDPriceState.value;

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
                  spacing: DimensSize.d4,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AmountWidget.fromMoney(
                      amount: amount,
                      icon: icon,
                      includeSymbol: false,
                      useDefaultFormat: false,
                    ),
                    if (price != null)
                      AmountWidget.dollars(
                        amount: amount.exchangeToUSD(price),
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
              wm.attachedAmountState,
              wm.nativeUSDPriceState,
            ],
            builder: (_) {
              final attachedAmount = wm.attachedAmountState.value;
              final price = wm.nativeUSDPriceState.value;

              if (attachedAmount == null) return const SizedBox.shrink();

              return _InfoRow(
                margin: const EdgeInsets.only(top: DimensSizeV2.d16),
                label: LocaleKeys.attachedAmount.tr(),
                child: Column(
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
              wm.feeState,
              wm.feeUSDPriceState,
              wm.numberUnconfirmedTransactionsState,
              wm.feeAssetState,
            ],
            builder: (_) {
              final fee = wm.feeState.value;
              final feeUSDPrice = wm.feeUSDPriceState.value;
              final feeAsset = wm.feeAssetState.value;
              final numberUnconfirmedTransactions =
                  wm.numberUnconfirmedTransactionsState.value;

              if (fee == null) return const SizedBox.shrink();

              return ValueListenableBuilder(
                valueListenable: fee,
                builder: (_, fee, __) => Padding(
                  padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: DimensSizeV2.d4,
                    children: [
                      _FeeItem(
                        fee: fee,
                        usdPrice: feeUSDPrice,
                        asset: feeAsset,
                        nativeTokenIcon: wm.nativeTokenIcon,
                      ),
                      if ((numberUnconfirmedTransactions ?? 0) >= 5)
                        Text(
                          LocaleKeys.errorMessageMaxUnconfirmedTransactions
                              .tr(),
                          style: theme.textStyles.labelSmall.copyWith(
                            color: theme.colors.negative,
                          ),
                        )
                      else if (fee.isErrorState)
                        Text(
                          fee.errorOrNull?.toString() ?? '',
                          style: theme.textStyles.labelSmall.copyWith(
                            color: theme.colors.negative,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: wm.recipientState,
            builder: (_, recipient, __) {
              if (recipient == null) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: Column(
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
            valueListenable: wm.transactionIdHashState,
            builder: (_, transactionIdHash, __) {
              if (transactionIdHash == null) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: Column(
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
            valueListenable: wm.commentState,
            builder: (_, comment, __) {
              if (comment == null || comment.isEmpty) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: Column(
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
            valueListenable: wm.payloadState,
            builder: (_, payload, __) {
              if (payload == null) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: Column(
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

class _FeeItem extends StatelessWidget {
  const _FeeItem({
    required this.fee,
    required this.usdPrice,
    required this.asset,
    required this.nativeTokenIcon,
  });

  final EntityState<Fee> fee;
  final Fixed? usdPrice;
  final TokenContractAsset? asset;
  final String nativeTokenIcon;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    if (fee.isLoadingState) {
      return _InfoRow(
        label: LocaleKeys.networkFee.tr(),
        child: ProgressIndicatorWidget(
          size: DimensSizeV2.d20,
          color: theme.colors.content3,
        ),
      );
    }

    final priceWidget = switch (fee.data) {
      FeeNative(:final amount) || FeeToken(:final amount) => usdPrice?.let(
          (price) => AmountWidget.dollars(
            amount: amount.exchangeToUSD(price, 5),
            style: theme.textStyles.labelXSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
        ),
      _ => null,
    };

    return switch (fee.data) {
      FeeNative(:final amount) => _InfoRow(
          label: LocaleKeys.networkFee.tr(),
          child: Column(
            spacing: DimensSize.d4,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AmountWidget.fromMoney(
                amount: amount,
                icon: TonWalletIconWidget(
                  path: nativeTokenIcon,
                  size: DimensSizeV2.d20,
                ),
                sign: '~ ',
                includeSymbol: false,
              ),
              if (priceWidget != null) priceWidget,
            ],
          ),
        ),
      FeeToken(:final amount) => _InfoRow(
          label: LocaleKeys.networkFee.tr(),
          child: Column(
            spacing: DimensSize.d4,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AmountWidget.fromMoney(
                amount: amount,
                includeSymbol: false,
                icon: asset?.let(
                      (asset) => TokenWalletIconWidget(
                        address: asset.address,
                        logoURI: asset.logoURI,
                        version: asset.version,
                        size: DimensSizeV2.d20,
                      ),
                    ) ??
                    TonWalletIconWidget(
                      path: Assets.images.tokenDefaultIcon.path,
                      size: DimensSizeV2.d20,
                    ),
              ),
              if (priceWidget != null) priceWidget,
            ],
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
