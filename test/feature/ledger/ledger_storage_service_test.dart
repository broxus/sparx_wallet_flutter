import 'package:app/app/service/storage_service/storage_adapter.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockStorageAdapter extends Mock implements StorageAdapter {}

class _MockStorageBox extends Mock implements StorageBox {}

void main() {
  group('LedgerStorageService', () {
    const connectedKey = 'connected_ledgers';

    late LedgerStorageService service;
    late _MockStorageAdapter storageAdapter;
    late _MockStorageBox storageBox;

    setUp(() {
      storageAdapter = _MockStorageAdapter();
      storageBox = _MockStorageBox();
      when(
        () => storageAdapter.box(LedgerStorageService.container),
      ).thenReturn(storageBox);
      service = LedgerStorageService(storageAdapter);

      when(
        () => storageBox.write(any<String>(), any<dynamic>()),
      ).thenAnswer((_) async {});
      when(() => storageBox.erase()).thenAnswer((_) async {});
    });

    test('readConnectedLedgers decodes stored list', () {
      // Arrange
      const connected = ConnectedLedger(
        remoteId: 'remote-1',
        masterKey: PublicKey(publicKey: 'master-1'),
        deviceModelId: DeviceModelId.nanoX,
      );
      when(
        () => storageBox.read<List<dynamic>>(connectedKey),
      ).thenReturn([connected.toJson()]);

      // Act
      final result = service.readConnectedLedgers();

      // Assert
      expect(result, hasLength(1));
      expect(result.first.remoteId, equals('remote-1'));
      expect(result.first.deviceModelId, equals(DeviceModelId.nanoX));
      expect(result.first.masterKey.publicKey, equals('master-1'));
    });

    test('addConnectedLedger stores and publishes ledger', () {
      // Arrange
      when(() => storageBox.read<List<dynamic>>(connectedKey)).thenReturn([]);
      const connected = ConnectedLedger(
        remoteId: 'remote-2',
        masterKey: PublicKey(publicKey: 'master-2'),
        deviceModelId: DeviceModelId.stax,
      );

      // Act
      service.addConnectedLedger(connected);

      // Assert
      expect(service.connected[connected.masterKey], equals(connected));
      verify(
        () => storageBox.write(connectedKey, [connected.toJson()]),
      ).called(1);
    });

    test('removeConnectedLedger removes stored entry', () {
      // Arrange
      when(() => storageBox.read<List<dynamic>>(connectedKey)).thenReturn([]);
      const connected = ConnectedLedger(
        remoteId: 'remote-3',
        masterKey: PublicKey(publicKey: 'master-3'),
        deviceModelId: DeviceModelId.europa,
      );
      service.addConnectedLedger(connected);

      // Act
      // ignore: cascade_invocations
      service.removeConnectedLedger(connected.masterKey);

      // Assert
      expect(service.connected.containsKey(connected.masterKey), isFalse);
      verify(
        () => storageBox.write(connectedKey, <Map<String, dynamic>>[]),
      ).called(1);
    });
  });
}
