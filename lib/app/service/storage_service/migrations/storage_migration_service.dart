import 'package:app/app/service/service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v5.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v6.dart';
import 'package:app/database/database_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_history_storage_service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

final _logger = Logger('StorageMigrationService');

const _version = 6;
const _versionKey = 'version';

class StorageMigrationService {
  StorageMigrationService(
    this._encryptedStorage,
    this._presetsConnectionService,
    this._generalStorageService,
    this._connectionsStorageService,
    @Named(BrowserHistoryStorageService.container) this._historyStorage,
    this._databaseService,
  ) : _storage = GetStorage();

  static Future<void> applyMigrations(
    EncryptedStorage encryptedStorage,
    PresetsConnectionService presetsConnectionService,
    GeneralStorageService generalStorageService,
    ConnectionsStorageService connectionsStorageService,
    @Named(BrowserHistoryStorageService.container) GetStorage historyStorage,
    DatabaseService databaseService,
  ) async =>
      StorageMigrationService(
        encryptedStorage,
        presetsConnectionService,
        generalStorageService,
        connectionsStorageService,
        historyStorage,
        databaseService,
      ).migrate();

  final GetStorage _storage;
  final GetStorage _historyStorage;
  final EncryptedStorage _encryptedStorage;

  final PresetsConnectionService _presetsConnectionService;
  final GeneralStorageService _generalStorageService;
  final ConnectionsStorageService _connectionsStorageService;
  final DatabaseService _databaseService;

  int get currentVersion => _storage.read<int>(_versionKey) ?? 0;

  bool get needMigration => currentVersion < _version;

  Future<void> migrate() async {
    await GetStorage.init();

    if (!needMigration) return;

    final migrations = _getMigrations();

    try {
      for (final migration in migrations) {
        await migration.apply();
        await migration.complete();
      }
    } catch (e, t) {
      _logger.severe('migrate', e, t);
    } finally {
      await _storage.write(_versionKey, _version);
    }
  }

  Iterable<StorageMigration> _getMigrations() sync* {
    if (currentVersion < StorageMigrationV1.version) {
      yield StorageMigrationV1(encryptedStorage: _encryptedStorage);
    }
    if (currentVersion < StorageMigrationV2.version) {
      yield StorageMigrationV2();
    }
    if (currentVersion < StorageMigrationV3.version) {
      yield StorageMigrationV3();
    }
    if (currentVersion < StorageMigrationV4.version) {
      yield StorageMigrationV4(
        _presetsConnectionService,
      );
    }
    if (currentVersion < StorageMigrationV5.version) {
      yield StorageMigrationV5(
        _generalStorageService,
        _connectionsStorageService,
      );
    }
    if (currentVersion < StorageMigrationV6.version) {
      yield StorageMigrationV6(
        _historyStorage,
        _databaseService,
      );
    }
  }
}
