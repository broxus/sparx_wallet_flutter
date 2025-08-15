import 'package:app/app/service/database/converters/uri_converter.dart';
import 'package:drift/drift.dart';

class BrowserHistoryTable extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get url => text().map(const UriConverter())();

  DateTimeColumn get visitTime => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
