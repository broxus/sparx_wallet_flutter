import 'package:app/app/service/database/database_service.dart';
import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class MigrateConfigurator {
  MigrateConfigurator(
    this._encryptedStorage,
    this._presetsConnectionService,
    this._generalStorageService,
    this._connectionsStorageService,
    this._databaseService,
    this._storageAdapter,
  );

  final EncryptedStorage _encryptedStorage;
  final PresetsConnectionService _presetsConnectionService;
  final GeneralStorageService _generalStorageService;
  final ConnectionsStorageService _connectionsStorageService;
  final DatabaseService _databaseService;
  final StorageAdapter _storageAdapter;

  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('StorageMigrationService starting...');
    await StorageMigrationService.applyMigrations(
      _encryptedStorage,
      _presetsConnectionService,
      _generalStorageService,
      _connectionsStorageService,
      _databaseService,
      _storageAdapter,
    );
    _log.finest('StorageMigrationService finished');
  }
}
