import 'package:app/database/main_database.dart';

class DevDelegate {
  DevDelegate(this._db);

  static const bookmarksHistoryKey = 'bookmarks_history_migration';

  final MainDatabase _db;

  Future<void> addMigration() {
    return _insertItem(
      bookmarksHistoryKey,
      'true',
    );
  }

  Future<bool> checkMigration() async {
    final row = await (_db.select(_db.devTable)
          ..where(
            (t) => t.key.equals(bookmarksHistoryKey),
          ))
        .getSingleOrNull();

    return row?.value == 'true';
  }

  Future<void> _insertItem(String key, String value) async {
    await _db.into(_db.devTable).insertOnConflictUpdate(
          DevTableCompanion.insert(
            key: key,
            value: value,
          ),
        );
  }
}
