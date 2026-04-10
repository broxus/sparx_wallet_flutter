import 'package:app/app/service/database/database_service.dart';
import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migration_service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class _MockEncryptedStorage extends Mock implements EncryptedStorage {}

class _MockPresetsConnectionService extends Mock
    implements PresetsConnectionService {}

class _MockGeneralStorageService extends Mock
    implements GeneralStorageService {}

class _MockConnectionsStorageService extends Mock
    implements ConnectionsStorageService {}

class _MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  group('StorageMigrationService', () {
    late _MockEncryptedStorage encryptedStorage;
    late _MockPresetsConnectionService presetsConnectionService;
    late _MockGeneralStorageService generalStorageService;
    late _MockConnectionsStorageService connectionsStorageService;
    late _MockDatabaseService databaseService;
    late InMemoryStorageAdapter storageAdapter;

    setUp(() {
      encryptedStorage = _MockEncryptedStorage();
      presetsConnectionService = _MockPresetsConnectionService();
      generalStorageService = _MockGeneralStorageService();
      connectionsStorageService = _MockConnectionsStorageService();
      databaseService = _MockDatabaseService();
      storageAdapter = InMemoryStorageAdapter();
    });

    StorageMigrationService createService() => StorageMigrationService(
      encryptedStorage,
      presetsConnectionService,
      generalStorageService,
      connectionsStorageService,
      databaseService,
      storageAdapter,
    );

    test('needMigration is false for the latest version', () async {
      await storageAdapter.box().write('version', 7);

      final service = createService();

      expect(service.currentVersion, 7);
      expect(service.needMigration, isFalse);

      await service.migrate();

      expect(storageAdapter.box().read<int>('version'), 7);
    });

    test(
      'migrate from version 6 applies v7 migration and writes latest version',
      () async {
        await storageAdapter.box().write('version', 6);
        await storageAdapter.box(ConnectionsStorageService.container).write(
          'connections',
          [
            {
              'id': 'custom-1',
              'name': 'Custom Network',
              'networkType': 'ever',
              'group': 'mainnet',
              'runtimeType': 'jrpc',
              'endpoint': 'https://custom.example',
              'blockExplorerUrl': 'https://explorer.example',
              'manifestUrl': 'https://manifest.example',
              'nativeTokenDecimals': 9,
              'isPreset': false,
            },
          ],
        );
        await storageAdapter.box(ConnectionsStorageService.container).write(
          'networks_ids',
          {'custom-1-0': 42},
        );

        final service = createService();

        await service.migrate();

        final storage = storageAdapter.box(ConnectionsStorageService.container);
        final migrated = storage.read<List<dynamic>>('connections');

        expect(storageAdapter.box().read<int>('version'), 7);
        expect(storage.read<dynamic>('networks_ids'), isNull);
        expect(migrated, hasLength(1));
        expect(
          (migrated?.first as Map<String, dynamic>)['networkName'],
          'Custom Network',
        );
      },
    );

    test(
      'migrate still writes latest version when a migration throws',
      () async {
        await storageAdapter.box().write('version', 6);
        await storageAdapter.box(ConnectionsStorageService.container).write(
          'connections',
          [
            {
              'id': 'broken',
              'name': 'Broken',
              'networkType': 'ever',
              'group': 'mainnet',
              'runtimeType': 'unsupported',
              'endpoint': 'https://broken.example',
              'blockExplorerUrl': 'https://explorer.example',
              'manifestUrl': 'https://manifest.example',
              'nativeTokenDecimals': 9,
              'isPreset': false,
            },
          ],
        );

        final service = createService();

        await service.migrate();

        expect(storageAdapter.box().read<int>('version'), 7);
      },
    );
  });
}
