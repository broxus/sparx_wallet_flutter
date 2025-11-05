import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class TokenWalletAssetModel extends ElementaryModel {
  TokenWalletAssetModel(
    ErrorHandler errorHandler,
    this._balanceStorage,
    this._balanceService,
    this._currencyConvertService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final BalanceStorageService _balanceStorage;
  final BalanceService _balanceService;
  final CurrencyConvertService _currencyConvertService;
  final NekotonRepository _nekotonRepository;

  // Streams and repository access
  Stream<List<TokenWalletState>> get tokenWalletsStream =>
      _nekotonRepository.tokenWalletsStream;

  NetworkGroup get currentNetworkGroup =>
      _nekotonRepository.currentTransport.transport.group;

  Future<void> retrySubscription(Address owner, Address rootTokenContract) =>
      _nekotonRepository.retryTokenSubscription(owner, rootTokenContract);

  // Balance service helpers
  Stream<Fixed> tokenWalletFiatStream({
    required Address owner,
    required Address rootTokenContract,
  }) => _balanceService.tokenWalletBalanceStream(
    owner: owner,
    rootTokenContract: rootTokenContract,
  );

  Money convert(Fixed balance) => _currencyConvertService.convert(balance);

  // Balance storage helpers
  AccountBalanceModel? readCached({
    required NetworkGroup group,
    required Address owner,
    required Address rootTokenContract,
  }) => _balanceStorage
      .getBalances(group)[owner]
      ?.tokenBalance(rootTokenContract);

  void writeCached({
    required NetworkGroup group,
    required Address owner,
    required Address rootTokenContract,
    required Money fiatBalance,
    required Money tokenBalance,
  }) {
    _balanceStorage.setBalances(
      group: group,
      accountAddress: owner,
      balance: AccountBalanceModel(
        rootTokenContract: rootTokenContract,
        fiatBalance: fiatBalance,
        tokenBalance: tokenBalance,
        isNative: false,
      ),
    );
  }
}
