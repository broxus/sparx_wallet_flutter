import 'dart:async';
import 'dart:ui';

import 'package:app/app/service/service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class AppStorageService extends AbstractStorageService {
  AppStorageService(
    @Named(container) this._storage,
  );

  static const String container = 'app_storage_service';

  final GetStorage _storage;

  @override
  Future<void> init() => GetStorage.init(container);

  @override
  Future<void> clear() async {
    try {
      await _storage.erase();
    } catch (_) {}
  }

  void addValue<T>(StorageKey key, T value) => _storage.write(key.value, value);

  T? getValue<T>(StorageKey key) => _storage.read<T>(key.value);

  void delete(StorageKey key) => _storage.remove(key.value);

  Stream<T?> getValueStream<T>(StorageKey key) {
    VoidCallback? cancel;
    final subject = BehaviorSubject.seeded(_storage.read<T>(key.value));

    subject
      ..onListen = () {
        cancel = _storage.listen(
          () {
            if (_storage.changes.containsKey(key.value)) {
              subject.add(_storage.changes[key.value] as T?);
            }
          },
        );
      }
      ..onCancel = () {
        cancel?.call();
        cancel = null;
      };

    return subject.stream;
  }
}

class StorageKey {
  factory StorageKey.userWithNewWallet() => StorageKey._('userWithNewWallet');

  factory StorageKey.showingNewTokensLabel(String masterKey) =>
      StorageKey._('showingNewTokensLabel', masterKey);

  factory StorageKey.showingManualBackupBadge(String masterKey) =>
      StorageKey._('showingManualBackupBadge', masterKey);

  factory StorageKey.accountColor(String key) =>
      StorageKey._('accountColor', key);

  factory StorageKey.nameCustodian(String publicKey) =>
      StorageKey._('nameCustodian', publicKey);

  factory StorageKey.nftGridMode() => StorageKey._('nftGridMode');

  StorageKey._(this._baseKey, [this._entityKey]);

  final String _baseKey;
  final String? _entityKey;

  String get value => toString();

  @override
  String toString() {
    if (_entityKey == null) return _baseKey;
    return 'sparx:$_baseKey:$_entityKey';
  }
}
