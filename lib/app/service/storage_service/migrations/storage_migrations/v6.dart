import 'package:app/app/service/storage_service/migrations/storage_migrations/storage_migration.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/database/database_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_history_storage_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

class StorageMigrationV6 implements StorageMigration {
  StorageMigrationV6(
    @Named(BrowserHistoryStorageService.container) this._storage,
    this._databaseService,
  );

  static const int version = 6;

  final GetStorage _storage;
  final DatabaseService _databaseService;

  @override
  Future<void> apply() async {
    await _migrateHistory();
  }

  @override
  Future<void> complete() async {}

  Future<void> _migrateHistory() async {
    if ((await _databaseService.migration?.checkHistoryMigration()) ?? false) {
      return;
    }

    final list = _storage.read<List<dynamic>>(
      browserHistoryKey,
    );

    if (list != null) {
      await _databaseService.history?.addHistoryItemsList(
        [
          for (final entry in list)
            BrowserHistoryItem.fromJson(
              entry as Map<String, dynamic>,
            ),
        ],
      );
    }
    await _databaseService.migration?.acceptHistoryMigration();
    await _storage.erase();
  }
}
