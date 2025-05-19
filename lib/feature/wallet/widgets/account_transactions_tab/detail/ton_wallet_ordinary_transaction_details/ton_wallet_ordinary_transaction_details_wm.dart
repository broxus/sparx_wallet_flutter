import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

/// Factory method for creating [TonWalletOrdinaryTransactionDetailsWidgetModel]
TonWalletOrdinaryTransactionDetailsWidgetModel
    defaultTonWalletOrdinaryTransactionDetailsWidgetModelFactory(
  BuildContext context, {
  required TonWalletOrdinaryTransaction transaction,
  required Fixed price,
}) {
  return TonWalletOrdinaryTransactionDetailsWidgetModel(
    TonWalletOrdinaryTransactionDetailsModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    transaction,
    price,
  );
}

/// [WidgetModel] для [TonWalletOrdinaryTransactionDetails]
class TonWalletOrdinaryTransactionDetailsWidgetModel extends CustomWidgetModel<
    TonWalletOrdinaryTransactionDetails,
    TonWalletOrdinaryTransactionDetailsModel> {
  TonWalletOrdinaryTransactionDetailsWidgetModel(
    super.model,
    this._transaction,
    this.price,
  );

  late final date = _transaction.date;
  late final isIncoming = !_transaction.isOutgoing;

  late final Money transactionFee = Money.fromBigIntWithCurrency(
    _transaction.fees,
    Currencies()[model.ticker]!,
  );

  late final Money transactionValue = Money.fromBigIntWithCurrency(
    _transaction.value,
    Currencies()[model.ticker]!,
  );

  late final transactionHash = _transaction.hash;

  late final transactionAddress = _transaction.address;

  late final transactionComment = _transaction.comment;

  late final transactionInfo = _methodData?.$1;

  late final tonIconPath = model.tonIconPath;

  final Fixed price;

  late final _methodData =
      _transaction.walletInteractionInfo?.method.toRepresentableData();

  final TonWalletOrdinaryTransaction _transaction;

  ColorsPaletteV2 get colors => _theme.colors;

  TextStylesV2 get textStyles => _theme.textStyles;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  void onPressedSeeInExplorer() {
    Navigator.of(context).pop();
    openBrowserUrl(
      model.getTransactionExplorerLink(_transaction.hash),
    );
  }
}
