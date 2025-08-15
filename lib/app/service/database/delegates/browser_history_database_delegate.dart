import 'dart:async';

import 'package:app/app/service/database/main_database.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:drift/drift.dart';

class BrowserHistoryDatabaseDelegate {
  BrowserHistoryDatabaseDelegate(this._db);

  final MainDatabase _db;
  final int _maxItems = 100;

  Stream<List<BrowserHistoryItem>> watchHistory([String? searchText]) {
    final query = _db.select(_db.browserHistoryTable)
      ..orderBy([
        (h) => OrderingTerm.desc(h.visitTime),
      ])
      ..limit(_maxItems);

    if (searchText != null && searchText.isNotEmpty) {
      final like = '%$searchText%';
      query.where((t) =>
          t.title.collate(Collate.noCase).like(like) |
          t.url.collate(Collate.noCase).like(like));
    }

    return query.watch().map(
          (rows) => rows.map(_toHistoryDomain).toList(),
        );
  }

  Stream<int> watchHistoryCount() {
    final t = _db.browserHistoryTable;
    final countExp = t.id.count();

    final q = _db.selectOnly(t)..addColumns([countExp]);

    return q.watchSingle().map((row) => row.read(countExp) ?? 0);
  }

  Future<BrowserHistoryItem?> getHistoryItemById(String id) async {
    final query = _db.select(_db.browserHistoryTable)
      ..where((t) => t.id.equals(id))
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row != null ? _toHistoryDomain(row) : null;
  }

  Future<void> saveHistoryItem(BrowserHistoryItem item) async {
    await _db.transaction(() async {
      await _db.into(_db.browserHistoryTable).insertOnConflictUpdate(
            BrowserHistoryTableCompanion.insert(
              id: item.id,
              title: item.title,
              url: item.url,
              visitTime: item.visitTime,
            ),
          );
      await _trimToCap();
    });
  }

  Future<void> saveHistoryItemsList(Iterable<BrowserHistoryItem> items) async {
    if (items.isEmpty) return;
    await _db.transaction(() async {
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
          }).toList(growable: false),
        );
      });
      await _trimToCap();
    });
  }

  Future<void> deleteHistoryItem(String id) async {
    await (_db.delete(_db.browserHistoryTable)
          ..where(
            (t) => t.id.equals(id),
          ))
        .go();
  }

  Future<void> deleteHistoryItemByUri(Uri uri) async {
    final url = uri.toString();
    await (_db.delete(_db.browserHistoryTable)
          ..where(
            (t) => t.url.equals(url),
          ))
        .go();
  }

  Future<int> deleteHistoryByPeriod(DateTime date) async {
    return (_db.delete(_db.browserHistoryTable)
          ..where((tbl) => tbl.visitTime.isBiggerThanValue(date)))
        .go();
  }

  Future<void> clearHistory() async {
    await _db.delete(_db.browserHistoryTable).go();
  }

  Future<void> clearHistoryByDates(
    DateTime lower,
    DateTime higher,
  ) async {
    await (_db.delete(_db.browserHistoryTable)
          ..where(
            (tbl) => tbl.visitTime.isBetweenValues(lower, higher),
          ))
        .go();
  }

  Future<void> _trimToCap() async {
    final t = _db.browserHistoryTable;
    final idsToDelete = await (_db.select(t)
          ..orderBy([(x) => OrderingTerm.desc(x.visitTime)])
          ..limit(
            -1,
            offset: _maxItems,
          ))
        .get()
        .then((rows) => rows.map((r) => r.id).toList(growable: false));

    if (idsToDelete.isNotEmpty) {
      await (_db.delete(t)..where((x) => x.id.isIn(idsToDelete))).go();
    }
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
