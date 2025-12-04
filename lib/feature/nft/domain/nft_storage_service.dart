import 'package:app/app/service/service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show Address;
import 'package:rxdart/rxdart.dart';

const _pendingNftsKey = 'pending_nfts';

@singleton
class NftStorageService extends AbstractStorageService {
  NftStorageService(
    @Named(collectionsContainer) this._collectionsStorage,
    @Named(generalContainer) this._generalStorage,
  );

  static const String collectionsContainer = 'nft_storage_service_metadata';
  static const String generalContainer = 'nft_storage_service_general';
  static const containers = [collectionsContainer, generalContainer];

  final GetStorage _collectionsStorage;
  final GetStorage _generalStorage;

  final _collectionsSubject =
      BehaviorSubject<Map<Address, List<NftCollectionSettings>>>();
  final _pendingNftSubject = BehaviorSubject<List<PendingNft>>();

  Stream<Map<Address, List<NftCollectionSettings>>> get collectionsStream =>
      _collectionsSubject.stream;

  Stream<List<PendingNft>> get pendingNftStream => _pendingNftSubject.stream;

  List<PendingNft> get _pendingNft => _pendingNftSubject.valueOrNull ?? [];

  Map<Address, List<NftCollectionSettings>> get _collectionsData =>
      _collectionsSubject.valueOrNull ?? {};

  @override
  Future<void> init() async {
    await Future.wait(containers.map(GetStorage.init));
    _collectionsSubject.add(_readCollections());
    _pendingNftSubject.add(_readPendingNfts());
  }

  @override
  Future<void> clear() async {
    try {
      _collectionsSubject.add({});
      _pendingNftSubject.add([]);
      await _collectionsStorage.erase();
      await _generalStorage.erase();
    } catch (_) {}
  }

  void setCollections({
    required Address accountAddress,
    required List<NftCollectionSettings> collections,
  }) {
    _collectionsStorage.write(
      accountAddress.address,
      collections.map((e) => e.toJson()).toList(),
    );

    _collectionsSubject.add({..._collectionsData, accountAddress: collections});
  }

  void addCollection({
    required Address accountAddress,
    required NftCollectionSettings collection,
  }) {
    final currentList = _collectionsData[accountAddress] ?? [];
    final updatedList = [
      ...currentList.whereNot(
        (e) =>
            e.collection == collection.collection &&
            e.networkGroup == collection.networkGroup,
      ),
      collection,
    ];

    setCollections(accountAddress: accountAddress, collections: updatedList);
  }

  void removeCollection({
    required Address accountAddress,
    required Address collectionAddress,
    required NetworkGroup networkGroup,
  }) {
    final currentList = _collectionsData[accountAddress] ?? [];
    final updatedList = currentList.whereNot(
      (e) =>
          e.collection == collectionAddress && e.networkGroup == networkGroup,
    );

    setCollections(
      accountAddress: accountAddress,
      collections: updatedList.toList(),
    );
  }

  BigInt? readLatestLt({
    required Address address,
    required NetworkGroup networkGroup,
  }) {
    final key = _LatestLtKey(address: address, networkGroup: networkGroup);
    final value = _generalStorage.read<String>(key.toString());

    return value != null ? BigInt.tryParse(value) : null;
  }

  void writeLatestLt({
    required Address address,
    required NetworkGroup networkGroup,
    required BigInt lt,
  }) {
    final key = _LatestLtKey(address: address, networkGroup: networkGroup);
    _generalStorage.write(key.toString(), lt.toString());
  }

  void addPendingNft(PendingNft pendingNft) {
    final updatedList = [
      ..._pendingNft.whereNot((e) => e == pendingNft),
      pendingNft,
    ];

    _generalStorage.write(
      _pendingNftsKey,
      updatedList.map((e) => e.toJson()).toList(),
    );
    _pendingNftSubject.add(updatedList);
  }

  PendingNft? removePendingNft({
    required String id,
    required Address owner,
    required Address collection,
    required NetworkGroup networkGroup,
  }) {
    // Partition the list into items to remove and items to keep
    PendingNft? removed;

    for (final e in _pendingNft) {
      if (e.id == id &&
          e.owner == owner &&
          e.collection == collection &&
          e.networkGroup == networkGroup) {
        removed = e;
        break;
      }
    }

    if (removed != null) {
      final updatedList = _pendingNft.whereNot((e) => e == removed).toList();

      _generalStorage.write(
        _pendingNftsKey,
        updatedList.map((e) => e.toJson()).toList(),
      );
      _pendingNftSubject.add(updatedList);
    }

    return removed;
  }

  List<PendingNft> removePendingNftByCollection({
    required Address owner,
    required Address collection,
    required NetworkGroup networkGroup,
  }) {
    final currentList = [..._pendingNft];

    // Partition the list into items to remove and items to keep
    final removed = <PendingNft>[];
    final updatedList = <PendingNft>[];

    for (final e in currentList) {
      if (e.owner == owner &&
          e.collection == collection &&
          e.networkGroup == networkGroup) {
        removed.add(e);
      } else {
        updatedList.add(e);
      }
    }

    if (removed.isNotEmpty) {
      _generalStorage.write(
        _pendingNftsKey,
        updatedList.map((e) => e.toJson()).toList(),
      );
      _pendingNftSubject.add(updatedList);
    }

    return removed;
  }

  List<NftCollectionSettings> getCollections(
    Address ownerAddress,
    NetworkGroup networkGroup,
  ) {
    return (_collectionsData[ownerAddress] ?? [])
        .where((e) => e.networkGroup == networkGroup)
        .toList();
  }

  Set<Address> getPendingNftAddresses(
    Address ownerAddress,
    NetworkGroup networkGroup,
  ) {
    return _pendingNft
        .where((e) => e.networkGroup == networkGroup && e.owner == ownerAddress)
        .map((e) => e.collection)
        .toSet();
  }

  /// Reads the collections from storage and returns it as a map.
  /// The map's keys are account addresses
  Map<Address, List<NftCollectionSettings>> _readCollections() {
    final encoded = _collectionsStorage.getEntries();

    return Map<Address, List<NftCollectionSettings>>.fromEntries(
      encoded.entries.map(
        (entry) => MapEntry(
          Address(address: entry.key),
          (entry.value as List<dynamic>)
              .map(
                (e) =>
                    NftCollectionSettings.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      ),
    );
  }

  List<PendingNft> _readPendingNfts() {
    final encoded = _generalStorage.read<List<dynamic>>(_pendingNftsKey) ?? [];
    return encoded
        .map((e) => PendingNft.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class _LatestLtKey {
  _LatestLtKey({required this.address, required this.networkGroup});

  final Address address;
  final NetworkGroup networkGroup;

  @override
  String toString() => 'lt::$networkGroup::${address.toRaw()}';
}
