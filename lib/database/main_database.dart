import 'dart:io';

import 'package:app/database/tables/browser_bookmarks_table.dart';
import 'package:app/database/tables/browser_history_table.dart';
import 'package:app/database/tables/dev_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'main_database.g.dart';

@DriftDatabase(tables: [
  DevTable,
  BrowserBookmarks,
  BrowserHistory,
])
class MainDatabase extends _$MainDatabase {
  MainDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(path.join(dir.path, 'main.db'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
