import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/database/main_database.dart';

class BrowserBookmarksDatabaseDelegate {
  BrowserBookmarksDatabaseDelegate(this._db);

  final MainDatabase _db;

  Future<void> addBookmark(BrowserBookmarkItem item) async {
    await _db.into(_db.browserBookmarks).insertOnConflictUpdate(
          BrowserBookmarksCompanion.insert(
            id: item.id,
            title: item.title,
            url: item.url.toString(),
            sortingOrder: item.sortingOrder,
          ),
        );
  }

  Future<void> deleteBookmark(String id) async {
    await (_db.delete(_db.browserBookmarks)
          ..where(
            (t) => t.id.equals(id),
          ))
        .go();
  }

  Future<void> clearBookmarks() async {
    await _db.delete(_db.browserBookmarks).go();
  }

  Future<List<BrowserBookmarkItem>> getBookmarks({
    required int limit,
    int offset = 0,
  }) async {
    final q = _db.select(_db.browserBookmarks)..limit(limit, offset: offset);

    final rows = await q.get();
    return rows.map(_mapBookmark).toList();
  }

  BrowserBookmarkItem _mapBookmark(BrowserBookmark r) {
    return BrowserBookmarkItem(
      id: r.id,
      title: r.title,
      url: Uri.parse(r.url),
      sortingOrder: r.sortingOrder,
    );
  }
}
