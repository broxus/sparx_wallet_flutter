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
    this._currentAccountsService,
  );

  static final _logger = Logger('NftService');

  final NekotonRepository _nekotonRepository;
  final NftStorageService _nftStorageService;
  final CurrentAccountsService _currentAccountsService;

  final Map<Address, NftCollection> _collections = {};
  KeyAccount? _currentSubscribedAccount;
  StreamSubscription<KeyAccount?>? _accountSubscription;
  StreamSubscription<NftTransferEvent>? _nftTransferSubscription;

  void init() {
    _accountSubscription = _currentAccountsService.currentActiveAccountStream
        .listen(_handleAccount);
    _nftTransferSubscription = _nekotonRepository.nftTransferEventStream.listen(
      _handleTransferEvent,
    );
  }

  void dispose() {
    if (_currentSubscribedAccount != null) {
      _nekotonRepository.unsubscribeFromWalletNftTransfers(
        _currentSubscribedAccount!.address,
      );
    }

    _accountSubscription?.cancel();
    _nftTransferSubscription?.cancel();
    _accountSubscription = null;
    _nftTransferSubscription = null;
    _currentSubscribedAccount = null;
  }

  Stream<List<NftCollectionSettings>> getAccountCollectionsMetaStream(
    Address owner,
  ) {
    return Rx.combineLatest2(
      _nekotonRepository.currentTransportStream
          .map((e) => e.networkGroup)
          .distinct(),
      _nftStorageService.collectionsStream,
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
          .map((meta) => _collections[meta.address])
          .nonNulls
          .sortedBy((c) => c.name ?? '')
          .toList(),
    );
  }

  Stream<List<PendingNft>> getAccountPendingNftsStream(Address owner) {
    return Rx.combineLatest2(
      _nekotonRepository.currentTransportStream
          .map((e) => e.networkGroup)
          .distinct(),
      _nftStorageService.pendingNftStream,
      (group, pendingNft) {
        return pendingNft
            .where((e) => e.networkGroup == group && e.owner == owner)
            .toList();
      },
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
    final defaultCollections =
        _nekotonRepository.currentTransport.nftInformation?.defaultCollections;

    final cachedCollections = _nftStorageService.getCollections(
      owner,
      networkGroup,
    );

    final hiddenAddresses = <Address>[];
    final cachedCollectionsAddresses = <Address>{};

    for (final c in cachedCollections) {
      if (!c.isVisible) {
        hiddenAddresses.add(c.address);
      }
      cachedCollectionsAddresses.add(c.address);
    }

    final pending = _nftStorageService.getPendingNftAddresses(
      owner,
      networkGroup,
    );

    final scannedCollections = await _nekotonRepository.scanNftCollections(
      owner: owner,
      collections: {
        ...?defaultCollections,
        ...cachedCollectionsAddresses,
        ...pending,
      }.toList(), // remove possible duplicates
    );

    for (final collection in scannedCollections) {
      _collections[collection.address] = collection;
    }

    _nftStorageService.setCollections(
      accountAddress: owner,
      collections: scannedCollections
          .map(
            (e) => NftCollectionSettings(
              address: e.address,
              networkGroup: networkGroup,
              isVisible: !hiddenAddresses.contains(e.address),
            ),
          )
          .toList(),
    );
  }

  void addCollection({
    required Address accountAddress,
    required Address collectionAddress,
  }) {
    _nftStorageService.addCollection(
      accountAddress: accountAddress,
      collection: NftCollectionSettings(
        address: collectionAddress,
        networkGroup: _nekotonRepository.currentTransport.networkGroup,
      ),
    );
  }

  void hideCollection({
    required Address accountAddress,
    required Address collectionAddress,
  }) {
    _nftStorageService.addCollection(
      accountAddress: accountAddress,
      collection: NftCollectionSettings(
        address: collectionAddress,
        networkGroup: _nekotonRepository.currentTransport.networkGroup,
        isVisible: false,
      ),
    );
  }

  Future<void> _handleAccount(KeyAccount? account) async {
    if (_currentSubscribedAccount != null) {
      _nekotonRepository.unsubscribeFromWalletNftTransfers(
        _currentSubscribedAccount!.address,
      );
      _currentSubscribedAccount = null;
    }

    if (account != null) {
      final wallet = await _nekotonRepository.getWallet(account.address);

      if (wallet.wallet != null) {
        final tracker = TonWalletLatestLtTracker(
          address: account.address,
          networkGroup: _nekotonRepository.currentTransport.networkGroup,
          nftStorageService: _nftStorageService,
        );

        _nekotonRepository.subscribeToWalletNftTransfers(
          wallet: wallet.wallet!,
          tracker: tracker,
        );
        _currentSubscribedAccount = account;
      }
    }
  }

  void _handleTransferEvent(NftTransferEvent event) {
    if (event.direction == TransferDirection.incoming) {
      _nftStorageService.addPendingNft(
        PendingNft(
          id: event.id,
          collection: event.collection,
          owner: event.recipient,
          networkGroup: _nekotonRepository.currentTransport.networkGroup,
        ),
      );
    } else {
      _nftStorageService.removePendingNft(
        id: event.id,
        owner: event.sender,
        collection: event.collection,
        networkGroup: _nekotonRepository.currentTransport.networkGroup,
      );
    }
  }
}
