import 'package:app/app/service/service.dart';
import 'package:app/feature/root/domain/root_tab_service.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
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

  Stream<RootTab> get shouldScrollTopStream => _rootTabRepository
      .scrollTabToTopSubject
      .where((tab) => tab == RootTab.wallet);

  @override
  void init() {
    super.init();
    _assetsService.updateDefaultAssets();
  }

  bool? isShowingNewTokens(KeyAccount account) {
    final address = account.address;

    return _storageService.getValue(
      StorageKey.showingNewTokensLabel(address.address),
    );
  }

  void hideNewTokenLabels(KeyAccount account) {
    final address = account.address;

    return _storageService.addValue(
      StorageKey.showingNewTokensLabel(address.address),
      false,
    );
  }

  Stream<TonWalletState?> getWalletStream(Address address) => _nekotonRepository
      .walletsMapStream
      .map((wallets) => wallets[address])
      .distinct();

  bool handleUser(KeyAccount account) {
    final isNewUser = _storageService.getValue<bool?>(
      StorageKey.userWithNewWallet(),
    );

    bool? isShowingNewTokens;

    if (isNewUser == null) {
      final address = account.address;

      isShowingNewTokens =
          _storageService.getValue(
            StorageKey.showingNewTokensLabel(address.address),
          ) ??
          true;
    } else {
      isShowingNewTokens = true;

      if (!isNewUser) {
        _hideShowingBadge(account);
      }

      _storageService.delete(StorageKey.userWithNewWallet());
    }

    return isShowingNewTokens;
  }

  void _hideShowingBadge(KeyAccount account) {
    final masterPublicKey = _nekotonRepository.seedList
        .findSeedByAnyPublicKey(account.publicKey)
        ?.masterPublicKey;

    if (masterPublicKey == null) return;

    return _storageService.addValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
      false,
    );
  }
}
