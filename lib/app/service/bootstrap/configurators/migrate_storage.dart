import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class MigrateConfigurator {
  MigrateConfigurator(
    this._encryptedStorage,
    this._presetsConnectionService,
  );

  final EncryptedStorage _encryptedStorage;
  final PresetsConnectionService _presetsConnectionService;

  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('StorageMigrationService starting...');
    await StorageMigrationService.applyMigrations(
      _encryptedStorage,
      _presetsConnectionService,
    );
    _log.finest('StorageMigrationService finished');
  }
}
