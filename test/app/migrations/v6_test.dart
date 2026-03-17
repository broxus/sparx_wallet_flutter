import 'dart:io';

import 'package:app/app/service/database/database_service.dart';
import 'package:app/app/service/database/delegates/browser_history_database_delegate.dart';
import 'package:app/app/service/database/delegates/migration_delegate.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v6.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../helpers/helpers.dart';

class _MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = await Directory.systemTemp.createTemp('get_storage_v6_test');
    return dir.path;
  }
}

class _MockDatabaseService extends Mock implements DatabaseService {}

class _MockMigrationDelegate extends Mock implements MigrationDelegate {}

class _MockHistoryDelegate extends Mock
    implements BrowserHistoryDatabaseDelegate {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  PathProviderPlatform.instance = _MockPathProviderPlatform();

  const box = 'browser_history';
  const key = 'browser_history_key';

  late _MockDatabaseService databaseService;
  late _MockMigrationDelegate migrationApi;
  late _MockHistoryDelegate historyApi;

  late InMemoryStorageAdapter storageAdapter;
  late StorageMigrationV6 sut;

  setUpAll(() {
    registerFallbackValue(<BrowserHistoryItem>[]);
  });

  setUp(() async {
    databaseService = _MockDatabaseService();
    migrationApi = _MockMigrationDelegate();
    historyApi = _MockHistoryDelegate();

    when(() => databaseService.migration).thenReturn(migrationApi);
    when(() => databaseService.history).thenReturn(historyApi);

    when(
      () => migrationApi.checkHistoryMigration(),
    ).thenAnswer((_) async => false);
    when(() => migrationApi.acceptHistoryMigration()).thenAnswer((_) async {});

    when(
      () =>
          historyApi.saveHistoryItemsList(any<Iterable<BrowserHistoryItem>>()),
    ).thenAnswer((_) async {});

    storageAdapter = InMemoryStorageAdapter();
    sut = StorageMigrationV6(databaseService, storageAdapter);

    await storageAdapter.init(box);
    await storageAdapter.box(box).erase();
  });

  tearDown(() async {
    await storageAdapter.init(box);
    await storageAdapter.box(box).erase();
  });

  group('StorageMigrationV6.apply', () {
    test('When migration flag is true - return', () async {
      when(
        () => migrationApi.checkHistoryMigration(),
      ).thenAnswer((_) async => true);

      final storage = storageAdapter.box(box);
      await storage.write(key, [
        _validJson(
          id: '1',
          title: 't',
          url: 'https://a.com',
          visitTime: DateTime.utc(2025),
        ),
      ]);

      await sut.apply();

      verify(() => migrationApi.checkHistoryMigration()).called(1);
      verifyNever(() => historyApi.saveHistoryItemsList(any()));
      verifyNever(() => migrationApi.acceptHistoryMigration());

      expect(storage.read<List<dynamic>>(key), isNotNull);
    });

    test('When list is null accept migration and erase, no save', () async {
      final storage = storageAdapter.box(box);

      await storage.write('test', 1);
      expect(storage.read<Object?>('test'), 1);
      expect(storage.read<List<dynamic>>(key), isNull);

      await sut.apply();

      verify(() => migrationApi.checkHistoryMigration()).called(1);
      verifyNever(() => historyApi.saveHistoryItemsList(any()));
      verify(() => migrationApi.acceptHistoryMigration()).called(1);

      expect(storage.read<Object?>('test'), isNull);
      expect(storage.read<List<dynamic>>(key), isNull);
    });

    test('List is empty - accept migration and erase, no save', () async {
      final storage = storageAdapter.box(box);
      await storage.write(key, <dynamic>[]);

      await sut.apply();

      verify(() => migrationApi.checkHistoryMigration()).called(1);
      verifyNever(() => historyApi.saveHistoryItemsList(any()));
      verify(() => migrationApi.acceptHistoryMigration()).called(1);

      expect(storage.read<List<dynamic>>(key), isNull);
    });

    test('Save valid items', () async {
      final storage = storageAdapter.box(box);
      await storage.write(key, [
        _validJson(
          id: '1',
          title: 'A',
          url: 'https://a.com',
          visitTime: DateTime.utc(2025),
        ),
        _validJson(
          id: '2',
          title: 'B',
          url: 'https://b.com',
          visitTime: DateTime.utc(2025, 1, 2),
        ),
      ]);

      await sut.apply();

      final captured =
          verify(
                () => historyApi.saveHistoryItemsList(
                  captureAny<Iterable<BrowserHistoryItem>>(),
                ),
              ).captured.single
              as Iterable<BrowserHistoryItem>;

      expect(captured.length, 2);
      expect(captured.map((e) => e.id), ['1', '2']);
      expect(captured.map((e) => e.title), ['A', 'B']);
      expect(captured.map((e) => e.url.toString()), [
        'https://a.com',
        'https://b.com',
      ]);

      verify(() => migrationApi.acceptHistoryMigration()).called(1);
      expect(storage.read<List<dynamic>>(key), isNull);
    });

    test('Skip broken items, save only valid items', () async {
      final storage = storageAdapter.box(box);

      await storage.write(key, [
        1,
        'test',
        {'definitely': 'wrong-shape'},
        _validJson(
          id: 'ok',
          title: 'OK',
          url: 'https://ok.com',
          visitTime: DateTime.utc(2025, 1, 3),
        ),
      ]);

      await sut.apply();

      final captured =
          verify(
                () => historyApi.saveHistoryItemsList(
                  captureAny<Iterable<BrowserHistoryItem>>(),
                ),
              ).captured.single
              as Iterable<BrowserHistoryItem>;

      expect(captured.length, 1);
      expect(captured.first.id, 'ok');
      expect(captured.first.title, 'OK');
      expect(captured.first.url.toString(), 'https://ok.com');

      verify(() => migrationApi.acceptHistoryMigration()).called(1);
      expect(storage.read<List<dynamic>>(key), isNull);
    });

    test('List has only broken items', () async {
      final storage = storageAdapter.box(box);

      await storage.write(key, [
        1,
        'test',
        {'definitely': 'wrong-shape'},
      ]);

      await sut.apply();

      verify(() => migrationApi.checkHistoryMigration()).called(1);
      verifyNever(() => historyApi.saveHistoryItemsList(any()));
      verify(() => migrationApi.acceptHistoryMigration()).called(1);

      expect(storage.read<List<dynamic>>(key), isNull);
    });

    test(
      'If db save throws, migration is not accepted and storage is not erased',
      () async {
        final storage = storageAdapter.box(box);

        await storage.write(key, [
          _validJson(
            id: '1',
            title: 'test',
            url: 'https://a.com',
            visitTime: DateTime.utc(2025),
          ),
        ]);

        when(
          () => historyApi.saveHistoryItemsList(
            any<Iterable<BrowserHistoryItem>>(),
          ),
        ).thenThrow(Exception('db down'));

        await expectLater(sut.apply(), throwsA(isA<Exception>()));

        verify(() => historyApi.saveHistoryItemsList(any())).called(1);
        verifyNever(() => migrationApi.acceptHistoryMigration());

        expect(storage.read<List<dynamic>>(key), isNotNull);
      },
    );

    test(
      'GetStorage returns Map<String, dynamic> entries for history list',
      () async {
        final storage = storageAdapter.box(box);

        await storage.write(key, [
          _validJson(
            id: '1',
            title: 'test',
            url: 'https://a.com',
            visitTime: DateTime.utc(2025),
          ),
        ]);

        final list = storage.read<List<dynamic>>(key);
        expect(list, isNotNull);

        final entry = list!.single;
        expect(entry, isA<Map<String, dynamic>>());

        final m = entry as Map;
        expect(m.keys.every((k) => k is String), isTrue);
      },
    );
  });
}

Map<String, dynamic> _validJson({
  required String id,
  required String title,
  required String url,
  required DateTime visitTime,
}) {
  return {
    'id': id,
    'title': title,
    'url': url,
    'visitTime': visitTime.toUtc().toIso8601String(),
  };
}
