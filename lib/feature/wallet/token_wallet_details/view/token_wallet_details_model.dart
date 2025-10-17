import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/token_wallet_send/token_wallet_send.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class TokenWalletDetailsModel extends ElementaryModel {
  TokenWalletDetailsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currencyConvertService,
    this._balanceService,
    this._assetsService,
    this._tokenTransferDelegateProvider,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrencyConvertService _currencyConvertService;
  final BalanceService _balanceService;
  final AssetsService _assetsService;
  final TokenTransferDelegateProvider _tokenTransferDelegateProvider;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  KeyAccount? findAccountByAddress(Address owner) =>
      _nekotonRepository.seedList.findAccountByAddress(owner);

  SeedKey findMasterKeyByAccount(KeyAccount keyAccount) => _nekotonRepository
      .seedList
      .findSeedByAnyPublicKey(keyAccount.publicKey)!
      .masterKey;

  TokenContractAsset? maybeGetTokenContract(
    Address rootTokenContract,
    TransportStrategy transport,
  ) => _assetsService.maybeGetTokenContract(rootTokenContract, transport);

  Stream<List<TokenWalletState>> get tokenWalletsStream =>
      _nekotonRepository.tokenWalletsStream;

  Future<void> retryTokenSubscription(
    Address owner,
    Address rootTokenContract,
  ) => _nekotonRepository.retryTokenSubscription(owner, rootTokenContract);

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
  }) => _balanceService.tokenWalletBalanceStream(
    owner: owner,
    rootTokenContract: rootTokenContract,
  );

  Future<bool> isGaslessAvailable({
    required KeyAccount keyAccount,
    required Address rootTokenContract,
  }) => _tokenTransferDelegateProvider.isGaslessAvailable(
    keyAccount: keyAccount,
    rootTokenContract: rootTokenContract,
  );
}
