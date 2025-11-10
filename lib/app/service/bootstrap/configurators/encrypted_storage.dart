import 'dart:io';

import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class EncryptedStorageConfigurator {
  EncryptedStorageConfigurator(this._encryptedStorage);

  final EncryptedStorage _encryptedStorage;
  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('EncryptedStorage initializating...');

    await _migrateToApplicationSupportDirectoryIfNeeded();
    await _encryptedStorage.init(databasesPath: await _getDatabasesPath());

    _log.finest('EncryptedStorage initialized');
  }

  Future<String?> _getDatabasesPath() async {
    try {
      final directory = await getApplicationSupportDirectory();
      return directory.path;
    } catch (e, st) {
      _log.warning('Failed to get application support directory', e, st);
      return null;
    }
  }

  Future<void> _migrateToApplicationSupportDirectoryIfNeeded() async {
    const storageFileName = 'encrypted_storage.db';
    final defaultDatabasesPath =
        await EncryptedStorage.getDefaultDatabasesPath();
    final databasesPath = await _getDatabasesPath();

    if (databasesPath != null && databasesPath != defaultDatabasesPath) {
      final oldPath = '$defaultDatabasesPath/$storageFileName';
      final newPath = '$databasesPath/$storageFileName';

      try {
        final oldFile = File(oldPath);
        final targetDir = Directory(databasesPath);

        if (!oldFile.existsSync()) {
          _log.fine('No encrypted storage found at default path: $oldPath');
          return;
        }

        // Ensure target directory exists
        if (!targetDir.existsSync()) {
          await targetDir.create(recursive: true);
        }

        final newFile = File(newPath);

        if (newFile.existsSync()) {
          _log.info(
            'Encrypted storage already exists at new path, skipping move.',
          );
          return;
        }

        await oldFile.copy(newPath);

        try {
          await oldFile.delete();
        } catch (e, st) {
          _log.severe('Failed to delete old encrypted storage db file', e, st);
        }
      } catch (e, st) {
        _log.severe('Failed to move encrypted storage db', e, st);
      }
    }
  }
}
