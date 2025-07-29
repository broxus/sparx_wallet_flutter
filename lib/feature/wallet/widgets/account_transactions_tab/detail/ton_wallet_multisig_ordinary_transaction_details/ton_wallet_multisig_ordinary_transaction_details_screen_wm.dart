import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/colors_v2.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel
    tonWalletMultisigOrdinaryTransactionDetailsnWMFactory(
  BuildContext context, {
  required TonWalletMultisigOrdinaryTransaction transaction,
  required Fixed price,
  required KeyAccount account,
}) {
  return TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel(
    TonWalletMultisigOrdinaryTransactionDetailsScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
    transaction,
    price,
    account,
  );
}

/// [WidgetModel] для [TonWalletMultisigOrdinaryTransactionDetailsScreen]
class TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel
    extends CustomWidgetModel<TonWalletMultisigOrdinaryTransactionDetailsScreen,
        TonWalletMultisigOrdinaryTransactionDetailsScreenModel> {
  TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel(
    super.model,
    this._transaction,
    this.price,
    this.account,
  );

  final Fixed price;
  final KeyAccount account;
  final TonWalletMultisigOrdinaryTransaction _transaction;

  late final date = _transaction.date;
  late final isIncoming = !_transaction.isOutgoing;
  late final transactionFee = Money.fromBigIntWithCurrency(
    _transaction.fees,
    Currencies()[model.ticker]!,
  );
  late final transactionValue = Money.fromBigIntWithCurrency(
    _transaction.value,
    Currencies()[model.ticker]!,
  );
  late final transactionHash = _transaction.hash;
  late final transactionAddress = _transaction.address;
  late final transactionComment = _transaction.comment;
  late final info = _methodData?.$1;
  late final tonIconPath = model.tonIconPath;
  late final confirmations = _transaction.confirmations;
  late final custodians = _transaction.custodians;
  late final initiator = _transaction.creator;

  late final _methodData =
      _transaction.walletInteractionInfo?.method.toRepresentableData();

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  void onPressedSeeInExplorer() {
    Navigator.of(context).pop();
    model.openBrowserUrl(
      model.getTransactionExplorerLink(_transaction.hash),
    );
  }
}
