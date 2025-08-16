import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_ordinary_transaction_widget/ton_wallet_multisig_ordinary_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_ordinary_transaction_widget/ton_wallet_multisig_ordinary_transaction_widget_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [WidgetModel] for [TonWalletMultisigOrdinaryTransactionWidget]
@injectable
class TonWalletMultisigOrdinaryTransactionWidgetWidgetModel
    extends CustomWidgetModelParametrized<
        TonWalletMultisigOrdinaryTransactionWidget,
        TonWalletMultisigOrdinaryTransactionWidgetModel,
        TonWalletMultisigOrdinaryTransactionParams> {
  TonWalletMultisigOrdinaryTransactionWidgetWidgetModel(
    super.model,
  );

  TonWalletMultisigOrdinaryTransaction get transaction =>
      wmParams.value.transaction;

  bool get isFirst => wmParams.value.isFirst;

  bool get isLast => wmParams.value.isLast;

  Money get transactionFee => model.getTransactionFee(transaction.fees);

  Money get transactionValue => model.getTransactionValue(transaction.value);

  void onPressed() => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletMultisigOrdinaryTransactionDetailsScreen(
            transaction: transaction,
            price: wmParams.value.price,
            account: wmParams.value.account,
          ),
        ),
      );
}

class TonWalletMultisigOrdinaryTransactionParams {
  TonWalletMultisigOrdinaryTransactionParams({
    required this.transaction,
    required this.price,
    required this.isFirst,
    required this.isLast,
    required this.account,
  });

  final TonWalletMultisigOrdinaryTransaction transaction;
  final Fixed price;
  final bool isFirst;
  final bool isLast;
  final KeyAccount account;
}
