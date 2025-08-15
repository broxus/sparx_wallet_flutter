import 'dart:io';

import 'package:app/app/service/database/converters/uri_converter.dart';
import 'package:app/app/service/database/tables/browser_history_table.dart';
import 'package:app/app/service/database/tables/migration_table.dart';
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

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();

          await customStatement(
            'CREATE INDEX idx_history_visit_time ON browser_history_table(visit_time DESC)',
          );
          await customStatement(
            'CREATE INDEX idx_history_title ON browser_history_table(title)',
          );
          await customStatement(
            'CREATE INDEX idx_history_url ON browser_history_table(url)',
          );
        },
      );

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(path.join(dir.path, 'main.db'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
