import 'package:app/app/service/service.dart';
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
  ) : super(errorHandler: errorHandler);

  final NftService _nftService;
  final CurrentAccountsService _currentAccountsService;
  final NekotonRepository _nekotonRepository;

  Stream<KeyAccount?> get currentAccountStream =>
      _currentAccountsService.currentActiveAccountStream;

  Stream<TransportStrategy> get currentTransportStream =>
      _nekotonRepository.currentTransportStream;

  Stream<String?> get marketplaceUrlStream =>
      _nekotonRepository.currentTransportStream.map(
        (transport) => transport.nftInformation?.marketplaceUrl,
      );

  Stream<NftDisplayMode?> get displayModeStream =>
      _nftService.displayModeStream;

  Stream<Address> get _owner =>
      currentAccountStream.mapNotNull((e) => e?.address);

  Stream<NftTransferEvent> getNftTransferEventStream() => _owner.switchMap(
        (owner) => _nftService.getNftTransferEventStream(owner: owner),
      );

  Stream<List<PendingNft>> getPendingNftStream() =>
      _owner.switchMap(_nftService.getAccountPendingNftsStream);

  void setDisplayMode(NftDisplayMode mode) => _nftService.setDisplayMode(mode);

  Stream<List<NftCollection>> getCollectionsStream() =>
      _owner.switchMap(_nftService.getAccountCollectionsStream);

  Future<void> scanNftCollections(Address owner) =>
      _nftService.scanNftCollections(owner);

  void addCollection({
    required Address account,
    required Address collection,
  }) =>
      _nftService.addCollection(
        account: account,
        collection: collection,
      );
}
