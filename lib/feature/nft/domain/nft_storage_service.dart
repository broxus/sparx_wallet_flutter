import 'package:app/app/service/service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show Address;
import 'package:rxdart/rxdart.dart';

@singleton
class NftStorageService extends AbstractStorageService {
  NftStorageService(
    @Named(container) this._storage,
  );

  static const String container = 'nft_storage_service';

  final GetStorage _storage;

  final _metadataSubject =
      BehaviorSubject<Map<Address, List<CollectionMeta>>>();

  Stream<Map<Address, List<CollectionMeta>>> get metadataStream =>
      _metadataSubject.stream;

  @override
  Future<void> init() async {
    await GetStorage.init(container);
    _streamedMetadata();
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.erase();
    } catch (_) {}
  }

  /// Reads the metadata from storage and returns it as a map.
  /// The map's keys are account addresses
  Map<Address, List<CollectionMeta>> readMetadata() {
    final encoded = _storage.getEntries();

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
    _storage.write(
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

    _storage.write(
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

    _storage.write(
      account.address,
      updatedList.map((e) => e.toJson()).toList(),
    );

    _streamedMetadata();
  }

  void _streamedMetadata() => _metadataSubject.add(readMetadata());
}
