import 'package:app/app/service/database/delegates/browser_history_database_delegate.dart';
import 'package:app/app/service/database/delegates/migration_delegate.dart';
import 'package:app/app/service/database/delegates/permissions_delegate.dart';
import 'package:app/app/service/database/main_database.dart';
import 'package:injectable/injectable.dart';

@singleton
class DatabaseService {
  late final _db = MainDatabase();

  late final history = BrowserHistoryDatabaseDelegate(_db);
  late final migration = MigrationDelegate(_db);
  late final permissions = PermissionsDelegate(_db);

  @disposeMethod
  void dispose() {
    _db.close();
  }
}
