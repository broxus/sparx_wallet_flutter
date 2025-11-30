import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  late MockGetStorage storage;
  late BrowserPermissionsStorageService service;

  setUp(() {
    storage = MockGetStorage();
    service = BrowserPermissionsStorageService(storage);
  });

  group('permissions', () {
    test('Empty permissions', () {
      when(
        () => storage.getKeys<Iterable<String>>(),
      ).thenReturn(const <String>[]);

      when(
        () => storage.getValues<Iterable<dynamic>>(),
      ).thenReturn(const <dynamic>[]);

      final result = service.getPermissions();

      expect(result, isEmpty);
      verify(() => storage.getKeys<Iterable<String>>()).called(1);
    });

    test('Exist permissions', () {
      const origin = 'https://example.com';

      final permissionsJson = <String, dynamic>{
        'basic': true,
        'accountInteraction': {
          'address': '0:abc123exampleaddress',
          'publicKey': 'ed25519:deadbeefcafebabe',
          'contractType': 'WalletV4R2',
        },
      };

      when(() => storage.getKeys<Iterable<String>>()).thenReturn([origin]);

      when(
        () => storage.getValues<Iterable<dynamic>>(),
      ).thenReturn([permissionsJson]);

      final result = service.getPermissions();

      expect(result.length, 1);
      expect(result.containsKey(origin), isTrue);
      expect(result[origin], isA<Permissions>());
      expect(result[origin]!.toJson(), equals(permissionsJson));

      verify(() => storage.getKeys<Iterable<String>>()).called(1);
      verify(() => storage.getValues<Iterable<dynamic>>()).called(1);
    });

    test('save permissions', () async {
      const origin = 'https://dapp.io';

      const permissions = Permissions();

      when(
        () => storage.write(origin, permissions.toJson()),
      ).thenAnswer((_) async {});

      service.setPermissions(origin: origin, permissions: permissions);

      verify(() => storage.write(origin, permissions.toJson())).called(1);
    });

    test('Removes permissions', () async {
      const origin = 'https://to-remove.io';

      when(() => storage.remove(origin)).thenAnswer((_) async {});

      service.deletePermissionsForOrigin(origin);

      verify(() => storage.remove(origin)).called(1);
    });
  });
}
