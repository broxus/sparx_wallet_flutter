import 'package:app/app/service/database/database_service.dart';
import 'package:app/app/service/storage_service/storage_service.dart';
import 'package:app/data/models/browser_history_item.dart';

class StorageMigrationV6 implements StorageMigration {
  StorageMigrationV6(this._databaseService, this._storageAdapter);

  static const int version = 6;

  final DatabaseService _databaseService;
  final StorageAdapter _storageAdapter;

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

    await _storageAdapter.init('browser_history');
    final storage = _storageAdapter.box('browser_history');

    final list = storage.read<List<dynamic>>('browser_history_key');

    if (list != null) {
      final result = <BrowserHistoryItem>[];

      for (final entry in list) {
        try {
          result.add(
            BrowserHistoryItem.fromJson(entry as Map<String, dynamic>),
          );
        } catch (_) {}
      }

      if (result.isNotEmpty) {
        await _databaseService.history.saveHistoryItemsList(result);
      }
    }

    await _databaseService.migration.acceptHistoryMigration();
    await storage.erase();
  }
}
