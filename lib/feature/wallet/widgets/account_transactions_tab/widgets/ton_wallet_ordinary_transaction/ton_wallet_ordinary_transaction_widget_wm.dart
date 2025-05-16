import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Factory method for creating [TonWalletOrdinaryTransactionWidgetWidgetModel]
TonWalletOrdinaryTransactionWidgetWidgetModel
    defaultTonWalletOrdinaryTransactionWidgetWidgetModelFactory(
  BuildContext context, {
  required TonWalletOrdinaryTransaction transaction,
  required bool isFirst,
  required bool isLast,
  required Fixed price,
}) {
  return TonWalletOrdinaryTransactionWidgetWidgetModel(
    TonWalletOrdinaryTransactionWidgetModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    transaction,
    isFirst,
    isLast,
    price,
  );
}

/// [WidgetModel] для [TonWalletOrdinaryTransactionWidget]
class TonWalletOrdinaryTransactionWidgetWidgetModel extends CustomWidgetModel<
    TonWalletOrdinaryTransactionWidget,
    TonWalletOrdinaryTransactionWidgetModel> {
  TonWalletOrdinaryTransactionWidgetWidgetModel(
    super.model,
    this._transaction,
    // ignore: avoid_positional_boolean_parameters
    this.isFirst,
    this.isLast,
    this._price,
  );

  final TonWalletOrdinaryTransaction _transaction;
  final bool isFirst;
  final bool isLast;
  final Fixed _price;

  late final bool isIncoming = !_transaction.isOutgoing;
  late final Address address = _transaction.address;
  late final transactionFee = Money.fromBigIntWithCurrency(
    _transaction.fees,
    Currencies()[model.ticker]!,
  );
  late final transactionValue = Money.fromBigIntWithCurrency(
    _transaction.value,
    Currencies()[model.ticker]!,
  );
  late final date = _transaction.date;

  void onPressed() => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletOrdinaryTransactionDetailsPage(
            transaction: _transaction,
            price: _price,
          ),
        ),
      );
}
