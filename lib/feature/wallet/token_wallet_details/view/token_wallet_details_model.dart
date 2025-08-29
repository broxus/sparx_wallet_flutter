import 'package:app/app/service/service.dart';
import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class TokenWalletDetailsModel extends ElementaryModel {
  TokenWalletDetailsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currencyConvertService,
    this._balanceService,
    this._assetsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrencyConvertService _currencyConvertService;
  final BalanceService _balanceService;
  final AssetsService _assetsService;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  KeyAccount? findAccountByAddress(Address owner) =>
      _nekotonRepository.seedList.findAccountByAddress(owner);

  TokenContractAsset? maybeGetTokenContract(
    Address rootTokenContract,
    TransportStrategy transport,
  ) =>
      _assetsService.maybeGetTokenContract(rootTokenContract, transport);

  Stream<List<TokenWalletState>> get tokenWalletsStream =>
      _nekotonRepository.tokenWalletsStream;

  Future<void> retryTokenSubscription(
    Address owner,
    Address rootTokenContract,
  ) =>
      _nekotonRepository.retryTokenSubscription(owner, rootTokenContract);

  Future<List<PublicKey>?> getLocalCustodians(Address owner) async {
    try {
      return await _nekotonRepository.getLocalCustodians(owner);
    } catch (_) {
      return null;
    }
  }

  Money convertFiat(Fixed usdAmount, {Currency? currency}) =>
      _currencyConvertService.convert(usdAmount, currency: currency);

  Stream<Fixed> tokenWalletBalanceStream({
    required Address owner,
    required Address rootTokenContract,
  }) =>
      _balanceService.tokenWalletBalanceStream(
        owner: owner,
        rootTokenContract: rootTokenContract,
      );
}
