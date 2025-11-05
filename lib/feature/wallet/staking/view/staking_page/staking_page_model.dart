import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/staking/staking.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class StakingPageModel extends ElementaryModel {
  StakingPageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currenciesService,
    this._stakingService,
    this._assetsService,
    this._storage,
  ) : super(errorHandler: errorHandler) {
    _stakingService.resetCache();
  }

  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final StakingService _stakingService;
  final AssetsService _assetsService;
  final GeneralStorageService _storage;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Currency get nativeCurrency => Currencies()[transport.nativeTokenTicker]!;

  StakingInformation get staking {
    if (transport.stakeInformation == null) {
      throw Exception('Stake information is not available');
    }
    return transport.stakeInformation!;
  }

  bool get getWasStEverOpened => _storage.getWasStEverOpened;

  void saveWasStEverOpened() => _storage.saveWasStEverOpened();

  Stream<List<StEverWithdrawRequest>> getWithdrawRequests(Address address) =>
      _stakingService.withdrawRequestsStream(address);

  Future<TonWalletState> getWallet(Address address) =>
      _nekotonRepository.getWallet(address);

  Future<TokenWalletState> getTokenWallet(Address owner) => _nekotonRepository
      .getTokenWallet(owner, staking.stakingRootContractAddress);

  Future<CustomCurrency?> getTokenCurrency() => _currenciesService
      .getOrFetchCurrency(transport, staking.stakingRootContractAddress);

  Future<CustomCurrency?> getEverCurrency() =>
      _currenciesService.getOrFetchNativeCurrency(transport);

  Future<double> getAverageAPYPercent() =>
      _stakingService.getAverageAPYPercent();

  Future<StEverDetails> getStEverDetails() =>
      _stakingService.getStEverDetails();

  Future<TokenContractAsset?> getTokenContractAsset() => _assetsService
      .getTokenContractAsset(staking.stakingRootContractAddress, transport);

  Future<BigInt> getDepositTokenAmount(BigInt value) =>
      _stakingService.getDepositStEverAmount(value);

  Future<BigInt> getWithdrawEverAmount(BigInt value) =>
      _stakingService.getWithdrawEverAmount(value);

  Future<String> depositEverBodyPayload(BigInt depositAmount) =>
      _stakingService.depositEverBodyPayload(depositAmount);

  Future<String> withdrawStEverPayload() =>
      _stakingService.withdrawStEverPayload();

  Future<StakingFees> computeFees() => _stakingService.computeFees();

  Future<void> tryAddTokenWallet(Address address) async {
    final rootContractAddress = staking.stakingRootContractAddress;
    final group = transport.transport.group;
    final account = _nekotonRepository.seedList.findAccountByAddress(address);
    final asset = account?.additionalAssets[group]?.tokenWallets
        .firstWhereOrNull((c) => c.rootTokenContract == rootContractAddress);

    if (asset != null || account == null) return;

    await account.addTokenWallet(rootContractAddress);
    // await _nekotonRepository.updateTokenSubscriptions([account.account]);
  }
}
