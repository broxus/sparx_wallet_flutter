import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

class TonWalletOrdinaryTransactionDetailsWmParams {
  TonWalletOrdinaryTransactionDetailsWmParams({
    required this.transaction,
    required this.price,
  });

  final TonWalletOrdinaryTransaction transaction;
  final Fixed price;
}

/// [WidgetModel] для [TonWalletOrdinaryTransactionDetails]
@injectable
class TonWalletOrdinaryTransactionDetailsWidgetModel extends CustomWidgetModel<
    TonWalletOrdinaryTransactionDetails,
    TonWalletOrdinaryTransactionDetailsModel> {
  TonWalletOrdinaryTransactionDetailsWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final TonWalletOrdinaryTransactionDetailsWmParams _wmParams;

  Fixed get price => _wmParams.price;

  late final date = _wmParams.transaction.date;
  late final isIncoming = !_wmParams.transaction.isOutgoing;

  late final Money transactionFee = Money.fromBigIntWithCurrency(
    _wmParams.transaction.fees,
    Currencies()[model.ticker]!,
  );

  late final Money transactionValue = Money.fromBigIntWithCurrency(
    _wmParams.transaction.value,
    Currencies()[model.ticker]!,
  );

  late final transactionHash = _wmParams.transaction.hash;

  late final transactionAddress = _wmParams.transaction.address;

  late final transactionComment = _wmParams.transaction.comment;

  late final transactionInfo = _methodData?.$1;

  late final tonIconPath = model.tonIconPath;

  late final _methodData =
      _wmParams.transaction.walletInteractionInfo?.method.toRepresentableData();

  ColorsPaletteV2 get colors => _theme.colors;

  TextStylesV2 get textStyles => _theme.textStyles;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  double get bottomPadding => MediaQuery.of(context).padding.bottom;

  void onPressedSeeInExplorer() {
    Navigator.of(context).pop();
    openBrowserUrl(
      model.getTransactionExplorerLink(_wmParams.transaction.hash),
    );
  }
}
