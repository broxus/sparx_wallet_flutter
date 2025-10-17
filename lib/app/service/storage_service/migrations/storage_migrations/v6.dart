import 'package:app/app/service/database/database_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/storage_migration.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:get_storage/get_storage.dart';

class StorageMigrationV6 implements StorageMigration {
  StorageMigrationV6(this._databaseService);

  static const int version = 6;

  final DatabaseService _databaseService;

  @override
  Future<void> apply() async {
    await _migrateHistory();
  }

  @override
  Future<void> complete() async {}

  Future<void> _migrateHistory() async {
    if (await _databaseService.migration.checkHistoryMigration()) {
      return;
    }

    await GetStorage.init('browser_history');
    final storage = GetStorage('browser_history');

    final list = storage.read<List<dynamic>>('browser_history_key');

    if (list != null) {
      await _databaseService.history.saveHistoryItemsList([
        for (final entry in list)
          BrowserHistoryItem.fromJson(entry as Map<String, dynamic>),
      ]);
    }
    await _databaseService.migration.acceptHistoryMigration();
    await storage.erase();
  }
}
