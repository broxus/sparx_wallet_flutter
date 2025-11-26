import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v2/domain/browser_launcher.dart';
import 'package:app/feature/nft/domain/nft_display_mode_configurator.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class NftPageModel extends ElementaryModel {
  NftPageModel(
    ErrorHandler errorHandler,
    this._nftService,
    this._currentAccountsService,
    this._nekotonRepository,
    this._nftDisplayModeConfigurator,
    this._browserLauncher,
  ) : super(errorHandler: errorHandler);

  final NftService _nftService;
  final CurrentAccountsService _currentAccountsService;
  final NekotonRepository _nekotonRepository;
  final NftDisplayModeConfigurator _nftDisplayModeConfigurator;
  final BrowserLauncher _browserLauncher;

  Stream<Address> get _ownerStream => _currentAccountsService
      .currentActiveAccountStream
      .mapNotNull((e) => e?.address);

  StreamSubscription<Address>? _ownerStreamSub;

  Stream<KeyAccount?> get currentAccountStream =>
      _currentAccountsService.currentActiveAccountStream;

  Stream<TransportStrategy> get currentTransportStream =>
      _nekotonRepository.currentTransportStream;

  Stream<String?> get marketplaceUrlStream => _nekotonRepository
      .currentTransportStream
      .map((transport) => transport.nftInformation?.marketplaceUrl);

  Stream<NftDisplayMode?> get displayModeStream =>
      _nftDisplayModeConfigurator.displayModeStream;

  Stream<List<NftCollection>> get collectionsStream =>
      _ownerStream.switchMap(_nftService.getAccountCollectionsStream);

  Stream<List<PendingNft>> get pendingNftStream =>
      _ownerStream.switchMap(_nftService.getAccountPendingNftsStream);

  Stream<NftTransferEvent> get nftTransferEventStream => _ownerStream.switchMap(
    (owner) => _nftService.getNftTransferEventStream(owner: owner),
  );

  @override
  void dispose() {
    _ownerStreamSub?.cancel();
    super.dispose();
  }

  void setDisplayMode(NftDisplayMode mode) =>
      _nftDisplayModeConfigurator.setDisplayMode(mode);

  Future<void> scanNftCollections(Address owner) =>
      _nftService.scanNftCollections(owner);

  void addCollection({required Address account, required Address collection}) =>
      _nftService.addCollection(
        accountAddress: account,
        collectionAddress: collection,
      );

  void openBrowserByString(String marketplaceUrl) {
    _browserLauncher.openBrowserByString(marketplaceUrl);
  }
}
