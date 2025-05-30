import 'package:app/app/service/service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

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

  Stream<NftDisplayMode?> get displayModeStream =>
      _nftService.displayModeStream;

  Future<Address> get _owner =>
      currentAccountStream.mapNotNull((e) => e?.address).first;

  Stream<NftTransferEvent> getNftTransferEventStream() =>
      _owner.asStream().switchMap(
            (owner) => _nftService.getNftTransferEventStream(owner: owner),
          );

  void setDisplayMode(NftDisplayMode mode) => _nftService.setDisplayMode(mode);

  Stream<List<NftCollection>> getAccountCollectionsStream(Address owner) =>
      _nftService.getAccountCollectionsStream(owner);

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
