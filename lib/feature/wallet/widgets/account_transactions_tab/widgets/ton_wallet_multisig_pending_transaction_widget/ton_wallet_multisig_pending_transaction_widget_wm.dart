import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/route.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_pending_transaction_widget/ton_wallet_multisig_pending_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_pending_transaction_widget/ton_wallet_multisig_pending_transaction_widget_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// [WidgetModel] for [TonWalletMultisigPendingTransactionWidget]
@injectable
class TonWalletMultisigPendingTransactionWidgetWidgetModel
    extends
        CustomWidgetModelParametrized<
          TonWalletMultisigPendingTransactionWidget,
          TonWalletMultisigPendingTransactionWidgetModel,
          TonWalletMultisigPendingTransactionParams
        > {
  TonWalletMultisigPendingTransactionWidgetWidgetModel(super.model);

  late final expireAtFormat = DateFormat(
    'HH:mm:ss',
    context.locale.languageCode,
  );

  ThemeStyleV2 get theme => context.themeStyleV2;

  bool get isFirst => wmParams.value.isFirst;

  bool get isLast => wmParams.value.isLast;

  TonWalletMultisigPendingTransaction get transaction =>
      wmParams.value.transaction;

  Money get transactionFee => model.getTransactionFee(transaction.fees);

  Money get transactionValue => model.getTransactionValue(transaction.value);

  void onPressed() {
    contextSafe?.compassPush<void>(
      PendingTransactionDetailsRouteData(
        transaction: wmParams.value.transaction,
        price: wmParams.value.price,
        account: wmParams.value.account,
      ),
    );
  }
}

class TonWalletMultisigPendingTransactionParams {
  TonWalletMultisigPendingTransactionParams({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
    required this.price,
    required this.account,
  });

  final TonWalletMultisigPendingTransaction transaction;
  final bool isFirst;
  final bool isLast;
  final Fixed price;
  final KeyAccount account;
}
