import 'dart:convert';

import 'package:app/app/service/storage_service/storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageMigrationV1 implements StorageMigration {
  StorageMigrationV1(this._encryptedStorage, this._storageAdapter)
    : _fss = const FlutterSecureStorage();

  static const int version = 1;

  final FlutterSecureStorage _fss;
  final EncryptedStorage _encryptedStorage;
  final StorageAdapter _storageAdapter;

  List<String> get _domains => [
    ...GeneralStorageService.containers,
    ...BalanceStorageService.containers,
    ConnectionsStorageService.container,
    BrowserBookmarksStorageService.container,
    BrowserFaviconURLStorageService.container,
    BrowserPermissionsStorageService.container,
    BrowserTabsStorageService.container,
  ];

  @override
  Future<void> apply() async {
    await _migrateAppStorageService();

    for (final domain in _domains) {
      await _migrateEncryptedStorageDomain(domain);
    }
  }

  @override
  Future<void> complete() async {
    final entries = {...(await _fss.readAll()).entries};

    for (final entry in entries) {
      if (entry.key.startsWith('sparx:')) {
        await _fss.delete(key: entry.key);
      }
    }

    for (final domain in _domains) {
      await _encryptedStorage.clearDomain(domain);
    }
  }

  Future<void> _migrateAppStorageService() async {
    await _storageAdapter.init(AppStorageService.container);
    final storage = _storageAdapter.box(AppStorageService.container);

    for (final entry in (await _fss.readAll()).entries) {
      if (entry.key.startsWith('sparx:')) {
        final value = bool.tryParse(entry.value) ?? entry.value;

        await storage.write(entry.key, value);
      }
    }
  }

  Future<void> _migrateEncryptedStorageDomain(String domain) async {
    await _storageAdapter.init(domain);
    final storage = _storageAdapter.box(domain);

    final encoded = await _encryptedStorage.getDomain(domain: domain);

    for (final entry in encoded.entries) {
      await storage.write(entry.key, _tryDecode(entry.value));
    }
  }

  dynamic _tryDecode(String value) {
    try {
      final decoded = jsonDecode(value);
      return decoded;
    } catch (_) {}
    return value;
  }
}
