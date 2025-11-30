import 'package:app/app/service/database/database_service.dart';
import 'package:app/app/service/database/delegates/permissions_delegate.dart'
    as db_permissions;
import 'package:app/data/models/permissions.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_permissions_delegate.dart';
import 'package:app/feature/browser/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class MockBrowserPermissionsStorageService extends Mock
    implements BrowserPermissionsStorageService {}

class MockDatabaseService extends Mock implements DatabaseService {}

class MockDbPermissionsDelegate extends Mock
    implements db_permissions.PermissionsDelegate {}

void main() {
  late MockBrowserPermissionsStorageService storage;
  late MockDatabaseService database;
  late MockDbPermissionsDelegate dbPerms;
  late BrowserServicePermissionsDelegate delegate;

  setUpAll(() {
    registerFallbackValue(const Address(address: ''));
  });

  setUp(() {
    storage = MockBrowserPermissionsStorageService();
    database = MockDatabaseService();
    dbPerms = MockDbPermissionsDelegate();

    when(() => database.permissions).thenReturn(dbPerms);

    delegate = BrowserServicePermissionsDelegate(storage, database);
  });

  group('init', () {
    test('Load permissions from storage', () {
      const perms = Permissions();

      when(
        () => storage.getPermissions(),
      ).thenReturn({'https://example.com': perms});

      delegate.init();

      verify(() => storage.getPermissions()).called(1);
      expect(delegate.permissionsStream.value, {'https://example.com': perms});
    });
  });

  group('Manage permissions', () {
    test('setPermissions', () {
      const origin = 'https://example.com';

      const perms = Permissions();

      when(
        () => storage.setPermissions(origin: origin, permissions: perms),
      ).thenReturn(null);

      when(() => storage.getPermissions()).thenReturn({origin: perms});

      delegate.setPermissions(origin: origin, permissions: perms);

      verify(
        () => storage.setPermissions(origin: origin, permissions: perms),
      ).called(1);

      verify(() => storage.getPermissions()).called(1);

      expect(delegate.permissionsStream.value[origin], same(perms));
    });

    test('Remove permission for origin', () {
      const origin = 'https://example.com';

      when(() => storage.deletePermissionsForOrigin(origin)).thenReturn(null);

      when(() => storage.getPermissions()).thenReturn({});

      delegate.deletePermissionsForOrigin(origin);

      verify(() => storage.deletePermissionsForOrigin(origin)).called(1);
      verify(() => storage.getPermissions()).called(1);

      expect(delegate.permissionsStream.value, isEmpty);
    });

    test('checkHostPermissions', () async {
      when(
        () => dbPerms.checkPermissions('example.com', ['cam', 'mic']),
      ).thenAnswer((_) async => true);

      final result = await delegate.checkHostPermissions('example.com', [
        'cam',
        'mic',
      ]);

      expect(result, isTrue);
      verify(
        () => dbPerms.checkPermissions('example.com', ['cam', 'mic']),
      ).called(1);
    });

    test('saveHostPermissions', () async {
      when(
        () => dbPerms.savePermissions('example.com', ['cam', 'mic']),
      ).thenAnswer((_) async {});

      await delegate.saveHostPermissions('example.com', ['cam', 'mic']);

      verify(
        () => dbPerms.savePermissions('example.com', ['cam', 'mic']),
      ).called(1);
    });

    test('clearPermissions', () async {
      when(() => storage.clearPermissions()).thenAnswer((_) async {});
      when(() => dbPerms.clearAllPermissions()).thenAnswer((_) async => 1);

      // предварительно положим что-то в стрим
      when(
        () => storage.getPermissions(),
      ).thenReturn({'https://example.com': Permissions()});
      delegate.init();
      expect(delegate.permissionsStream.value, isNotEmpty);

      await delegate.clearPermissions();

      verify(() => storage.clearPermissions()).called(1);
      verify(() => dbPerms.clearAllPermissions()).called(1);

      expect(delegate.permissionsStream.value, isEmpty);
    });
  });
}
