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
    @Named(metadataContainer) this._metadataStorage,
    @Named(generalContainer) this._generalStorage,
  );

  static const String metadataContainer = 'nft_storage_service_metadata';
  static const String generalContainer = 'nft_storage_service_general';
  static const containers = [
    metadataContainer,
    generalContainer,
  ];

  final GetStorage _metadataStorage;
  final GetStorage _generalStorage;

  final _metadataSubject =
      BehaviorSubject<Map<Address, List<CollectionMeta>>>();
  final _pendingNftSubject = BehaviorSubject<List<PendingNft>>();

  Stream<Map<Address, List<CollectionMeta>>> get metadataStream =>
      _metadataSubject.stream;

  Stream<List<PendingNft>> get pendingNftStream => _pendingNftSubject.stream;

  List<PendingNft> get pendingNft => _pendingNftSubject.valueOrNull ?? [];

  @override
  Future<void> init() async {
    await GetStorage.init(metadataContainer);
    _streamedMetadata();
    _streamedPendingNfts();
  }

  @override
  Future<void> clear() async {
    try {
      await _metadataStorage.erase();
    } catch (_) {}
  }

  /// Reads the metadata from storage and returns it as a map.
  /// The map's keys are account addresses
  Map<Address, List<CollectionMeta>> readMetadata() {
    final encoded = _metadataStorage.getEntries();

    return Map<Address, List<CollectionMeta>>.fromEntries(
      encoded.entries.map(
        (entry) => MapEntry(
          Address(address: entry.key),
          (entry.value as List<dynamic>)
              .map(
                (e) => CollectionMeta.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void setMetadata({
    required Address account,
    required List<CollectionMeta> metadata,
  }) {
    _metadataStorage.write(
      account.address,
      metadata.map((e) => e.toJson()).toList(),
    );

    _streamedMetadata();
  }

  void addMetadata({
    required Address account,
    required CollectionMeta collectionMeta,
  }) {
    final currentList = _metadataSubject.value[account] ?? [];
    final updatedList = [
      ...currentList.whereNot(
        (e) =>
            e.collection == collectionMeta.collection &&
            e.networkGroup == collectionMeta.networkGroup,
      ),
      collectionMeta,
    ];

    _metadataStorage.write(
      account.address,
      updatedList.map((e) => e.toJson()).toList(),
    );

    _streamedMetadata();
  }

  void removeMetadata({
    required Address account,
    required Address collection,
    required NetworkGroup networkGroup,
  }) {
    final currentList = _metadataSubject.value[account] ?? [];
    final updatedList = currentList.whereNot(
      (e) => e.collection == collection && e.networkGroup == networkGroup,
    );

    _metadataStorage.write(
      account.address,
      updatedList.map((e) => e.toJson()).toList(),
    );

    _streamedMetadata();
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

  List<PendingNft> readPendingNfts() {
    final encoded = _generalStorage.read<List<dynamic>>(_pendingNftsKey) ?? [];
    return encoded
        .map((e) => PendingNft.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  void addPendingNft(PendingNft pendingNft) {
    final currentList = _pendingNftSubject.valueOrNull ?? [];
    final updatedList = [
      ...currentList.whereNot((e) => e == pendingNft),
      pendingNft,
    ];

    _generalStorage.write(
      _pendingNftsKey,
      updatedList.map((e) => e.toJson()).toList(),
    );
    _pendingNftSubject.add(updatedList);
  }

  List<PendingNft> removePendingNftByCollection({
    required Address owner,
    required Address collection,
    required NetworkGroup networkGroup,
  }) {
    final currentList = _pendingNftSubject.valueOrNull ?? [];

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

  void _streamedMetadata() => _metadataSubject.add(readMetadata());

  void _streamedPendingNfts() => _pendingNftSubject.add(readPendingNfts());
}

class _LatestLtKey {
  _LatestLtKey({
    required this.address,
    required this.networkGroup,
  });

  final Address address;
  final NetworkGroup networkGroup;

  @override
  String toString() => 'lt::$networkGroup::${address.toRaw()}';
}
