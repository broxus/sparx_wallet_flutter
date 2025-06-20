import 'package:app/core/wm/custom_wm.dart';
import 'package:injectable/injectable.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/colors_v2.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

class TonWalletMultisigOrdinaryTransactionDetailsWmParams {
  TonWalletMultisigOrdinaryTransactionDetailsWmParams({
    required this.price,
    required this.account,
    required this.transaction,
  });

  final Fixed price;
  final KeyAccount account;
  final TonWalletMultisigOrdinaryTransaction transaction;
}

/// [WidgetModel] для [TonWalletMultisigOrdinaryTransactionDetailsScreen]
@injectable
class TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel
    extends CustomWidgetModel<TonWalletMultisigOrdinaryTransactionDetailsScreen,
        TonWalletMultisigOrdinaryTransactionDetailsScreenModel> {
  TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final TonWalletMultisigOrdinaryTransactionDetailsWmParams _wmParams;
  TonWalletMultisigOrdinaryTransaction get _transaction =>
      _wmParams.transaction;

  KeyAccount get account => _wmParams.account;
  Fixed get price => _wmParams.price;

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
    openBrowserUrl(
      model.getTransactionExplorerLink(_transaction.hash),
    );
  }
}
