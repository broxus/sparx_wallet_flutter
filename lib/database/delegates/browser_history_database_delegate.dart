import 'package:app/data/models/browser_history_item.dart';
import 'package:app/database/main_database.dart';
import 'package:drift/drift.dart';

class BrowserHistoryDatabaseDelegate {
  BrowserHistoryDatabaseDelegate(this._db);

  final MainDatabase _db;

  Future<void> addHistoryItem(BrowserHistoryItem item) async {
    await _db.into(_db.browserHistoryTable).insertOnConflictUpdate(
          BrowserHistoryTableCompanion.insert(
            id: item.id,
            title: item.title,
            url: item.url,
            visitTime: item.visitTime,
          ),
        );
  }

  Future<void> addHistoryItemsList(List<BrowserHistoryItem> items) async {
    await _db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _db.browserHistoryTable,
        items.map((item) {
          return BrowserHistoryTableCompanion.insert(
            id: item.id,
            title: item.title,
            url: item.url,
            visitTime: item.visitTime,
          );
        }).toList(),
      );
    });
  }

  Future<void> deleteHistoryItem(String id) async {
    await (_db.delete(_db.browserHistoryTable)
          ..where(
            (t) => t.id.equals(id),
          ))
        .go();
  }

  Future<void> clearHistory() async {
    await _db.delete(_db.browserHistoryTable).go();
  }

  Future<List<BrowserHistoryItem>> getHistory({
    required int limit,
    int offset = 0,
  }) async {
    final q = _db.select(_db.browserHistoryTable)
      ..orderBy([(t) => OrderingTerm.desc(t.visitTime)])
      ..limit(limit, offset: offset);
    final rows = await q.get();
    return rows.map(_toHistoryDomain).toList();
  }

  BrowserHistoryItem _toHistoryDomain(BrowserHistoryTableData r) {
    return BrowserHistoryItem(
      id: r.id,
      title: r.title,
      url: r.url,
      visitTime: r.visitTime,
    );
  }
}
