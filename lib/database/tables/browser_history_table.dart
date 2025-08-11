import 'package:drift/drift.dart';

class BrowserHistory extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get url => text()();

  DateTimeColumn get visitTime => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
