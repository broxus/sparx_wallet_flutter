import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
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
class TonWalletOrdinaryTransactionWidgetWidgetModel
    extends
        CustomWidgetModelParametrized<
          TonWalletOrdinaryTransactionWidget,
          TonWalletOrdinaryTransactionWidgetModel,
          TonWalletOrdinaryTransactionWmParams
        > {
  TonWalletOrdinaryTransactionWidgetWidgetModel(super.model);

  late final isIncomingState = createWmParamsNotifier<bool>(
    (it) => !it.transaction.isOutgoing,
  );
  late final addressState = createWmParamsNotifier<Address>(
    (it) => it.transaction.address,
  );
  late final transactionFeeState = createWmParamsNotifier<Money>(
    (it) => Money.fromBigIntWithCurrency(
      it.transaction.fees,
      Currencies()[model.ticker]!,
    ),
  );
  late final transactionValueState = createWmParamsNotifier<Money>(
    (it) => Money.fromBigIntWithCurrency(
      it.transaction.value,
      Currencies()[model.ticker]!,
    ),
  );
  late final dateState = createWmParamsNotifier<DateTime>(
    (it) => it.transaction.date,
  );

  late final isFirstState = createWmParamsNotifier<bool>((it) => it.isFirst);
  late final isLastState = createWmParamsNotifier<bool>((it) => it.isLast);

  void onPressed() {
    final params = wmParams.value;
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (_) => TonWalletOrdinaryTransactionDetails(
          transaction: params.transaction,
          price: params.price,
        ),
      ),
    );
  }
}
