import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:injectable/injectable.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
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
    extends CustomWidgetModel<TokenWalletOrdinaryTransactionDetailsScreen,
        TokenWalletOrdinaryTransactionDetailsScreenModel> {
  TokenWalletOrdinaryTransactionDetailsScreenWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final TokenWalletOrdinaryTransactionDetailsScreenWmParams _wmParams;

  TokenWalletOrdinaryTransaction get transaction => _wmParams.transaction;
  Currency get tokenCurrency => _wmParams.tokenCurrency;
  Fixed get price => _wmParams.price;
  Address get rootTokenContract => _wmParams.rootTokenContract;

  late final moneyFee = Money.fromBigIntWithCurrency(
    _wmParams.transaction.fees,
    Currencies()[model.nativeTokenTicker]!,
  );

  late final moneyValue = Money.fromBigIntWithCurrency(
    _wmParams.transaction.value,
    _wmParams.tokenCurrency,
  );

  late final tonIconPath = model.nativeTokenIcon;

  ThemeStyleV2 get theme => context.themeStyleV2;

  String? get logoURI => _asset?.logoURI;

  TokenContractAsset? get _asset => model.getMaybeGetTokenContract(
        _wmParams.rootTokenContract,
      );
}
