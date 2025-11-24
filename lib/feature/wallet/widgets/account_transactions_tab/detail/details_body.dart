import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Body of transaction for Ton/Token Wallets that contains main information
/// about transaction (date, hash, value, fee, sender/recipient).
class WalletTransactionDetailsDefaultBody extends StatefulWidget {
  const WalletTransactionDetailsDefaultBody({
    required this.date,
    required this.recipientOrSender,
    required this.hash,
    required this.value,
    required this.fee,
    required this.status,
    required this.isIncoming,
    required this.type,
    this.comment,
    this.info,
    this.tonIconPath,
    this.tokenIconPath,
    this.price,
    this.expiresAt,
    this.transactionId,
    super.key,
  });

  /// Date of transaction
  final DateTime date;

  /// Address of recipient or sender, based on [isIncoming]
  final Address recipientOrSender;

  /// Flag that indicates direction of transaction
  final bool isIncoming;

  /// Transaction hash
  final String hash;

  /// Amount sended in transaction
  final Money value;

  /// Fee of transaction
  final Money fee;

  /// Status of transaction
  final TonWalletTransactionStatus status;

  final String type;

  /// Comment of transaction
  final String? comment;

  /// Type of transaction, that exists for TokenWallet
  final String? info;
  final String? tonIconPath;
  final String? tokenIconPath;
  final Fixed? price;
  final DateTime? expiresAt;
  final String? transactionId;

  @override
  State<WalletTransactionDetailsDefaultBody> createState() =>
      _WalletTransactionDetailsDefaultBodyState();
}

class _WalletTransactionDetailsDefaultBodyState
    extends State<WalletTransactionDetailsDefaultBody> {
  late final _messengerService = inject<MessengerService>();
  late final _ntpService = inject<NtpService>();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return ShapedContainerColumn(
      color: theme.colors.background1,
      mainAxisSize: MainAxisSize.min,
      spacing: DimensSize.d16,
      children: [
        const SizedBox.shrink(),
        _statusDateRow(context, theme),
        const CommonDivider(),
        WalletTransactionDetailsItem(
          title: LocaleKeys.typeWord.tr(),
          value: widget.type,
        ),
        WalletTransactionDetailsItem(
          title: LocaleKeys.token.tr(),
          value: widget.value.currency.symbolFixed,
        ),
        WalletTransactionDetailsItem(
          title: LocaleKeys.amountWord.tr(),
          valueWidget: AmountWidget.fromMoney(
            amount: widget.value,
            includeSymbol: false,
            useDefaultFormat: false,
            sign: widget.isIncoming
                ? LocaleKeys.plusSign.tr()
                : LocaleKeys.minusSign.tr(),
          ),
          iconPath: widget.tokenIconPath,
          convertedValueWidget: widget.price != null
              ? AmountWidget.dollars(
                  amount: widget.value.exchangeToUSD(widget.price!),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                )
              : null,
        ),
        WalletTransactionDetailsItem(
          title: LocaleKeys.networkFee.tr(),
          valueWidget: AmountWidget.fromMoney(
            amount: widget.fee,
            includeSymbol: false,
          ),
          iconPath: widget.tonIconPath,
          convertedValueWidget: AmountWidget.dollars(
            amount: widget.fee.exchangeToUSD(widget.price!, 5),
            style: theme.textStyles.labelXSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
        ),
        if (widget.info != null)
          WalletTransactionDetailsItem(
            title: LocaleKeys.info.tr(),
            value: widget.info,
          ),
        WalletTransactionDetailsItem(
          title: widget.isIncoming
              ? LocaleKeys.senderWord.tr()
              : LocaleKeys.recipientWord.tr(),
          subtitle: widget.recipientOrSender.toEllipseString(),
          icon: LucideIcons.copy,
          onPressed: () {
            _copy(
              context,
              widget.recipientOrSender.address,
              LocaleKeys.valueCopiedExclamation.tr(
                args: [widget.recipientOrSender.toEllipseString()],
              ),
            );
          },
        ),
        if (widget.transactionId == null)
          WalletTransactionDetailsItem(
            title: LocaleKeys.hashId.tr(),
            subtitle: toEllipseString(widget.hash),
            icon: LucideIcons.copy,
            onPressed: () {
              _copy(
                context,
                widget.hash,
                LocaleKeys.valueCopiedExclamation.tr(args: [widget.hash]),
              );
            },
          )
        else
          WalletTransactionDetailsItem(
            title: LocaleKeys.transactionId.tr(),
            subtitle: widget.transactionId,
            icon: LucideIcons.copy,
            onPressed: () {
              _copy(
                context,
                widget.transactionId!,
                LocaleKeys.valueCopiedExclamation.tr(
                  args: [widget.transactionId!],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _statusDateRow(BuildContext context, ThemeStyleV2 theme) {
    final formatter = widget.date.year == _ntpService.now().year
        ? DateFormat('MM.dd, HH:mm:ss', context.locale.languageCode)
        : DateFormat('MM.dd.y, HH:mm:ss', context.locale.languageCode);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.isIncoming
                        ? LocaleKeys.received.tr()
                        : LocaleKeys.sent.tr(),
                    style: theme.textStyles.headingMedium,
                  ),
                  const Spacer(),
                  widget.status.chipByStatus,
                ],
              ),
              const SizedBox(height: DimensSizeV2.d4),
              Text(
                formatter.format(widget.date),
                style: theme.textStyles.labelXSmall.copyWith(
                  color: theme.colors.content3,
                ),
                textAlign: TextAlign.right,
              ),
              if (widget.expiresAt != null)
                const SizedBox(height: DimensSizeV2.d4),
              if (widget.expiresAt != null)
                Text(
                  DateTimeUtils.formatExpirationDate(widget.expiresAt!),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content1,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _copy(BuildContext context, String value, String copyMessage) {
    setClipBoardData(value);
    _messengerService.show(Message.successful(message: copyMessage));
  }
}
