import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

/// Factory method for creating
/// [TokenWalletOrdinaryTransactionDetailsScreenWidgetModel]
TokenWalletOrdinaryTransactionDetailsScreenWidgetModel
    defaultTokenWalletOrdinaryTransactionDetailsScreenWidgetModelFactory(
  BuildContext context, {
  required TokenWalletOrdinaryTransaction transaction,
  required Currency tokenCurrency,
  required Fixed price,
  required Address rootTokenContract,
}) {
  return TokenWalletOrdinaryTransactionDetailsScreenWidgetModel(
    TokenWalletOrdinaryTransactionDetailsScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
    transaction,
    price,
    tokenCurrency,
    rootTokenContract,
  );
}

/// [WidgetModel] для [TokenWalletOrdinaryTransactionDetailsScreen]
class TokenWalletOrdinaryTransactionDetailsScreenWidgetModel
    extends CustomWidgetModel<TokenWalletOrdinaryTransactionDetailsScreen,
        TokenWalletOrdinaryTransactionDetailsScreenModel> {
  TokenWalletOrdinaryTransactionDetailsScreenWidgetModel(
    super.model,
    this.transaction,
    this.price,
    this._tokenCurrency,
    this._rootTokenContract,
  );

  final TokenWalletOrdinaryTransaction transaction;
  final Fixed price;
  final Currency _tokenCurrency;
  final Address _rootTokenContract;

  late final moneyFee = Money.fromBigIntWithCurrency(
    transaction.fees,
    Currencies()[model.nativeTokenTicker]!,
  );

  late final moneyValue = Money.fromBigIntWithCurrency(
    transaction.value,
    _tokenCurrency,
  );

  late final tonIconPath = model.nativeTokenIcon;

  ThemeStyleV2 get theme => context.themeStyleV2;

  String? get logoURI => _asset?.logoURI;

  TokenContractAsset? get _asset => model.getMaybeGetTokenContract(
        _rootTokenContract,
      );

  void onPressedDetails() {
    Navigator.of(context).pop();
    openBrowserUrl(
      model.getTransactionExplorerLink(transaction.hash),
    );
  }
}
