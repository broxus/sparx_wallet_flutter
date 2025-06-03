import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _indicator = ProgressIndicatorWidget(size: DimensSizeV2.d20);

class NftTransferInfoWidget
    extends ElementaryWidget<NftTransferInfoWidgetModel> {
  const NftTransferInfoWidget({
    required this.amount,
    required this.recipient,
    required this.item,
    required this.collection,
    required this.attachedAmount,
    required this.fees,
    required this.feeError,
    Key? key,
    WidgetModelFactory wmFactory = defaultNftTransferInfoWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final BigInt? amount;
  final Address recipient;
  final ListenableState<NftItem> item;
  final ListenableState<NftCollection> collection;
  final ListenableState<BigInt> fees;
  final ListenableState<String> feeError;
  final ListenableState<BigInt> attachedAmount;

  @override
  Widget build(NftTransferInfoWidgetModel wm) {
    final theme = wm.theme;
    final labelSmallContent3 = theme.textStyles.labelSmall.copyWith(
      color: theme.colors.content3,
    );

    return PrimaryCard(
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DoubleSourceBuilder(
            firstSource: item,
            secondSource: collection,
            builder: (_, item, collection) {
              if (item == null || collection == null) {
                return const ProgressIndicatorWidget(size: DimensSizeV2.d44);
              }

              return _Item(item: item, collection: collection);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: DimensSizeV2.d16),
            child: CommonDivider(),
          ),
          if (amount != null)
            _InfoRow(
              label: LocaleKeys.amountWord.tr(),
              child: Text(
                amount.toString(),
                style: theme.textStyles.labelSmall,
              ),
            ),
          DoubleSourceBuilder(
            firstSource: attachedAmount,
            secondSource: wm.nativeUSDPrice,
            builder: (_, attachedAmount, nativeUSDPrice) {
              final amount = attachedAmount?.let(
                (attachedAmount) => Money.fromBigIntWithCurrency(
                  attachedAmount,
                  wm.nativeCurrency,
                ),
              );

              return _InfoRow(
                margin: const EdgeInsets.only(top: DimensSizeV2.d16),
                label: LocaleKeys.attachedAmount.tr(),
                child: SeparatedColumn(
                  spacing: DimensSize.d4,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    amount?.let(
                          (value) => AmountWidget.fromMoney(
                            amount: value,
                            icon: TonWalletIconWidget(
                              path: wm.nativeTokenIcon,
                              size: DimensSizeV2.d20,
                            ),
                            includeSymbol: false,
                          ),
                        ) ??
                        _indicator,
                    if (nativeUSDPrice != null && amount != null)
                      AmountWidget.dollars(
                        amount: amount.exchangeToUSD(nativeUSDPrice),
                        style: theme.textStyles.labelXSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          TripleSourceBuilder(
            firstSource: fees,
            secondSource: feeError,
            thirdSource: wm.nativeUSDPrice,
            builder: (_, fees, feeError, nativeUSDPrice) {
              final amount = fees?.let(
                (fees) => Money.fromBigIntWithCurrency(
                  fees,
                  wm.nativeCurrency,
                ),
              );

              final child = SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: DimensSizeV2.d4,
                children: [
                  WalletTransactionDetailsItem(
                    title: LocaleKeys.networkFee.tr(),
                    valueWidget: amount?.let(
                          (amount) => AmountWidget.fromMoney(
                            amount: amount,
                            sign: '~ ',
                            includeSymbol: false,
                          ),
                        ) ??
                        _indicator,
                    iconPath: wm.nativeTokenIcon,
                    convertedValueWidget:
                        nativeUSDPrice != null && amount != null
                            ? AmountWidget.dollars(
                                amount: amount.exchangeToUSD(nativeUSDPrice, 5),
                                style: theme.textStyles.labelXSmall.copyWith(
                                  color: theme.colors.content3,
                                ),
                              )
                            : null,
                  ),
                  if (feeError != null)
                    Text(
                      feeError,
                      style: theme.textStyles.labelSmall.copyWith(
                        color: theme.colors.negative,
                      ),
                    ),
                ],
              );

              return Padding(
                padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                child: child,
              );
            },
          ),
          Padding(
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
          ),
          PrimaryCard(
            margin: const EdgeInsets.only(
              top: DimensSizeV2.d12,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: DimensSizeV2.d8,
              horizontal: DimensSizeV2.d12,
            ),
            color: theme.colors.primaryA,
            borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
            child: Text(
              LocaleKeys.nftAttachedAmountNotification.tr(),
              style: theme.textStyles.paragraphSmall.copyWith(
                color: theme.colors.primaryB,
              ),
            ),
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

class _Item extends StatelessWidget {
  const _Item({
    required this.item,
    required this.collection,
  });

  final NftItem item;
  final NftCollection collection;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Row(
      spacing: DimensSizeV2.d8,
      children: [
        SizedBox(
          width: DimensSizeV2.d40,
          height: DimensSizeV2.d40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(DimensRadiusV2.radius20),
            child: NftImage(imageUrl: item.nft.previewUrl),
          ),
        ),
        Expanded(
          child: Column(
            spacing: DimensSizeV2.d4,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.nft.name ?? LocaleKeys.unknown.tr(),
                style: theme.textStyles.labelMedium,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
              Text(
                collection.name ?? LocaleKeys.unknown.tr(),
                style: theme.textStyles.labelXSmall.copyWith(
                  color: theme.colors.content3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
