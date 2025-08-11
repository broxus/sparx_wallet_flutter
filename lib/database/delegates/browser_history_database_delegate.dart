import 'package:app/data/models/browser_history_item.dart';
import 'package:app/database/main_database.dart';
import 'package:drift/drift.dart';

class BrowserHistoryDatabaseDelegate {
  BrowserHistoryDatabaseDelegate(this._db);

  final MainDatabase _db;

  Future<void> addHistoryItem(BrowserHistoryItem item) async {
    await _db.into(_db.browserHistory).insertOnConflictUpdate(
          BrowserHistoryCompanion.insert(
            id: item.id,
            title: item.title,
            url: item.url.toString(),
            visitTime: item.visitTime,
          ),
        );
  }

  Future<void> deleteHistoryItem(String id) async {
    await (_db.delete(_db.browserHistory)
          ..where(
            (t) => t.id.equals(id),
          ))
        .go();
  }

  Future<void> clearHistory() async {
    await _db.delete(_db.browserHistory).go();
  }

  Future<List<BrowserHistoryItem>> getHistory({
    required int limit,
    int offset = 0,
  }) async {
    final q = _db.select(_db.browserHistory)
      ..orderBy([(t) => OrderingTerm.desc(t.visitTime)])
      ..limit(limit, offset: offset);
    final rows = await q.get();
    return rows.map(_toHistoryDomain).toList();
  }

  BrowserHistoryItem _toHistoryDomain(BrowserHistoryData r) {
    return BrowserHistoryItem(
      id: r.id,
      title: r.title,
      url: Uri.parse(r.url),
      visitTime: r.visitTime,
    );
  }
}
