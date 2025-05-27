import 'package:app/app/service/service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class NftService {
  NftService(
    this._nekotonRepository,
    this._nftStorageService,
    this._appStorageService,
  );

  final NekotonRepository _nekotonRepository;
  final NftStorageService _nftStorageService;
  final AppStorageService _appStorageService;

  final Map<Address, NftCollection> _collections = {};

  Stream<NftDisplayMode?> get displayModeStream => _appStorageService
      .getValueStream<NftDisplayMode>(StorageKey.nftGridMode());

  void setDisplayMode(NftDisplayMode mode) {
    _appStorageService.addValue(StorageKey.nftGridMode(), mode);
  }

  Stream<List<CollectionMeta>> getAccountCollectionsMetaStream(Address owner) {
    return Rx.combineLatest2(
      _nekotonRepository.currentTransportStream
          .map((e) => e.networkGroup)
          .distinct(),
      _nftStorageService.metadataStream,
      (group, metadata) {
        final collections = metadata[owner] ?? [];
        return collections
            .where((meta) => meta.networkGroup == group && meta.isVisible)
            .toList();
      },
    );
  }

  Stream<List<NftCollection>> getAccountCollectionsStream(Address owner) {
    return getAccountCollectionsMetaStream(owner).map(
      (e) => e
          .map((meta) => _collections[meta.collection])
          .nonNulls
          .sortedBy((c) => c.name)
          .toList(),
    );
  }

  Future<void> scanNftCollections(Address owner) async {
    final networkGroup = _nekotonRepository.currentTransport.networkGroup;
    // TODO: whitelist collections
    final whitelist = <Address>[];
    final meta = (_nftStorageService.readMetadata()[owner] ?? [])
        .where((e) => e.networkGroup == networkGroup);
    final hidden =
        meta.where((e) => !e.isVisible).map((e) => e.collection).toSet();

    final collections = [
      ...whitelist,
      ...meta.map((e) => e.collection),
    ];

    final scanned = await _nekotonRepository.scanNftCollections(
      owner: owner,
      collections: collections.toSet().toList(), // remove possible duplicates
    );

    for (final collection in scanned) {
      _collections[collection.address] = collection;
    }

    _nftStorageService.setMetadata(
      account: owner,
      metadata: scanned
          .map(
            (e) => CollectionMeta(
              collection: e.address,
              networkGroup: networkGroup,
              isVisible: !hidden.contains(e.address),
            ),
          )
          .toList(),
    );
  }

  void hideCollection({
    required Address account,
    required Address collection,
  }) {
    _nftStorageService.addMetadata(
      account: account,
      collectionMeta: CollectionMeta(
        collection: collection,
        networkGroup: _nekotonRepository.currentTransport.networkGroup,
        isVisible: false,
      ),
    );
  }
}
