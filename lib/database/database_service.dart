import 'package:app/database/delegates/browser_history_database_delegate.dart';
import 'package:app/database/delegates/migration_delegate.dart';
import 'package:app/database/main_database.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DatabaseService {
  MainDatabase? _db;

  BrowserHistoryDatabaseDelegate? _history;
  MigrationDelegate? _migration;

  BrowserHistoryDatabaseDelegate? get history => _history;

  MigrationDelegate? get migration => _migration;

  void init() {
    _db = MainDatabase();
    _history = BrowserHistoryDatabaseDelegate(_db!);
    _migration = MigrationDelegate(_db!);
  }

  @disposeMethod
  void dispose() {
    _db?.close();
  }
}
