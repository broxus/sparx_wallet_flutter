import 'package:app/app/service/storage_service/storage_adapter.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class MockStorageAdapter extends Mock implements StorageAdapter {}

class MockStorageBox extends Mock implements StorageBox {}

class MockBridge extends Mock implements NekotonBridgeApi {}

void main() {
  late MockStorageAdapter storageAdapter;
  late MockStorageBox storageBox;
  late BrowserPermissionsStorageService service;

  final bridge = MockBridge();

  setUp(() {
    storageAdapter = MockStorageAdapter();
    storageBox = MockStorageBox();
    when(
      () => storageAdapter.box(BrowserPermissionsStorageService.container),
    ).thenReturn(storageBox);
    service = BrowserPermissionsStorageService(storageAdapter);
  });

  setUpAll(() {
    NekotonBridge.initMock(api: bridge);
  });

  group('permissions', () {
    test('Empty permissions', () {
      when(() => storageBox.getEntries()).thenReturn({});

      final result = service.getPermissions();

      expect(result, isEmpty);
      verify(() => storageBox.getEntries()).called(1);
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

      when(() => storageBox.getEntries()).thenReturn({origin: permissionsJson});

      when(
        () => bridge.crateApiMergedNtValidateAddress(
          address: any(named: 'address'),
        ),
      ).thenReturn(false);

      final result = service.getPermissions();

      expect(result.length, 1);
      expect(result.containsKey(origin), isTrue);
      expect(result[origin], isA<Permissions>());
      expect(result[origin]!.toJson(), equals(permissionsJson));

      verify(() => storageBox.getEntries()).called(1);
    });

    test('save permissions', () async {
      const origin = 'https://dapp.io';

      const permissions = Permissions();

      when(
        () => storageBox.write(origin, permissions.toJson()),
      ).thenAnswer((_) async {});

      service.setPermissions(origin: origin, permissions: permissions);

      verify(() => storageBox.write(origin, permissions.toJson())).called(1);
    });

    test('Removes permissions', () async {
      const origin = 'https://to-remove.io';

      when(() => storageBox.remove(origin)).thenAnswer((_) async {});
      when(() => storageBox.hasData(origin)).thenReturn(true);

      service.deletePermissionsForOrigin(origin);

      verify(() => storageBox.remove(origin)).called(1);
    });
  });
}
