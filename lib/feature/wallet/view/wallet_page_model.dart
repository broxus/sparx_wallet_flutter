import 'package:app/app/service/service.dart';
import 'package:app/feature/root/domain/root_tab_service.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

class WalletPageModel extends ElementaryModel {
  WalletPageModel(
    ErrorHandler errorHandler,
    this._assetsService,
    this._currentAccountsService,
    this._storageService,
    this._nekotonRepository,
    this._rootTabRepository,
  ) : super(errorHandler: errorHandler);

  final AssetsService _assetsService;
  final CurrentAccountsService _currentAccountsService;
  final AppStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final RootTabService _rootTabRepository;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream;

  Stream<TransportStrategy> get transportStrategy =>
      _nekotonRepository.currentTransportStream;

  Stream<RootTab> get shouldScrollTopStream =>
      _rootTabRepository.scrollTabToTopSubject.where(
        (tab) => tab == RootTab.wallet,
      );

  @override
  void init() {
    super.init();
    _assetsService.updateDefaultAssets();
  }

  bool? isNewUser() {
    return _storageService.getValue(StorageKey.userWithNewWallet());
  }

  void resetValueNewUser() {
    _storageService.delete(StorageKey.userWithNewWallet());
  }

  bool? isShowingNewTokens(KeyAccount account) {
    final address = account.address;

    return _storageService.getValue(
      StorageKey.showingNewTokensLabel(address.address),
    );
  }

  void hideShowingBadge(KeyAccount account) {
    final masterPublicKey = _nekotonRepository.seedList
        .findSeedByAnyPublicKey(account.publicKey)
        ?.masterPublicKey;

    if (masterPublicKey == null) return;

    return _storageService.addValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
      false,
    );
  }

  void hideNewTokenLabels(KeyAccount account) {
    final address = account.address;

    return _storageService.addValue(
      StorageKey.showingNewTokensLabel(address.address),
      false,
    );
  }

  Future<TonWalletState> getTonWalletState(Address? address) async {
    final wallet = await _nekotonRepository.walletsMapStream
        .mapNotNull((wallets) => wallets[address])
        .first;
    return wallet;
  }
}
