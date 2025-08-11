// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_database.dart';

// ignore_for_file: type=lint
class $DevTableTable extends DevTable
    with TableInfo<$DevTableTable, DevTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'dev_table';
  @override
  VerificationContext validateIntegrity(Insertable<DevTableData> instance,
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
  DevTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DevTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $DevTableTable createAlias(String alias) {
    return $DevTableTable(attachedDatabase, alias);
  }
}

class DevTableData extends DataClass implements Insertable<DevTableData> {
  final String key;
  final String value;
  const DevTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  DevTableCompanion toCompanion(bool nullToAbsent) {
    return DevTableCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory DevTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DevTableData(
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

  DevTableData copyWith({String? key, String? value}) => DevTableData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  DevTableData copyWithCompanion(DevTableCompanion data) {
    return DevTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DevTableData(')
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
      (other is DevTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class DevTableCompanion extends UpdateCompanion<DevTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const DevTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<DevTableData> custom({
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

  DevTableCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return DevTableCompanion(
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
    return (StringBuffer('DevTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BrowserBookmarksTable extends BrowserBookmarks
    with TableInfo<$BrowserBookmarksTable, BrowserBookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrowserBookmarksTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortingOrderMeta =
      const VerificationMeta('sortingOrder');
  @override
  late final GeneratedColumn<double> sortingOrder = GeneratedColumn<double>(
      'sorting_order', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, url, sortingOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'browser_bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<BrowserBookmark> instance,
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
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('sorting_order')) {
      context.handle(
          _sortingOrderMeta,
          sortingOrder.isAcceptableOrUnknown(
              data['sorting_order']!, _sortingOrderMeta));
    } else if (isInserting) {
      context.missing(_sortingOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BrowserBookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrowserBookmark(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      sortingOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sorting_order'])!,
    );
  }

  @override
  $BrowserBookmarksTable createAlias(String alias) {
    return $BrowserBookmarksTable(attachedDatabase, alias);
  }
}

class BrowserBookmark extends DataClass implements Insertable<BrowserBookmark> {
  final String id;
  final String title;
  final String url;
  final double sortingOrder;
  const BrowserBookmark(
      {required this.id,
      required this.title,
      required this.url,
      required this.sortingOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['url'] = Variable<String>(url);
    map['sorting_order'] = Variable<double>(sortingOrder);
    return map;
  }

  BrowserBookmarksCompanion toCompanion(bool nullToAbsent) {
    return BrowserBookmarksCompanion(
      id: Value(id),
      title: Value(title),
      url: Value(url),
      sortingOrder: Value(sortingOrder),
    );
  }

  factory BrowserBookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrowserBookmark(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String>(json['url']),
      sortingOrder: serializer.fromJson<double>(json['sortingOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<String>(url),
      'sortingOrder': serializer.toJson<double>(sortingOrder),
    };
  }

  BrowserBookmark copyWith(
          {String? id, String? title, String? url, double? sortingOrder}) =>
      BrowserBookmark(
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        sortingOrder: sortingOrder ?? this.sortingOrder,
      );
  BrowserBookmark copyWithCompanion(BrowserBookmarksCompanion data) {
    return BrowserBookmark(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      url: data.url.present ? data.url.value : this.url,
      sortingOrder: data.sortingOrder.present
          ? data.sortingOrder.value
          : this.sortingOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrowserBookmark(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('sortingOrder: $sortingOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, url, sortingOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrowserBookmark &&
          other.id == this.id &&
          other.title == this.title &&
          other.url == this.url &&
          other.sortingOrder == this.sortingOrder);
}

class BrowserBookmarksCompanion extends UpdateCompanion<BrowserBookmark> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> url;
  final Value<double> sortingOrder;
  final Value<int> rowid;
  const BrowserBookmarksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.sortingOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BrowserBookmarksCompanion.insert({
    required String id,
    required String title,
    required String url,
    required double sortingOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        url = Value(url),
        sortingOrder = Value(sortingOrder);
  static Insertable<BrowserBookmark> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? url,
    Expression<double>? sortingOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (sortingOrder != null) 'sorting_order': sortingOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BrowserBookmarksCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? url,
      Value<double>? sortingOrder,
      Value<int>? rowid}) {
    return BrowserBookmarksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      sortingOrder: sortingOrder ?? this.sortingOrder,
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
      map['url'] = Variable<String>(url.value);
    }
    if (sortingOrder.present) {
      map['sorting_order'] = Variable<double>(sortingOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrowserBookmarksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('sortingOrder: $sortingOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BrowserHistoryTable extends BrowserHistory
    with TableInfo<$BrowserHistoryTable, BrowserHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrowserHistoryTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  static const String $name = 'browser_history';
  @override
  VerificationContext validateIntegrity(Insertable<BrowserHistoryData> instance,
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
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
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
  BrowserHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrowserHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      visitTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}visit_time'])!,
    );
  }

  @override
  $BrowserHistoryTable createAlias(String alias) {
    return $BrowserHistoryTable(attachedDatabase, alias);
  }
}

class BrowserHistoryData extends DataClass
    implements Insertable<BrowserHistoryData> {
  final String id;
  final String title;
  final String url;
  final DateTime visitTime;
  const BrowserHistoryData(
      {required this.id,
      required this.title,
      required this.url,
      required this.visitTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['url'] = Variable<String>(url);
    map['visit_time'] = Variable<DateTime>(visitTime);
    return map;
  }

  BrowserHistoryCompanion toCompanion(bool nullToAbsent) {
    return BrowserHistoryCompanion(
      id: Value(id),
      title: Value(title),
      url: Value(url),
      visitTime: Value(visitTime),
    );
  }

  factory BrowserHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrowserHistoryData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String>(json['url']),
      visitTime: serializer.fromJson<DateTime>(json['visitTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<String>(url),
      'visitTime': serializer.toJson<DateTime>(visitTime),
    };
  }

  BrowserHistoryData copyWith(
          {String? id, String? title, String? url, DateTime? visitTime}) =>
      BrowserHistoryData(
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        visitTime: visitTime ?? this.visitTime,
      );
  BrowserHistoryData copyWithCompanion(BrowserHistoryCompanion data) {
    return BrowserHistoryData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      url: data.url.present ? data.url.value : this.url,
      visitTime: data.visitTime.present ? data.visitTime.value : this.visitTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrowserHistoryData(')
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
      (other is BrowserHistoryData &&
          other.id == this.id &&
          other.title == this.title &&
          other.url == this.url &&
          other.visitTime == this.visitTime);
}

class BrowserHistoryCompanion extends UpdateCompanion<BrowserHistoryData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> url;
  final Value<DateTime> visitTime;
  final Value<int> rowid;
  const BrowserHistoryCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.visitTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BrowserHistoryCompanion.insert({
    required String id,
    required String title,
    required String url,
    required DateTime visitTime,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        url = Value(url),
        visitTime = Value(visitTime);
  static Insertable<BrowserHistoryData> custom({
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

  BrowserHistoryCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? url,
      Value<DateTime>? visitTime,
      Value<int>? rowid}) {
    return BrowserHistoryCompanion(
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
      map['url'] = Variable<String>(url.value);
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
    return (StringBuffer('BrowserHistoryCompanion(')
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
  late final $DevTableTable devTable = $DevTableTable(this);
  late final $BrowserBookmarksTable browserBookmarks =
      $BrowserBookmarksTable(this);
  late final $BrowserHistoryTable browserHistory = $BrowserHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [devTable, browserBookmarks, browserHistory];
}

typedef $$DevTableTableCreateCompanionBuilder = DevTableCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$DevTableTableUpdateCompanionBuilder = DevTableCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$DevTableTableFilterComposer
    extends Composer<_$MainDatabase, $DevTableTable> {
  $$DevTableTableFilterComposer({
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

class $$DevTableTableOrderingComposer
    extends Composer<_$MainDatabase, $DevTableTable> {
  $$DevTableTableOrderingComposer({
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

class $$DevTableTableAnnotationComposer
    extends Composer<_$MainDatabase, $DevTableTable> {
  $$DevTableTableAnnotationComposer({
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

class $$DevTableTableTableManager extends RootTableManager<
    _$MainDatabase,
    $DevTableTable,
    DevTableData,
    $$DevTableTableFilterComposer,
    $$DevTableTableOrderingComposer,
    $$DevTableTableAnnotationComposer,
    $$DevTableTableCreateCompanionBuilder,
    $$DevTableTableUpdateCompanionBuilder,
    (
      DevTableData,
      BaseReferences<_$MainDatabase, $DevTableTable, DevTableData>
    ),
    DevTableData,
    PrefetchHooks Function()> {
  $$DevTableTableTableManager(_$MainDatabase db, $DevTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DevTableCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              DevTableCompanion.insert(
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

typedef $$DevTableTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $DevTableTable,
    DevTableData,
    $$DevTableTableFilterComposer,
    $$DevTableTableOrderingComposer,
    $$DevTableTableAnnotationComposer,
    $$DevTableTableCreateCompanionBuilder,
    $$DevTableTableUpdateCompanionBuilder,
    (
      DevTableData,
      BaseReferences<_$MainDatabase, $DevTableTable, DevTableData>
    ),
    DevTableData,
    PrefetchHooks Function()>;
typedef $$BrowserBookmarksTableCreateCompanionBuilder
    = BrowserBookmarksCompanion Function({
  required String id,
  required String title,
  required String url,
  required double sortingOrder,
  Value<int> rowid,
});
typedef $$BrowserBookmarksTableUpdateCompanionBuilder
    = BrowserBookmarksCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> url,
  Value<double> sortingOrder,
  Value<int> rowid,
});

class $$BrowserBookmarksTableFilterComposer
    extends Composer<_$MainDatabase, $BrowserBookmarksTable> {
  $$BrowserBookmarksTableFilterComposer({
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

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sortingOrder => $composableBuilder(
      column: $table.sortingOrder, builder: (column) => ColumnFilters(column));
}

class $$BrowserBookmarksTableOrderingComposer
    extends Composer<_$MainDatabase, $BrowserBookmarksTable> {
  $$BrowserBookmarksTableOrderingComposer({
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

  ColumnOrderings<double> get sortingOrder => $composableBuilder(
      column: $table.sortingOrder,
      builder: (column) => ColumnOrderings(column));
}

class $$BrowserBookmarksTableAnnotationComposer
    extends Composer<_$MainDatabase, $BrowserBookmarksTable> {
  $$BrowserBookmarksTableAnnotationComposer({
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

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<double> get sortingOrder => $composableBuilder(
      column: $table.sortingOrder, builder: (column) => column);
}

class $$BrowserBookmarksTableTableManager extends RootTableManager<
    _$MainDatabase,
    $BrowserBookmarksTable,
    BrowserBookmark,
    $$BrowserBookmarksTableFilterComposer,
    $$BrowserBookmarksTableOrderingComposer,
    $$BrowserBookmarksTableAnnotationComposer,
    $$BrowserBookmarksTableCreateCompanionBuilder,
    $$BrowserBookmarksTableUpdateCompanionBuilder,
    (
      BrowserBookmark,
      BaseReferences<_$MainDatabase, $BrowserBookmarksTable, BrowserBookmark>
    ),
    BrowserBookmark,
    PrefetchHooks Function()> {
  $$BrowserBookmarksTableTableManager(
      _$MainDatabase db, $BrowserBookmarksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrowserBookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrowserBookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrowserBookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<double> sortingOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BrowserBookmarksCompanion(
            id: id,
            title: title,
            url: url,
            sortingOrder: sortingOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String url,
            required double sortingOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              BrowserBookmarksCompanion.insert(
            id: id,
            title: title,
            url: url,
            sortingOrder: sortingOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BrowserBookmarksTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $BrowserBookmarksTable,
    BrowserBookmark,
    $$BrowserBookmarksTableFilterComposer,
    $$BrowserBookmarksTableOrderingComposer,
    $$BrowserBookmarksTableAnnotationComposer,
    $$BrowserBookmarksTableCreateCompanionBuilder,
    $$BrowserBookmarksTableUpdateCompanionBuilder,
    (
      BrowserBookmark,
      BaseReferences<_$MainDatabase, $BrowserBookmarksTable, BrowserBookmark>
    ),
    BrowserBookmark,
    PrefetchHooks Function()>;
typedef $$BrowserHistoryTableCreateCompanionBuilder = BrowserHistoryCompanion
    Function({
  required String id,
  required String title,
  required String url,
  required DateTime visitTime,
  Value<int> rowid,
});
typedef $$BrowserHistoryTableUpdateCompanionBuilder = BrowserHistoryCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> url,
  Value<DateTime> visitTime,
  Value<int> rowid,
});

class $$BrowserHistoryTableFilterComposer
    extends Composer<_$MainDatabase, $BrowserHistoryTable> {
  $$BrowserHistoryTableFilterComposer({
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

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get visitTime => $composableBuilder(
      column: $table.visitTime, builder: (column) => ColumnFilters(column));
}

class $$BrowserHistoryTableOrderingComposer
    extends Composer<_$MainDatabase, $BrowserHistoryTable> {
  $$BrowserHistoryTableOrderingComposer({
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

class $$BrowserHistoryTableAnnotationComposer
    extends Composer<_$MainDatabase, $BrowserHistoryTable> {
  $$BrowserHistoryTableAnnotationComposer({
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

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<DateTime> get visitTime =>
      $composableBuilder(column: $table.visitTime, builder: (column) => column);
}

class $$BrowserHistoryTableTableManager extends RootTableManager<
    _$MainDatabase,
    $BrowserHistoryTable,
    BrowserHistoryData,
    $$BrowserHistoryTableFilterComposer,
    $$BrowserHistoryTableOrderingComposer,
    $$BrowserHistoryTableAnnotationComposer,
    $$BrowserHistoryTableCreateCompanionBuilder,
    $$BrowserHistoryTableUpdateCompanionBuilder,
    (
      BrowserHistoryData,
      BaseReferences<_$MainDatabase, $BrowserHistoryTable, BrowserHistoryData>
    ),
    BrowserHistoryData,
    PrefetchHooks Function()> {
  $$BrowserHistoryTableTableManager(
      _$MainDatabase db, $BrowserHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrowserHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrowserHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrowserHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<DateTime> visitTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BrowserHistoryCompanion(
            id: id,
            title: title,
            url: url,
            visitTime: visitTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String url,
            required DateTime visitTime,
            Value<int> rowid = const Value.absent(),
          }) =>
              BrowserHistoryCompanion.insert(
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

typedef $$BrowserHistoryTableProcessedTableManager = ProcessedTableManager<
    _$MainDatabase,
    $BrowserHistoryTable,
    BrowserHistoryData,
    $$BrowserHistoryTableFilterComposer,
    $$BrowserHistoryTableOrderingComposer,
    $$BrowserHistoryTableAnnotationComposer,
    $$BrowserHistoryTableCreateCompanionBuilder,
    $$BrowserHistoryTableUpdateCompanionBuilder,
    (
      BrowserHistoryData,
      BaseReferences<_$MainDatabase, $BrowserHistoryTable, BrowserHistoryData>
    ),
    BrowserHistoryData,
    PrefetchHooks Function()>;

class $MainDatabaseManager {
  final _$MainDatabase _db;
  $MainDatabaseManager(this._db);
  $$DevTableTableTableManager get devTable =>
      $$DevTableTableTableManager(_db, _db.devTable);
  $$BrowserBookmarksTableTableManager get browserBookmarks =>
      $$BrowserBookmarksTableTableManager(_db, _db.browserBookmarks);
  $$BrowserHistoryTableTableManager get browserHistory =>
      $$BrowserHistoryTableTableManager(_db, _db.browserHistory);
}
