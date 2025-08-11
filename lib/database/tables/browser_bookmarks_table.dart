import 'package:drift/drift.dart';

class BrowserBookmarks extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get url => text()();

  RealColumn get sortingOrder => real()();

  @override
  Set<Column> get primaryKey => {id};
}
