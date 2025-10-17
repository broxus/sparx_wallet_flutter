import 'dart:async';

import 'package:app/app/service/database/main_database.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:drift/drift.dart';

class BrowserHistoryDatabaseDelegate {
  BrowserHistoryDatabaseDelegate(this._db);

  final MainDatabase _db;
  final int _maxItems = 100;

  Stream<List<BrowserHistoryItem>> watchHistory([String? searchText]) {
    final t = _db.browserHistoryTable;

    if (searchText == null || searchText.trim().isEmpty) {
      final query = _db.select(t)
        ..orderBy([(h) => OrderingTerm.desc(h.visitTime)])
        ..limit(_maxItems);
      return query.watch().map((rows) => rows.map(_toHistoryDomain).toList());
    }

    final q = _normalize(searchText);
    final pat = '%${_escLike(q)}%';

    final tableName = t.actualTableName;
    final prefix = t.aliasedName;

    final stmt = _db.customSelect(
      '''
    SELECT
      id         AS "$prefix.id",
      title      AS "$prefix.title",
      url        AS "$prefix.url",
      visit_time AS "$prefix.visit_time"
    FROM $tableName
    WHERE norm(title)   LIKE ? ESCAPE '\\'
       OR norm_url(url) LIKE ? ESCAPE '\\'
    ORDER BY visit_time DESC
    LIMIT ?
    ''',
      variables: [Variable(pat), Variable(pat), Variable(_maxItems)],
      readsFrom: {t},
    );

    return stmt.watch().map((rows) {
      return rows
          .map((row) => t.map(row.data, tablePrefix: prefix))
          .map(_toHistoryDomain)
          .toList(growable: false);
    }).asBroadcastStream();
  }

  Stream<int> watchHistoryCount() {
    final t = _db.browserHistoryTable;
    final countExp = t.id.count();

    final q = _db.selectOnly(t)..addColumns([countExp]);

    return q
        .watchSingle()
        .map((row) => row.read(countExp) ?? 0)
        .asBroadcastStream();
  }

  Future<BrowserHistoryItem?> getHistoryItemById(String id) async {
    final query = _db.select(_db.browserHistoryTable)
      ..where((t) => t.id.equals(id))
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row != null ? _toHistoryDomain(row) : null;
  }

  Future<List<BrowserHistoryItem>> getItems([String? searchText]) async {
    final t = _db.browserHistoryTable;

    if (searchText == null || searchText.trim().isEmpty) {
      final rows =
          await (_db.select(t)
                ..orderBy([(h) => OrderingTerm.desc(h.visitTime)])
                ..limit(_maxItems))
              .get();
      return rows.map(_toHistoryDomain).toList(growable: false);
    }

    final q = _normalize(searchText);
    final pat = '%${_escLike(q)}%';
    final table = t.actualTableName;
    final prefix = t.aliasedName;

    final rows = await _db
        .customSelect(
          '''
      SELECT
        id         AS "$prefix.id",
        title      AS "$prefix.title",
        url        AS "$prefix.url",
        visit_time AS "$prefix.visit_time"
      FROM $table
      WHERE norm(title)   LIKE ? ESCAPE '\\'
         OR norm_url(url) LIKE ? ESCAPE '\\'
      ORDER BY visit_time DESC
      LIMIT ?
      ''',
          variables: [Variable(pat), Variable(pat), Variable(_maxItems)],
          readsFrom: {t},
        )
        .get();

    return rows
        .map((r) => t.map(r.data, tablePrefix: prefix))
        .map(_toHistoryDomain)
        .toList();
  }

  Future<void> saveHistoryItem(BrowserHistoryItem item) async {
    await _db.transaction(() async {
      await _db
          .into(_db.browserHistoryTable)
          .insertOnConflictUpdate(
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
          items
              .map((item) {
                return BrowserHistoryTableCompanion.insert(
                  id: item.id,
                  title: item.title,
                  url: item.url,
                  visitTime: item.visitTime,
                );
              })
              .toList(growable: false),
        );
      });
      await _trimToCap();
    });
  }

  Future<void> deleteHistoryItem(String id) async {
    await (_db.delete(
      _db.browserHistoryTable,
    )..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteHistoryItemByUri(Uri uri) async {
    final url = uri.toString();
    await (_db.delete(
      _db.browserHistoryTable,
    )..where((t) => t.url.equals(url))).go();
  }

  Future<int> deleteHistoryByPeriod(DateTime date) {
    return (_db.delete(
      _db.browserHistoryTable,
    )..where((tbl) => tbl.visitTime.isBiggerThanValue(date))).go();
  }

  Future<void> clearHistory() async {
    await _db.delete(_db.browserHistoryTable).go();
  }

  Future<void> clearHistoryByDates(DateTime lower, DateTime higher) async {
    await (_db.delete(
      _db.browserHistoryTable,
    )..where((tbl) => tbl.visitTime.isBetweenValues(lower, higher))).go();
  }

  Future<void> _trimToCap() async {
    final t = _db.browserHistoryTable;
    final idsToDelete =
        await (_db.select(t)
              ..orderBy([(x) => OrderingTerm.desc(x.visitTime)])
              ..limit(-1, offset: _maxItems))
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

  String _normalize(String s) => s.toLowerCase().replaceAll('ё', 'е').trim();

  String _escLike(String s) =>
      s.replaceAll(r'\', r'\\').replaceAll('%', r'\%').replaceAll('_', r'\_');
}
