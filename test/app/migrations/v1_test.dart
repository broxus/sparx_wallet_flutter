import 'dart:io';

import 'package:app/app/service/storage_service/app_storage_service.dart';
import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v1.dart';
import 'package:app/feature/browser/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_tabs_storage_service.dart';

import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../helpers/helpers.dart';

class _MockEncryptedStorage extends Mock implements EncryptedStorage {}

class _MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = await Directory.systemTemp.createTemp('get_storage_v1_test');
    return dir.path;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  PathProviderPlatform.instance = _MockPathProviderPlatform();

  late _MockEncryptedStorage encryptedStorage;
  late StorageMigrationV1 migration;
  late List<String> domainsForCleanup;
  late InMemoryStorageAdapter storageAdapter;

  setUpAll(() {
    domainsForCleanup = [
      ...GeneralStorageService.containers,
      ...BalanceStorageService.containers,
      ConnectionsStorageService.container,
      BrowserBookmarksStorageService.container,
      BrowserFaviconURLStorageService.container,
      BrowserPermissionsStorageService.container,
      BrowserTabsStorageService.container,
    ];
  });

  setUp(() async {
    encryptedStorage = _MockEncryptedStorage();
    storageAdapter = InMemoryStorageAdapter();
    migration = StorageMigrationV1(encryptedStorage, storageAdapter);

    FlutterSecureStorage.setMockInitialValues(<String, String>{});

    await storageAdapter.init(AppStorageService.container);
    await storageAdapter.box(AppStorageService.container).erase();

    for (final d in domainsForCleanup) {
      await storageAdapter.init(d);
      await storageAdapter.box(d).erase();
    }
  });

  tearDown(() async {
    await storageAdapter.init(AppStorageService.container);
    await storageAdapter.box(AppStorageService.container).erase();

    for (final d in domainsForCleanup) {
      await storageAdapter.init(d);
      await storageAdapter.box(d).erase();
    }
  });

  group('StorageMigrationV1.apply', () {
    test('migrates sparx:* from FlutterSecureStorage '
        'to AppStorageService.container', () async {
      FlutterSecureStorage.setMockInitialValues({
        'sparx:boolTrue': 'true',
        'sparx:boolFalse': 'false',
        'sparx:string': 'hello',
        'other:key': 'true',
      });

      when(
        () => encryptedStorage.getDomain(domain: any(named: 'domain')),
      ).thenAnswer((_) async => <String, String>{});

      await migration.apply();

      final appStorage = storageAdapter.box(AppStorageService.container);

      expect(appStorage.hasData('sparx:boolTrue'), isTrue);
      expect(appStorage.read<bool>('sparx:boolTrue'), isTrue);

      expect(appStorage.hasData('sparx:boolFalse'), isTrue);
      expect(appStorage.read<bool>('sparx:boolFalse'), isFalse);

      expect(appStorage.hasData('sparx:string'), isTrue);
      expect(appStorage.read<String>('sparx:string'), 'hello');

      expect(appStorage.hasData('other:key'), isFalse);
    });

    test('migrates domains from EncryptedStorage to GetStorage', () async {
      final capturedDomains = <String>[];

      when(
        () => encryptedStorage.getDomain(domain: any(named: 'domain')),
      ).thenAnswer((invocation) async {
        final domain = invocation.namedArguments[#domain] as String;
        capturedDomains.add(domain);

        return <String, String>{
          'intValue': '123',
          'jsonMap': '{"a": 1, "b": "test"}',
          'plainString': 'not json',
        };
      });

      await migration.apply();

      expect(capturedDomains, isNotEmpty);

      for (final d in capturedDomains.toSet()) {
        final storage = storageAdapter.box(d);

        expect(storage.read<int>('intValue'), 123);

        final jsonMap = storage.read<Map<String, dynamic>>('jsonMap');
        expect(jsonMap, isA<Map<String, dynamic>>());
        expect(jsonMap?['a'], 1);
        expect(jsonMap?['b'], 'test');

        expect(storage.read<String>('plainString'), 'not json');
      }

      verify(
        () => encryptedStorage.getDomain(domain: any(named: 'domain')),
      ).called(capturedDomains.length);
    });
  });

  group('StorageMigrationV1.complete', () {
    test('removes sparx:* from FlutterSecureStorage '
        'and calls clearDomain for all used domains', () async {
      FlutterSecureStorage.setMockInitialValues({
        'sparx:one': '1',
        'sparx:two': '2',
        'other:key': 'keep-me',
      });

      final clearedDomains = <String>[];

      when(() => encryptedStorage.clearDomain(any())).thenAnswer((
        invocation,
      ) async {
        final domain = invocation.positionalArguments.first as String;
        clearedDomains.add(domain);
      });

      await migration.complete();

      const fss = FlutterSecureStorage();
      final all = await fss.readAll();

      expect(all.keys.any((k) => k.startsWith('sparx:')), isFalse);

      expect(all['other:key'], 'keep-me');

      expect(clearedDomains, isNotEmpty);

      verify(
        () => encryptedStorage.clearDomain(any()),
      ).called(clearedDomains.length);

      verifyNoMoreInteractions(encryptedStorage);
    });
  });
}
