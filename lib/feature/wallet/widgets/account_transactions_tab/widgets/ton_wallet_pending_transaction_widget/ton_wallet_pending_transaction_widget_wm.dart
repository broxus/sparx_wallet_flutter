import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_pending_transaction_widget/ton_wallet_pending_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_pending_transaction_widget/ton_wallet_pending_transaction_widget_model.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [WidgetModel] for [TonWalletPendingTransactionWidget]
@injectable
class TonWalletPendingTransactionWidgetWidgetModel
    extends
        CustomWidgetModelParametrized<
          TonWalletPendingTransactionWidget,
          TonWalletPendingTransactionWidgetModel,
          TonWalletPendingTransactionParams
        > {
  TonWalletPendingTransactionWidgetWidgetModel(super.model);

  late final ticker = model.ticker;

  TonWalletPendingTransaction get transaction => wmParams.value.transaction;

  bool get isFirst => wmParams.value.isFirst;

  bool get isLast => wmParams.value.isLast;

  Money get transactionValue =>
      model.getTransactionValueByAmount(transaction.amount);
}

class TonWalletPendingTransactionParams {
  TonWalletPendingTransactionParams({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
  });

  final TonWalletPendingTransaction transaction;
  final bool isFirst;
  final bool isLast;
}
