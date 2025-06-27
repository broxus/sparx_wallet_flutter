import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class TonWalletOrdinaryTransactionWmParams {
  TonWalletOrdinaryTransactionWmParams({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
    required this.price,
  });

  final TonWalletOrdinaryTransaction transaction;
  final bool isFirst;
  final bool isLast;
  final Fixed price;
}

/// [WidgetModel] для [TonWalletOrdinaryTransactionWidget]
@injectable
class TonWalletOrdinaryTransactionWidgetWidgetModel extends CustomWidgetModel<
    TonWalletOrdinaryTransactionWidget,
    TonWalletOrdinaryTransactionWidgetModel> {
  TonWalletOrdinaryTransactionWidgetWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final TonWalletOrdinaryTransactionWmParams _wmParams;

  late final bool isIncoming = !_wmParams.transaction.isOutgoing;
  late final Address address = _wmParams.transaction.address;
  late final transactionFee = Money.fromBigIntWithCurrency(
    _wmParams.transaction.fees,
    Currencies()[model.ticker]!,
  );
  late final transactionValue = Money.fromBigIntWithCurrency(
    _wmParams.transaction.value,
    Currencies()[model.ticker]!,
  );
  late final date = _wmParams.transaction.date;

  bool get isFirst => _wmParams.isFirst;
  bool get isLast => _wmParams.isLast;

  void onPressed() => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletOrdinaryTransactionDetails(
            transaction: _wmParams.transaction,
            price: _wmParams.price,
          ),
        ),
      );
}
