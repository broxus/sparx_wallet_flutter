import 'dart:io';

import 'package:app/app/service/database/delegates/browser_history_database_delegate.dart';
import 'package:app/app/service/database/main_database.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../../test_helpers/fake_path_provider_platform.dart';


class _ThrowingPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() {
    throw StateError(
      'PathProvider used before test setUp(): '
      'MainDatabase was created too early',
    );
  }
}

BrowserHistoryItem _item({
  required String id,
  required String title,
  required String url,
  required DateTime visitTime,
}) {
  return BrowserHistoryItem(
    id: id,
    title: title,
    url: Uri.parse(url),
    visitTime: visitTime,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late MainDatabase db;
  late BrowserHistoryDatabaseDelegate delegate;

  setUpAll(() {
    // If the base is accidentally created before setUp, then PathProvider will
    // be called and the test should fail to avoid accessing the real path.
    PathProviderPlatform.instance = _ThrowingPathProviderPlatform();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('drift_main_db_test_');
    PathProviderPlatform.instance = FakePathProviderPlatform(tempDir);

    db = MainDatabase();
    delegate = BrowserHistoryDatabaseDelegate(db);

    await delegate.getItems();
  });

  tearDown(() async {
    await db.close();
    try {
      await tempDir.delete(recursive: true);
    } catch (_) {}
  });

  test('DB file is created in application documents dir', () async {
    final expectedPath = p.join(tempDir.path, 'main.db');
    expect(File(expectedPath).existsSync(), isTrue);
  });

  test('db is not created in project directory', () async {
    expect(File('main.db').existsSync(), isFalse);
  });

  test('saveHistoryItem: inserts and getHistoryItemById returns it', () async {
    final t = DateTime.utc(2026, 2, 5, 10);
    final x = _item(
      id: '1',
      title: 'Hello',
      url: 'https://example.com/',
      visitTime: t,
    );

    await delegate.saveHistoryItem(x);

    final got = await delegate.getHistoryItemById('1');
    expect(got, isNotNull);
    expect(got!.id, '1');
    expect(got.title, 'Hello');
    expect(got.url, Uri.parse('https://example.com/'));
    expect(got.visitTime.toUtc(), t);
  });

  test(
    'saveHistoryItem: upsert updates existing row (insertOnConflictUpdate)',
    () async {
      final t1 = DateTime.utc(2026, 2, 5, 10);
      final t2 = DateTime.utc(2026, 2, 5, 11);

      await delegate.saveHistoryItem(
        _item(
          id: 'same',
          title: 'Old',
          url: 'https://example.com/old',
          visitTime: t1,
        ),
      );

      await delegate.saveHistoryItem(
        _item(
          id: 'same',
          title: 'New',
          url: 'https://example.com/new',
          visitTime: t2,
        ),
      );

      final got = await delegate.getHistoryItemById('same');
      expect(got, isNotNull);
      expect(got!.title, 'New');
      expect(got.url, Uri.parse('https://example.com/new'));
      expect(got.visitTime.toUtc(), t2);
    },
  );

  test('getItems (no search): returns ordered by '
      'visitTime DESC and limited to 100', () async {
    final base = DateTime.utc(2026, 2, 5);

    final items = List.generate(105, (i) {
      final dt = base.add(Duration(minutes: i));
      return _item(
        id: 'id_$i',
        title: 'Title $i',
        url: 'https://example.com/$i',
        visitTime: dt,
      );
    });

    await delegate.saveHistoryItemsList(items);

    final got = await delegate.getItems();
    expect(got.length, 100);

    expect(got.first.id, 'id_104');
    expect(got.last.id, 'id_5');

    for (var i = 0; i < 5; i++) {
      final row = await delegate.getHistoryItemById('id_$i');
      expect(row, isNull);
    }
  });

  test('watchHistory (no search): emits ordered '
      'by visitTime DESC and updates on insert', () async {
    final q = StreamQueue(delegate.watchHistory());

    final first = await q.next;
    expect(first, isEmpty);

    final t1 = DateTime.utc(2026, 2, 5, 10);
    final t2 = DateTime.utc(2026, 2, 5, 11);

    await delegate.saveHistoryItem(
      _item(id: 'a', title: 'A', url: 'https://a.com', visitTime: t1),
    );

    final afterA = await q.next;
    expect(afterA.map((e) => e.id).toList(), ['a']);

    await delegate.saveHistoryItem(
      _item(id: 'b', title: 'B', url: 'https://b.com', visitTime: t2),
    );

    final afterB = await q.next;
    expect(afterB.map((e) => e.id).toList(), ['b', 'a']);

    await q.cancel();
  });

  test(
    'watchHistory: supports multiple listeners (broadcast stream)',
    () async {
      final s = delegate.watchHistory('test');

      final sub1 = s.listen((_) {});
      final sub2 = s.listen((_) {});

      await sub1.cancel();
      await sub2.cancel();
    },
  );

  test('search: matches by norm(title) with ё->е and trim/case', () async {
    final t = DateTime.utc(2026, 2, 5, 10);

    await delegate.saveHistoryItem(
      _item(
        id: '0',
        title: '  Test  ',
        url: 'https://somewhere.com',
        visitTime: t,
      ),
    );

    final got1 = await delegate.getItems('test');
    expect(got1.map((e) => e.id), contains('0'));

    final got2 = await delegate.getItems('  TEST  ');
    expect(got2.map((e) => e.id), contains('0'));
  });

  test('search: matches by norm_url(url): lower host, strips www., '
      'uses path, ignores query', () async {
    final t = DateTime.utc(2026, 2, 5, 10);

    await delegate.saveHistoryItem(
      _item(
        id: 'u',
        title: 'Anything',
        url: 'https://WWW.Example.COM/Path/Page?X=1&Y=2',
        visitTime: t,
      ),
    );

    final got = await delegate.getItems('example.com/path');
    expect(got.map((e) => e.id), contains('u'));
  });

  test('search: escapes LIKE wildcards %, _ and backslash', () async {
    final t = DateTime.utc(2026, 2, 5, 10);

    await delegate.saveHistoryItem(
      _item(
        id: 'like',
        title: r'100%_test\name',
        url: 'https://example.com',
        visitTime: t,
      ),
    );

    final got = await delegate.getItems(r'100%_test\name');
    expect(got.length, 1);
    expect(got.single.id, 'like');
  });

  test(
    'watchHistoryCount: emits count and updates on insert/delete/clear',
    () async {
      final q = StreamQueue(delegate.watchHistoryCount());

      final first = await q.next;
      expect(first, 0);

      final t = DateTime.utc(2026, 2, 5, 10);
      await delegate.saveHistoryItem(
        _item(id: '1', title: 'T1', url: 'https://1.com', visitTime: t),
      );

      final afterInsert = await q.next;
      expect(afterInsert, 1);

      await delegate.deleteHistoryItem('1');
      final afterDelete = await q.next;
      expect(afterDelete, 0);

      await delegate.saveHistoryItem(
        _item(id: '2', title: 'T2', url: 'https://2.com', visitTime: t),
      );
      await q.next;

      await delegate.clearHistory();
      final afterClear = await q.next;
      expect(afterClear, 0);

      await q.cancel();
    },
  );

  test('deleteHistoryItem removes by id', () async {
    final t = DateTime.utc(2026, 2, 5, 10);

    await delegate.saveHistoryItemsList([
      _item(id: 'a', title: 'A', url: 'https://a.com', visitTime: t),
      _item(id: 'b', title: 'B', url: 'https://b.com', visitTime: t),
    ]);

    await delegate.deleteHistoryItem('a');

    final got = await delegate.getItems();
    expect(got.map((e) => e.id), isNot(contains('a')));
    expect(got.map((e) => e.id), contains('b'));
  });

  test('deleteHistoryItemByUri removes by exact url string', () async {
    final t = DateTime.utc(2026, 2, 5, 10);

    final uri = Uri.parse('https://example.com/x');
    await delegate.saveHistoryItem(
      _item(id: 'x', title: 'X', url: uri.toString(), visitTime: t),
    );

    await delegate.deleteHistoryItemByUri(uri);

    final got = await delegate.getItems();
    expect(got, isEmpty);
  });

  test('deleteHistoryByPeriod deletes items with visitTime > date', () async {
    final base = DateTime.utc(2026, 2, 5, 10);

    await delegate.saveHistoryItemsList([
      _item(id: 'old', title: 'Old', url: 'https://old', visitTime: base),
      _item(
        id: 'new',
        title: 'New',
        url: 'https://new',
        visitTime: base.add(const Duration(minutes: 1)),
      ),
    ]);

    final deleted = await delegate.deleteHistoryByPeriod(base);
    expect(deleted, 1);

    final got = await delegate.getItems();
    expect(got.map((e) => e.id).toList(), ['old']);
  });

  test(
    'clearHistoryByDates deletes items in inclusive range (between values)',
    () async {
      final t0 = DateTime.utc(2026, 2, 5, 10);
      final t1 = DateTime.utc(2026, 2, 5, 10, 1);
      final t2 = DateTime.utc(2026, 2, 5, 10, 2);

      await delegate.saveHistoryItemsList([
        _item(id: 'a', title: 'A', url: 'https://a', visitTime: t0),
        _item(id: 'b', title: 'B', url: 'https://b', visitTime: t1),
        _item(id: 'c', title: 'C', url: 'https://c', visitTime: t2),
      ]);

      await delegate.clearHistoryByDates(t1, t2);

      final got = await delegate.getItems();
      expect(got.map((e) => e.id), ['a']);
    },
  );
}
