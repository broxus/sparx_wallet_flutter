import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/transaction_icon.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that displays pure transaction for TonWallet
class TonWalletTransactionWidget extends StatelessWidget {
  const TonWalletTransactionWidget({
    required this.transactionDateTime,
    required this.isIncoming,
    required this.transactionValue,
    required this.transactionFee,
    required this.status,
    required this.isFirst,
    required this.isLast,
    required this.onPressed,
    required this.address,
    required this.icon,
    this.additionalInformation,
    super.key,
  });

  /// Date and time of transaction creation
  final DateTime transactionDateTime;

  /// If this transaction filled our account balance
  final bool isIncoming;

  /// Amount of tokens that was sent
  final Money transactionValue;

  /// Fee of blockchain that was taken for transaction.
  /// Transaction can be null for some type of transactions, for example pending
  final Money? transactionFee;

  /// Address of recipient/sender
  final Address address;

  /// Widget that will be displayed between header part and status part,
  /// optional.
  final Widget? additionalInformation;

  /// Status of transaction, if it's not [TonWalletTransactionStatus.completed],
  /// then it will be displayed.
  final TonWalletTransactionStatus status;

  /// If date of this transaction must be displayed.
  /// This is external decision that could use comparing this transaction and
  /// prev one.
  final bool isFirst;

  /// if isLast true, it means that this transaction is last for this date
  final bool isLast;

  /// Press callback to open detailed transaction page
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final date = isFirst ? _Date(transactionDateTime) : null;

    final body = Container(
      decoration: BoxDecoration(
        color: theme.colors.background1,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isFirst ? DimensRadiusV2.radius16 : 0),
          bottom: Radius.circular(isLast ? DimensRadiusV2.radius16 : 0),
        ),
      ),
      child: PressScaleWidget(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colors.background1,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(isFirst ? DimensRadiusV2.radius16 : 0),
              bottom: Radius.circular(isLast ? DimensRadiusV2.radius16 : 0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: DimensSizeV2.d8,
            children: [
              _Body(
                icon: icon,
                isIncoming: isIncoming,
                transactionValue: transactionValue,
                status: status,
                address: address,
                date: transactionDateTime,
                additionalInformation: additionalInformation,
              ),
            ],
          ),
        ),
      ),
    );

    return date == null
        ? body
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: DimensSizeV2.d8,
            children: [date, body],
          );
  }
}

class _Date extends StatelessWidget {
  const _Date(this.date);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Padding(
      padding: const EdgeInsets.only(top: DimensSize.d8),
      child: Text(
        DateTimeUtils.formatTransactionDate(date, context.locale.languageCode),
        style: theme.textStyles.headingXSmall,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.icon,
    required this.isIncoming,
    required this.transactionValue,
    required this.status,
    required this.address,
    required this.date,
    required this.additionalInformation,
  });

  final IconData icon;
  final bool isIncoming;
  final Money transactionValue;
  final TonWalletTransactionStatus status;
  final Address address;
  final DateTime date;
  final Widget? additionalInformation;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final transactionTimeFormatter = DateFormat(
      'HH:mm',
      context.locale.languageCode,
    );
    final color = switch (status) {
      TonWalletTransactionStatus.waitingConfirmation =>
        theme.colors.contentWarning,
      TonWalletTransactionStatus.expired ||
      TonWalletTransactionStatus.pending =>
        theme.colors.content3,
      _ => isIncoming ? theme.colors.contentPositive : theme.colors.content0,
    };

    return Padding(
      padding: const EdgeInsets.all(DimensSize.d16),
      child: Row(
        spacing: DimensSizeV2.d8,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // amount
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TransactionIcon(
                      icon: icon,
                      isIncoming: isIncoming,
                      status: status,
                    ),
                    const SizedBox(width: DimensSizeV2.d12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AmountWidget.fromMoney(
                          amount: transactionValue,
                          includeSymbol: false,
                          sign: isIncoming
                              ? LocaleKeys.plusSign.tr()
                              : LocaleKeys.minusSign.tr(),
                          style: theme.textStyles.labelXSmall.copyWith(
                            color: color,
                          ),
                        ),
                        const SizedBox(height: DimensSizeV2.d4),
                        Text(
                          isIncoming
                              ? LocaleKeys.fromWord
                                  .tr(args: [address.toEllipseString()])
                              : LocaleKeys.toWord
                                  .tr(args: [address.toEllipseString()]),
                          style: theme.textStyles.labelXSmall.copyWith(
                            color: theme.colors.content3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: DimensSizeV2.d4),
              ],
            ),
          ),
          additionalInformation ??
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (status == TonWalletTransactionStatus.pending ||
                      status == TonWalletTransactionStatus.unstakingInProgress)
                    Text(
                      status.title,
                      style: theme.textStyles.labelXSmall
                          .copyWith(color: theme.colors.content3),
                    )
                  else
                    Text('', style: theme.textStyles.labelXSmall),
                  Text(
                    transactionTimeFormatter.format(date),
                    style: theme.textStyles.labelXSmall.copyWith(
                      color: theme.colors.content3,
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
