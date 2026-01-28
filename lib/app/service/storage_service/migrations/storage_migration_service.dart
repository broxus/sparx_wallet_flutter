import 'package:app/app/service/database/database_service.dart';
import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:logging/logging.dart';

final _logger = Logger('StorageMigrationService');

const _version = 7;
const _versionKey = 'version';

class StorageMigrationService {
  StorageMigrationService(
    this._encryptedStorage,
    this._presetsConnectionService,
    this._generalStorageService,
    this._connectionsStorageService,
    this._databaseService,
    this._storageAdapter,
  ) : _storage = _storageAdapter.box();

  static Future<void> applyMigrations(
    EncryptedStorage encryptedStorage,
    PresetsConnectionService presetsConnectionService,
    GeneralStorageService generalStorageService,
    ConnectionsStorageService connectionsStorageService,
    DatabaseService databaseService,
    StorageAdapter storageAdapter,
  ) async => StorageMigrationService(
    encryptedStorage,
    presetsConnectionService,
    generalStorageService,
    connectionsStorageService,
    databaseService,
    storageAdapter,
  ).migrate();

  final StorageAdapter _storageAdapter;
  final StorageBox _storage;
  final EncryptedStorage _encryptedStorage;

  final PresetsConnectionService _presetsConnectionService;
  final GeneralStorageService _generalStorageService;
  final ConnectionsStorageService _connectionsStorageService;
  final DatabaseService _databaseService;

  int get currentVersion => _storage.read<int>(_versionKey) ?? 0;

  bool get needMigration => currentVersion < _version;

  Future<void> migrate() async {
    await _storageAdapter.init();

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
      yield StorageMigrationV1(_encryptedStorage, _storageAdapter);
    }
    if (currentVersion < StorageMigrationV2.version) {
      yield StorageMigrationV2(_storageAdapter);
    }
    if (currentVersion < StorageMigrationV3.version) {
      yield StorageMigrationV3(_storageAdapter);
    }
    if (currentVersion < StorageMigrationV4.version) {
      yield StorageMigrationV4(_presetsConnectionService, _storageAdapter);
    }
    if (currentVersion < StorageMigrationV5.version) {
      yield StorageMigrationV5(
        _generalStorageService,
        _connectionsStorageService,
      );
    }
    if (currentVersion < StorageMigrationV6.version) {
      yield StorageMigrationV6(_databaseService, _storageAdapter);
    }
    if (currentVersion < StorageMigrationV7.version) {
      yield StorageMigrationV7(_storageAdapter);
    }
  }
}
