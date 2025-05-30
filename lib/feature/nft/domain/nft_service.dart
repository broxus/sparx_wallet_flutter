import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class NftService {
  NftService(
    this._nekotonRepository,
    this._nftStorageService,
    this._appStorageService,
    this._currentAccountsService,
  );

  static final _logger = Logger('NftService');

  final NekotonRepository _nekotonRepository;
  final NftStorageService _nftStorageService;
  final AppStorageService _appStorageService;
  final CurrentAccountsService _currentAccountsService;

  final Map<Address, NftCollection> _collections = {};
  KeyAccount? _currentSubscribedAccount;
  StreamSubscription<KeyAccount?>? _subscription;

  Stream<NftDisplayMode?> get displayModeStream =>
      _appStorageService.getValueStream<String>(StorageKey.nftGridMode()).map(
            (name) => switch (name) {
              'grid' => NftDisplayMode.grid,
              'list' => NftDisplayMode.list,
              _ => null,
            },
          );

  void init() {
    _subscription = _currentAccountsService.currentActiveAccountStream.listen(
      (account) async {
        if (_currentSubscribedAccount != null) {
          _nekotonRepository.unsubscribeFromWalletNftTransfers(
            _currentSubscribedAccount!.address,
          );
          _currentSubscribedAccount = null;
        }

        if (account != null) {
          final wallet = await _nekotonRepository.getWallet(account.address);

          if (wallet.wallet != null) {
            _nekotonRepository.subscribeToWalletNftTransfers(wallet.wallet!);
            _currentSubscribedAccount = account;
          }
        }
      },
    );
  }

  void dispose() {
    if (_currentSubscribedAccount != null) {
      _nekotonRepository.unsubscribeFromWalletNftTransfers(
        _currentSubscribedAccount!.address,
      );
    }

    _subscription?.cancel();
    _subscription = null;
    _currentSubscribedAccount = null;
  }

  void setDisplayMode(NftDisplayMode mode) {
    _appStorageService.addValue(StorageKey.nftGridMode(), mode.name);
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

  Stream<NftTransferEvent> getNftTransferEventStream({
    required Address owner,
    Address? collection,
  }) {
    return _nekotonRepository.nftTransferEventStream.where(
      (event) =>
          (collection == null || event.collection == collection) &&
          (event.sender == owner || event.recipient == owner),
    );
  }

  Future<NftCollection?> getCollection(Address address) async {
    if (_collections.containsKey(address)) {
      return _collections[address];
    }

    try {
      final collection = await _nekotonRepository.getNftCollection(address);
      _collections[address] = collection;
      return collection;
    } catch (e) {
      _logger.warning('Failed to get NFT collection for address $address: $e');
      return null;
    }
  }

  Future<NftItem?> getNftItem({
    required Address address,
    required Address owner,
  }) async {
    try {
      final item = await _nekotonRepository.getNftItem(
        address: address,
        owner: owner,
      );
      return item;
    } catch (e) {
      _logger.warning(
        'Failed to get NFT item for address $address (owner: $owner): $e',
      );
      return null;
    }
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

  void addCollection({
    required Address account,
    required Address collection,
  }) {
    _nftStorageService.addMetadata(
      account: account,
      collectionMeta: CollectionMeta(
        collection: collection,
        networkGroup: _nekotonRepository.currentTransport.networkGroup,
      ),
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
