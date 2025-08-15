import 'package:app/app/service/database/main_database.dart';

class MigrationDelegate {
  MigrationDelegate(this._db);

  static const historyMigrationKey = 'bookmarks_history_migration';

  final MainDatabase _db;

  Future<void> acceptHistoryMigration() {
    return _setBool(
      historyMigrationKey,
      true,
    );
  }

  Future<bool> checkHistoryMigration() async {
    return _getBool(historyMigrationKey);
  }

  Future<void> _setBool(String key, bool v) async =>
      _insertItem(key, v ? 'true' : 'false');

  Future<bool> _getBool(String key, {bool defaultValue = false}) async {
    final row = await (_db.select(_db.migrationTable)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row == null ? defaultValue : row.value.toLowerCase() == 'true';
  }

  Future<void> _insertItem(String key, String value) async {
    await _db.into(_db.migrationTable).insertOnConflictUpdate(
          MigrationTableCompanion.insert(
            key: key,
            value: value,
          ),
        );
  }
}
