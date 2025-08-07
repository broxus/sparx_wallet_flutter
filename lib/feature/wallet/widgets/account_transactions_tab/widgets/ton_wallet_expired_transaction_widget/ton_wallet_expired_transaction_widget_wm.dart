import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_expired_transaction_widget/ton_wallet_expired_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_expired_transaction_widget/ton_wallet_expired_transaction_widget_model.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [WidgetModel] for [TonWalletExpiredTransactionWidget]
@injectable
class TonWalletExpiredTransactionWidgetWidgetModel
    extends CustomWidgetModelParametrized<
        TonWalletExpiredTransactionWidget,
        TonWalletExpiredTransactionWidgetModel,
        TonWalletExpiredTransactionParams> {
  TonWalletExpiredTransactionWidgetWidgetModel(
    super.model,
  );

  late final transactionValue = model.getTransactionValue(transaction.amount);

  TonWalletExpiredTransaction get transaction => wmParams.value.transaction;

  bool get isFirst => wmParams.value.isFirst;

  bool get isLast => wmParams.value.isLast;
}

class TonWalletExpiredTransactionParams {
  TonWalletExpiredTransactionParams({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
  });

  final TonWalletExpiredTransaction transaction;
  final bool isFirst;
  final bool isLast;
}
