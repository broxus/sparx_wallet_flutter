// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_database.dart';

// ignore_for_file: type=lint
class $MigrationTableTable extends MigrationTable
    with TableInfo<$MigrationTableTable, MigrationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MigrationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'migration_table';
  @override
  VerificationContext validateIntegrity(Insertable<MigrationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  MigrationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MigrationTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $MigrationTableTable createAlias(String alias) {
    return $MigrationTableTable(attachedDatabase, alias);
  }
}

class MigrationTableData extends DataClass
    implements Insertable<MigrationTableData> {
  final String key;
  final String value;
  const MigrationTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  MigrationTableCompanion toCompanion(bool nullToAbsent) {
    return MigrationTableCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory MigrationTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MigrationTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  MigrationTableData copyWith({String? key, String? value}) =>
      MigrationTableData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  MigrationTableData copyWithCompanion(MigrationTableCompanion data) {
    return MigrationTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MigrationTableData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MigrationTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class MigrationTableCompanion extends UpdateCompanion<MigrationTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const MigrationTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MigrationTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<MigrationTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MigrationTableCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return MigrationTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MigrationTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BrowserHistoryTableTable extends BrowserHistoryTable
    with TableInfo<$BrowserHistoryTableTable, BrowserHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrowserHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumnWithTypeConverter<Uri, String> url =
      GeneratedColumn<String>('url', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Uri>($BrowserHistoryTableTable.$converterurl);
  static const VerificationMeta _visitTimeMeta =
      const VerificationMeta('visitTime');
  @override
  late final GeneratedColumn<DateTime> visitTime = GeneratedColumn<DateTime>(
      'visit_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, url, visitTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'browser_history_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<BrowserHistoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    context.handle(_urlMeta, const VerificationResult.success());
    if (data.containsKey('visit_time')) {
      context.handle(_visitTimeMeta,
          visitTime.isAcceptableOrUnknown(data['visit_time']!, _visitTimeMeta));
    } else if (isInserting) {
      context.missing(_visitTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BrowserHistoryTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrowserHistoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      url: $BrowserHistoryTableTable.$converterurl.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!),
      visitTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}visit_time'])!,
    );
  }

  @override
  $BrowserHistoryTableTable createAlias(String alias) {
    return $BrowserHistoryTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Uri, String> $converterurl = const UriConverter();
}

class BrowserHistoryTableData extends DataClass
    implements Insertable<BrowserHistoryTableData> {
  final String id;
  final String title;
  final Uri url;
  final DateTime visitTime;
  const BrowserHistoryTableData(
      {required this.id,
      required this.title,
      required this.url,
      required this.visitTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    {
      map['url'] =
          Variable<String>($BrowserHistoryTableTable.$converterurl.toSql(url));
    }
    map['visit_time'] = Variable<DateTime>(visitTime);
    return map;
  }

  BrowserHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return BrowserHistoryTableCompanion(
      id: Value(id),
      title: Value(title),
      url: Value(url),
      visitTime: Value(visitTime),
    );
  }

  factory BrowserHistoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrowserHistoryTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<Uri>(json['url']),
      visitTime: serializer.fromJson<DateTime>(json['visitTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<Uri>(url),
      'visitTime': serializer.toJson<DateTime>(visitTime),
    };
  }

  BrowserHistoryTableData copyWith(
          {String? id, String? title, Uri? url, DateTime? visitTime}) =>
      BrowserHistoryTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        visitTime: visitTime ?? this.visitTime,
      );
  BrowserHistoryTableData copyWithCompanion(BrowserHistoryTableCompanion data) {
    return BrowserHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      url: data.url.present ? data.url.value : this.url,
      visitTime: data.visitTime.present ? data.visitTime.value : this.visitTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrowserHistoryTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('visitTime: $visitTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, url, visitTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrowserHistoryTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.url == this.url &&
          other.visitTime == this.visitTime);
}

class BrowserHistoryTableCompanion
    extends UpdateCompanion<BrowserHistoryTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<Uri> url;
  final Value<DateTime> visitTime;
  final Value<int> rowid;
  const BrowserHistoryTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.visitTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BrowserHistoryTableCompanion.insert({
    required String id,
    required String title,
    required Uri url,
    required DateTime visitTime,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        url = Value(url),
        visitTime = Value(visitTime);
  static Insertable<BrowserHistoryTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? url,
    Expression<DateTime>? visitTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (visitTime != null) 'visit_time': visitTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BrowserHistoryTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<Uri>? url,
      Value<DateTime>? visitTime,
      Value<int>? rowid}) {
    return BrowserHistoryTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      visitTime: visitTime ?? this.visitTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(
          $BrowserHistoryTableTable.$converterurl.toSql(url.value));
    }
    if (visitTime.present) {
      map['visit_time'] = Variable<DateTime>(visitTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrowserHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('visitTime: $visitTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MainDatabase extends GeneratedDatabase {
  _$MainDatabase(QueryExecutor e) : super(e);
  $MainDatabaseManager get managers => $MainDatabaseManager(this);
  late final $MigrationTableTable migrationTable = $MigrationTableTable(this);
  late final $BrowserHistoryTableTable browserHistoryTable =
      $BrowserHistoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [migrationTable, browserHistoryTable];
}

typedef $$MigrationTableTableCreateCompanionBuilder = MigrationTableCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$MigrationTableTableUpdateCompanionBuilder = MigrationTableCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$MigrationTableTableFilterComposer
    extends Composer<_$MainDatabase, $MigrationTableTable> {
  $$MigrationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$MigrationTableTableOrderingComposer
    extends Composer<_$MainDatabase, $MigrationTableTable> {
  $$MigrationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$MigrationTableTableAnnotationComposer
    extends Composer<_$MainDatabase, $MigrationTableTable> {
  $$MigrationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$MigrationTableTableTableManager extends RootTableManager<
    _$MainDatabase,
    $MigrationTableTable,
    MigrationTableData,
    $$MigrationTableTableFilterComposer,
    $$MigrationTableTableOrderingComposer,
    $$MigrationTableTableAnnotationComposer,
    $$MigrationTableTableCreateCompanionBuilder,
    $$MigrationTableTableUpdateCompanionBuilder,
    (
      MigrationTableData,
      BaseReferences<_$MainDatabase, $MigrationTableTable, MigrationTableData>
    ),
    MigrationTableData,
    PrefetchHooks Function()> {
  $$MigrationTableTableTableManager(
      _$MainDatabase db, $MigrationTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MigrationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MigrationTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MigrationTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MigrationTableCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              MigrationTableCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MigrationTableTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $MigrationTableTable,
    MigrationTableData,
    $$MigrationTableTableFilterComposer,
    $$MigrationTableTableOrderingComposer,
    $$MigrationTableTableAnnotationComposer,
    $$MigrationTableTableCreateCompanionBuilder,
    $$MigrationTableTableUpdateCompanionBuilder,
    (
      MigrationTableData,
      BaseReferences<_$MainDatabase, $MigrationTableTable, MigrationTableData>
    ),
    MigrationTableData,
    PrefetchHooks Function()>;
typedef $$BrowserHistoryTableTableCreateCompanionBuilder
    = BrowserHistoryTableCompanion Function({
  required String id,
  required String title,
  required Uri url,
  required DateTime visitTime,
  Value<int> rowid,
});
typedef $$BrowserHistoryTableTableUpdateCompanionBuilder
    = BrowserHistoryTableCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<Uri> url,
  Value<DateTime> visitTime,
  Value<int> rowid,
});

class $$BrowserHistoryTableTableFilterComposer
    extends Composer<_$MainDatabase, $BrowserHistoryTableTable> {
  $$BrowserHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Uri, Uri, String> get url =>
      $composableBuilder(
          column: $table.url,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get visitTime => $composableBuilder(
      column: $table.visitTime, builder: (column) => ColumnFilters(column));
}

class $$BrowserHistoryTableTableOrderingComposer
    extends Composer<_$MainDatabase, $BrowserHistoryTableTable> {
  $$BrowserHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get visitTime => $composableBuilder(
      column: $table.visitTime, builder: (column) => ColumnOrderings(column));
}

class $$BrowserHistoryTableTableAnnotationComposer
    extends Composer<_$MainDatabase, $BrowserHistoryTableTable> {
  $$BrowserHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Uri, String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<DateTime> get visitTime =>
      $composableBuilder(column: $table.visitTime, builder: (column) => column);
}

class $$BrowserHistoryTableTableTableManager extends RootTableManager<
    _$MainDatabase,
    $BrowserHistoryTableTable,
    BrowserHistoryTableData,
    $$BrowserHistoryTableTableFilterComposer,
    $$BrowserHistoryTableTableOrderingComposer,
    $$BrowserHistoryTableTableAnnotationComposer,
    $$BrowserHistoryTableTableCreateCompanionBuilder,
    $$BrowserHistoryTableTableUpdateCompanionBuilder,
    (
      BrowserHistoryTableData,
      BaseReferences<_$MainDatabase, $BrowserHistoryTableTable,
          BrowserHistoryTableData>
    ),
    BrowserHistoryTableData,
    PrefetchHooks Function()> {
  $$BrowserHistoryTableTableTableManager(
      _$MainDatabase db, $BrowserHistoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrowserHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrowserHistoryTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrowserHistoryTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<Uri> url = const Value.absent(),
            Value<DateTime> visitTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BrowserHistoryTableCompanion(
            id: id,
            title: title,
            url: url,
            visitTime: visitTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required Uri url,
            required DateTime visitTime,
            Value<int> rowid = const Value.absent(),
          }) =>
              BrowserHistoryTableCompanion.insert(
            id: id,
            title: title,
            url: url,
            visitTime: visitTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BrowserHistoryTableTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $BrowserHistoryTableTable,
    BrowserHistoryTableData,
    $$BrowserHistoryTableTableFilterComposer,
    $$BrowserHistoryTableTableOrderingComposer,
    $$BrowserHistoryTableTableAnnotationComposer,
    $$BrowserHistoryTableTableCreateCompanionBuilder,
    $$BrowserHistoryTableTableUpdateCompanionBuilder,
    (
      BrowserHistoryTableData,
      BaseReferences<_$MainDatabase, $BrowserHistoryTableTable,
          BrowserHistoryTableData>
    ),
    BrowserHistoryTableData,
    PrefetchHooks Function()>;

class $MainDatabaseManager {
  final _$MainDatabase _db;
  $MainDatabaseManager(this._db);
  $$MigrationTableTableTableManager get migrationTable =>
      $$MigrationTableTableTableManager(_db, _db.migrationTable);
  $$BrowserHistoryTableTableTableManager get browserHistoryTable =>
      $$BrowserHistoryTableTableTableManager(_db, _db.browserHistoryTable);
}
