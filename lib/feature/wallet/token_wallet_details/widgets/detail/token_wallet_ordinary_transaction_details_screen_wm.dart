import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TokenWalletOrdinaryTransactionDetailsScreenWmParams {
  const TokenWalletOrdinaryTransactionDetailsScreenWmParams({
    required this.transaction,
    required this.tokenCurrency,
    required this.price,
    required this.rootTokenContract,
  });

  final TokenWalletOrdinaryTransaction transaction;
  final Currency tokenCurrency;
  final Fixed price;
  final Address rootTokenContract;
}

/// [WidgetModel] для [TokenWalletOrdinaryTransactionDetailsScreen]
@injectable
class TokenWalletOrdinaryTransactionDetailsScreenWidgetModel
    extends CustomWidgetModelParametrized<
        TokenWalletOrdinaryTransactionDetailsScreen,
        TokenWalletOrdinaryTransactionDetailsScreenModel,
        TokenWalletOrdinaryTransactionDetailsScreenWmParams> {
  TokenWalletOrdinaryTransactionDetailsScreenWidgetModel(
    super.model,
  );

  TokenWalletOrdinaryTransaction get transaction => wmParams.value.transaction;
  Currency get tokenCurrency => wmParams.value.tokenCurrency;
  Fixed get price => wmParams.value.price;
  Address get rootTokenContract => wmParams.value.rootTokenContract;

  late final moneyFee = Money.fromBigIntWithCurrency(
    wmParams.value.transaction.fees,
    Currencies()[model.nativeTokenTicker]!,
  );

  late final moneyValue = Money.fromBigIntWithCurrency(
    wmParams.value.transaction.value,
    wmParams.value.tokenCurrency,
  );

  late final tonIconPath = model.nativeTokenIcon;

  ThemeStyleV2 get theme => context.themeStyleV2;

  String? get logoURI => _asset?.logoURI;

  TokenContractAsset? get _asset => model.getMaybeGetTokenContract(
        wmParams.value.rootTokenContract,
      );

  void onPressedDetails() {
    Navigator.of(context).pop();
    openBrowserUrl(
      model.getTransactionExplorerLink(transaction.hash),
    );
  }
}
