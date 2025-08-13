import 'dart:io';

import 'package:app/database/tables/browser_history_table.dart';
import 'package:app/database/tables/migration_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'main_database.g.dart';

@DriftDatabase(tables: [
  MigrationTable,
  BrowserHistoryTable,
])
class MainDatabase extends _$MainDatabase {
  MainDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // @override
  // MigrationStrategy get migration => MigrationStrategy(
  //   onCreate: (m) async {
  //     await m.createAll();
  //     await m.createIndex(
  //         Index('idx_history_visit_time', 'browser_history_table(visit_time DESC)')
  //     );
  //     await m.createIndex(
  //         Index('idx_history_url', 'browser_history_table(url)')
  //     );
  //   },
  // );
  //
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(path.join(dir.path, 'main.db'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
