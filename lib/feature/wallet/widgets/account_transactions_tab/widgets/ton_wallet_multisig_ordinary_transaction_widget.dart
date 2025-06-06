import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays completed multisig transaction for ton wallet
class TonWalletMultisigOrdinaryTransactionWidget extends StatelessWidget {
  const TonWalletMultisigOrdinaryTransactionWidget({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
    required this.price,
    required this.account,
    super.key,
  });

  final TonWalletMultisigOrdinaryTransaction transaction;
  final Fixed price;
  final bool isFirst;
  final bool isLast;
  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    return TonWalletTransactionWidget(
      icon: !transaction.isOutgoing
          ? LucideIcons.arrowDownLeft
          : LucideIcons.arrowUpRight,
      isFirst: isFirst,
      isLast: isLast,
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletMultisigOrdinaryTransactionDetailsScreen(
            transaction: transaction,
            price: price,
            account: account,
          ),
        ),
      ),
      address: transaction.address,
      isIncoming: !transaction.isOutgoing,
      status: TonWalletTransactionStatus.completed,
      transactionFee: Money.fromBigIntWithCurrency(
        transaction.fees,
        Currencies()[ticker]!,
      ),
      transactionDateTime: transaction.date,
      transactionValue: Money.fromBigIntWithCurrency(
        transaction.value,
        Currencies()[ticker]!,
      ),
    );
  }
}
