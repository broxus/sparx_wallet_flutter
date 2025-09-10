import 'package:drift/drift.dart';

class PermissionsTable extends Table {
  TextColumn get host => text()();

  TextColumn get permission => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {host, permission};
}
