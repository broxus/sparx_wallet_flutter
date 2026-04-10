import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v5.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGeneralStorageService extends Mock
    implements GeneralStorageService {}

class _MockConnectionsStorageService extends Mock
    implements ConnectionsStorageService {}

Connection _connection({required String id, required String networkGroup}) {
  final workchain = ConnectionWorkchain.custom(
    id: 0,
    parentConnectionId: id,
    networkType: NetworkType.empty(),
    networkName: 'Network $id',
    endpoints: const ['https://endpoint.example'],
    blockExplorerUrl: 'https://explorer.example',
    manifestUrl: 'https://manifest.example',
    networkGroup: networkGroup,
  );

  return Connection(
    id: id,
    networkName: 'Network $id',
    defaultWorkchainId: 0,
    workchains: [workchain],
    isPreset: false,
    canBeEdited: true,
  );
}

void main() {
  group('StorageMigrationV5', () {
    late _MockGeneralStorageService generalStorageService;
    late _MockConnectionsStorageService connectionsStorageService;
    late StorageMigrationV5 migration;

    setUp(() {
      generalStorageService = _MockGeneralStorageService();
      connectionsStorageService = _MockConnectionsStorageService();
      migration = StorageMigrationV5(
        generalStorageService,
        connectionsStorageService,
      );

      when(
        () => generalStorageService.readRawCustomAssets('custom'),
      ).thenReturn([
        {'address': '0:custom-asset'},
      ]);
      when(
        () => generalStorageService.readRawSystemAssets('custom'),
      ).thenReturn([
        {'address': '0:system-asset'},
      ]);
      when(
        () => generalStorageService.removeRawCustomAssets('custom'),
      ).thenAnswer((_) async {});
      when(
        () => generalStorageService.removeRawSystemAssets('custom'),
      ).thenAnswer((_) async {});
      when(
        () => generalStorageService.writeRawCustomAssets(any(), any()),
      ).thenAnswer((_) async {});
      when(
        () => generalStorageService.writeRawSystemAssets(any(), any()),
      ).thenAnswer((_) async {});
      when(
        () => connectionsStorageService.updateConnection(any()),
      ).thenReturn(null);
    });

    setUpAll(() {
      registerFallbackValue(
        _connection(id: 'fallback', networkGroup: 'custom'),
      );
    });

    test(
      'moves each custom connection to a unique generated network group',
      () async {
        when(() => connectionsStorageService.connections).thenReturn([
          _connection(id: 'custom-1', networkGroup: 'custom'),
          _connection(id: 'mainnet-1', networkGroup: 'mainnet'),
          _connection(id: 'custom-2', networkGroup: 'custom'),
        ]);

        await migration.apply();

        final updatedConnections = verify(
          () => connectionsStorageService.updateConnection(captureAny()),
        ).captured.cast<Connection>();

        expect(updatedConnections, hasLength(2));
        expect(updatedConnections[0].id, 'custom-1');
        expect(
          updatedConnections[0].defaultWorkchain.networkGroup,
          'custom-10000',
        );
        expect(updatedConnections[1].id, 'custom-2');
        expect(
          updatedConnections[1].defaultWorkchain.networkGroup,
          'custom-10001',
        );

        verify(
          () => generalStorageService.removeRawCustomAssets('custom'),
        ).called(1);
        verify(
          () => generalStorageService.removeRawSystemAssets('custom'),
        ).called(1);
        verify(
          () => generalStorageService.writeRawCustomAssets('custom-10000', [
            {'address': '0:custom-asset'},
          ]),
        ).called(1);
        verify(
          () => generalStorageService.writeRawSystemAssets('custom-10000', [
            {'address': '0:system-asset'},
          ]),
        ).called(1);
        verify(
          () => generalStorageService.writeRawCustomAssets('custom-10001', [
            {'address': '0:custom-asset'},
          ]),
        ).called(1);
        verify(
          () => generalStorageService.writeRawSystemAssets('custom-10001', [
            {'address': '0:system-asset'},
          ]),
        ).called(1);
      },
    );

    test(
      'does not update connections or rewrite assets for non-custom groups',
      () async {
        when(
          () => connectionsStorageService.connections,
        ).thenReturn([_connection(id: 'mainnet-1', networkGroup: 'mainnet')]);

        await migration.apply();

        verifyNever(() => connectionsStorageService.updateConnection(any()));
        verifyNever(
          () => generalStorageService.writeRawCustomAssets(any(), any()),
        );
        verifyNever(
          () => generalStorageService.writeRawSystemAssets(any(), any()),
        );
        verify(
          () => generalStorageService.removeRawCustomAssets('custom'),
        ).called(1);
        verify(
          () => generalStorageService.removeRawSystemAssets('custom'),
        ).called(1);
      },
    );
  });
}
