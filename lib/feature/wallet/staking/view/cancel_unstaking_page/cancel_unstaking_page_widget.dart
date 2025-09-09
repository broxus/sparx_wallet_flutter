import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class CancelUnstakingPageWidget extends InjectedElementaryParametrizedWidget<
    CancelUnstakingPageWidgetModel, CancelUnstakingPageWmParams> {
  CancelUnstakingPageWidget({
    required StEverWithdrawRequest request,
    required PublicKey accountKey,
    required double exchangeRate,
    required int withdrawHours,
    required Currency stakeCurrency,
    required BigInt attachedFee,
    required Fixed? tokenPrice,
    required Fixed? everPrice,
    super.key,
  }) : super(
          wmFactoryParam: CancelUnstakingPageWmParams(
            request: request,
            accountKey: accountKey,
            exchangeRate: exchangeRate,
            withdrawHours: withdrawHours,
            stakeCurrency: stakeCurrency,
            attachedFee: attachedFee,
            tokenPrice: tokenPrice,
            everPrice: everPrice,
          ),
        );

  @override
  Widget build(CancelUnstakingPageWidgetModel wm) {
    final theme = wm.theme;
    final tokenValue = Money.fromBigIntWithCurrency(
      wm.request.data.amount,
      wm.stakeCurrency,
    );
    final everValue = Money.fromBigIntWithCurrency(
      (tokenValue * wm.exchangeRate).minorUnits,
      wm.nativeCurrency,
    );

    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.transactionInformation.tr(),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: DimensSizeV2.d90,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
                vertical: DimensSizeV2.d8,
              ),
              child: PrimaryCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSize.d16,
                  vertical: DimensSize.d8,
                ),
                borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
                child: SeparatedColumn(
                  spacing: DimensSizeV2.d16,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox.shrink(),
                    _StatusDateRow(request: wm.request),
                    Text(
                      LocaleKeys.withdrawHoursNote.tr(
                        args: [wm.withdrawHours.toString()],
                      ),
                      style: StyleRes.secondaryRegular.copyWith(
                        color: theme.colors.content3,
                      ),
                    ),
                    const Divider(),
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.typeWord.tr(),
                      value: LocaleKeys.liquidStaking.tr(),
                    ),
                    StateNotifierBuilder(
                      listenableState: wm.assetState,
                      builder: (_, asset) => WalletTransactionDetailsItem(
                        title: LocaleKeys.unstakeAmount.tr(),
                        valueWidget: AmountWidget.fromMoney(
                          amount: tokenValue,
                          includeSymbol: false,
                        ),
                        iconPath: asset?.logoURI ??
                            Assets.images.tokenDefaultIcon.path,
                        convertedValueWidget: wm.tokenPrice != null
                            ? AmountWidget.dollars(
                                amount:
                                    tokenValue.exchangeToUSD(wm.tokenPrice!),
                                style: theme.textStyles.labelXSmall.copyWith(
                                  color: theme.colors.content3,
                                ),
                              )
                            : null,
                      ),
                    ),
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.exchangeRate.tr(),
                      value:
                          // ignore: lines_longer_than_80_chars, no-magic-number, binary-expression-operand-order
                          '1 ${wm.nativeCurrency.symbol} ≈ ${(1 * wm.exchangeRate).toStringAsFixed(4)} ${wm.stakeCurrency.isoCode}',
                    ),
                    WalletTransactionDetailsItem(
                      title: LocaleKeys.receiveWord.tr(),
                      valueWidget: AmountWidget.fromMoney(
                        amount: everValue,
                        includeSymbol: false,
                      ),
                      iconPath: wm.nativeTokenIcon,
                      convertedValueWidget: wm.everPrice != null
                          ? AmountWidget.fromMoney(
                              amount: everValue.exchangeToUSD(wm.everPrice!),
                              style: theme.textStyles.labelXSmall.copyWith(
                                color: theme.colors.content3,
                              ),
                              sign: '~ ',
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: DimensSizeV2.d0,
            left: DimensSizeV2.d0,
            right: DimensSizeV2.d0,
            child: Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              child: DestructiveButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.cancelUnstaking.tr(),
                onPressed: wm.tryCancelUnstaking,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusDateRow extends StatelessWidget {
  const _StatusDateRow({
    required this.request,
  });

  final StEverWithdrawRequest request;

  @override
  Widget build(BuildContext context) {
    final date = request.data.timestamp;
    final theme = context.themeStyleV2;
    final formatter = date.year == NtpTime.now().year
        ? DateFormat('MM.dd, HH:mm', context.locale.languageCode)
        : DateFormat('MM.dd.y, HH:mm', context.locale.languageCode);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formatter.format(date),
          style: theme.textStyles.labelXSmall.copyWith(
            color: theme.colors.content3,
          ),
        ),
        TonWalletTransactionStatus.unstakingInProgress.chipByStatus,
      ],
    );
  }
}
