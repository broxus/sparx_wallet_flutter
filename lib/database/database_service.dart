import 'package:app/database/delegates/browser_bookmarks_database_delegate.dart';
import 'package:app/database/delegates/browser_history_database_delegate.dart';
import 'package:app/database/main_database.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DatabaseService {
  MainDatabase? _db;

  BrowserBookmarksDatabaseDelegate? _bookmarks;
  BrowserHistoryDatabaseDelegate? _history;

  BrowserBookmarksDatabaseDelegate? get bookmarks => _bookmarks;

  BrowserHistoryDatabaseDelegate? get history => _history;

  void init() {
    _db = MainDatabase();
    _bookmarks = BrowserBookmarksDatabaseDelegate(_db!);
    _history = BrowserHistoryDatabaseDelegate(_db!);
  }

  Future<void> close() async => _db?.close();
}
