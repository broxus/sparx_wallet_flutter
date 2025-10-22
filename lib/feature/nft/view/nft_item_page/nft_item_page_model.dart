import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v2/domain/browser_launcher.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@injectable
class NftItemPageModel extends ElementaryModel {
  NftItemPageModel(
    ErrorHandler errorHandler,
    this._nftService,
    this._currentAccountsService,
    this._nekotonRepository,
    this._browserLauncher,
  ) : super(errorHandler: errorHandler);

  final NftService _nftService;
  final CurrentAccountsService _currentAccountsService;
  final NekotonRepository _nekotonRepository;
  final BrowserLauncher _browserLauncher;

  Stream<String?> get marketplaceUrlStream => _nekotonRepository
      .currentTransportStream
      .map((transport) => transport.nftInformation?.marketplaceUrl);

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream;

  Future<Address> get _owner =>
      currentAccount.mapNotNull((e) => e?.address).first;

  Future<NftCollection?> getCollection(Address address) =>
      _nftService.getCollection(address);

  Future<NftItem?> getNftItem(Address address) async =>
      _nftService.getNftItem(address: address, owner: await _owner);

  void openExplorerLinkByBrowser(Address address) {
    _browserLauncher.openBrowserByString(
      _nekotonRepository.currentTransport.accountExplorerLink(address),
    );
  }

  void openBrowserUrl(String url) {
    _browserLauncher.openBrowserByString(url);
  }
}
