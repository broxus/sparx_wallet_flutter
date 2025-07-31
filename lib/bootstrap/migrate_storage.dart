import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:logging/logging.dart';

/// Migrate storage from old version to new one
Future<void> migrateStorage() async {
  final log = Logger('bootstrap')
    ..finest('StorageMigrationService starting...');
  await StorageMigrationService.applyMigrations(
    inject<EncryptedStorage>(),
    inject<PresetsConnectionService>(),
    inject<GeneralStorageService>(),
    inject<ConnectionsStorageService>(),
  );
  log.finest('StorageMigrationService finished');
}
