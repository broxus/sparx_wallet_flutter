import 'dart:io';

import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/storage_service/connections_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v5.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = await Directory.systemTemp.createTemp('get_storage_v5_test');
    return dir.path;
  }
}

class _MockGeneralStorageService extends Mock
    implements GeneralStorageService {}

class _MockConnectionsStorageService extends Mock
    implements ConnectionsStorageService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  PathProviderPlatform.instance = _MockPathProviderPlatform();

  late _MockGeneralStorageService generalStorageService;
  late _MockConnectionsStorageService connectionsStorageService;
  late StorageMigrationV5 migration;

  setUpAll(() {
    registerFallbackValue(
      const ConnectionData.gql(
        id: 'id',
        name: 'name',
        group: 'group',
        endpoints: [],
        networkType: NetworkType.ever,
        isLocal: false,
        blockExplorerUrl: '',
        nativeTokenTicker: '',
        isPreset: false,
        canBeEdited: true,
        sortingOrder: 0,
      ),
    );
  });

  setUp(() {
    generalStorageService = _MockGeneralStorageService();
    connectionsStorageService = _MockConnectionsStorageService();

    migration = StorageMigrationV5(
      generalStorageService,
      connectionsStorageService,
    );
  });

  group('Migrate NetworkGroup', () {
    test('Does not migrate any connections '
        'if there are no connections with group == custom', () async {
      final connEver = ConnectionData.gqlCustom(
        name: 'ever-1',
        group: 'ever',
        endpoints: const ['https://ever'],
        isLocal: false,
        blockExplorerUrl: '',
        nativeTokenTicker: 'EVE',
        networkType: NetworkType.ever,
      );

      final connVenom = ConnectionData.gqlCustom(
        name: 'venom-1',
        group: 'venom',
        endpoints: const ['https://venom'],
        isLocal: false,
        blockExplorerUrl: '',
        nativeTokenTicker: 'VEN',
        networkType: NetworkType.venom,
      );

      when(
        () => connectionsStorageService.connections,
      ).thenReturn([connEver, connVenom]);

      final customAssets = [
        {'custom': 1},
      ];
      final systemAssets = [
        {'system': 2},
      ];

      when(
        () => generalStorageService.readRawCustomAssets('custom'),
      ).thenReturn(customAssets);
      when(
        () => generalStorageService.readRawSystemAssets('custom'),
      ).thenReturn(systemAssets);

      when(
        () => generalStorageService.removeRawCustomAssets('custom'),
      ).thenAnswer((_) async {});
      when(
        () => generalStorageService.removeRawSystemAssets('custom'),
      ).thenAnswer((_) async {});

      await migration.apply();

      verify(() => connectionsStorageService.connections).called(1);

      verify(
        () => generalStorageService.readRawCustomAssets('custom'),
      ).called(1);
      verify(
        () => generalStorageService.readRawSystemAssets('custom'),
      ).called(1);

      verify(
        () => generalStorageService.removeRawCustomAssets('custom'),
      ).called(1);
      verify(
        () => generalStorageService.removeRawSystemAssets('custom'),
      ).called(1);

      verifyNever(() => connectionsStorageService.updateConnection(any()));
      verifyNever(
        () => generalStorageService.writeRawCustomAssets(any(), any()),
      );
      verifyNever(
        () => generalStorageService.writeRawSystemAssets(any(), any()),
      );

      verifyNoMoreInteractions(connectionsStorageService);
      verifyNoMoreInteractions(generalStorageService);
    });

    test('Migrates each custom connection: updates group to '
        'custom-10000/custom-10001 and copies custom/system assets '
        'to those groups', () async {
      // given
      final custom1 = ConnectionData.gqlCustom(
        name: 'custom-1',
        group: 'custom',
        endpoints: const ['https://c1'],
        isLocal: false,
        blockExplorerUrl: '',
        nativeTokenTicker: 'C1',
        networkType: NetworkType.custom,
      );

      final custom2 = ConnectionData.gqlCustom(
        name: 'custom-2',
        group: 'custom',
        endpoints: const ['https://c2'],
        isLocal: false,
        blockExplorerUrl: '',
        nativeTokenTicker: 'C2',
        networkType: NetworkType.custom,
      );

      final other = ConnectionData.gqlCustom(
        name: 'ever-1',
        group: 'ever',
        endpoints: const ['https://ever'],
        isLocal: false,
        blockExplorerUrl: '',
        nativeTokenTicker: 'EVE',
        networkType: NetworkType.ever,
      );

      when(
        () => connectionsStorageService.connections,
      ).thenReturn([custom1, custom2, other]);

      final customAssets = [
        {'custom': 1},
      ];
      final systemAssets = [
        {'system': 2},
      ];

      when(
        () => generalStorageService.readRawCustomAssets('custom'),
      ).thenReturn(customAssets);
      when(
        () => generalStorageService.readRawSystemAssets('custom'),
      ).thenReturn(systemAssets);

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
      ).thenAnswer((_) {});

      await migration.apply();

      verify(() => connectionsStorageService.connections).called(1);

      verify(
        () => generalStorageService.readRawCustomAssets('custom'),
      ).called(1);
      verify(
        () => generalStorageService.readRawSystemAssets('custom'),
      ).called(1);

      verify(
        () => generalStorageService.removeRawCustomAssets('custom'),
      ).called(1);
      verify(
        () => generalStorageService.removeRawSystemAssets('custom'),
      ).called(1);

      final captured = verify(
        () => connectionsStorageService.updateConnection(captureAny()),
      ).captured;

      expect(captured, hasLength(2));

      final updated = captured.cast<ConnectionData>();
      final byId = {for (final c in updated) c.id: c};

      expect(byId.keys.toSet(), {custom1.id, custom2.id});

      expect(byId[custom1.id]!.group, 'custom-10000');
      expect(byId[custom2.id]!.group, 'custom-10001');

      expect(byId.containsKey(other.id), isFalse);

      verify(
        () => generalStorageService.writeRawCustomAssets(
          'custom-10000',
          customAssets,
        ),
      ).called(1);
      verify(
        () => generalStorageService.writeRawCustomAssets(
          'custom-10001',
          customAssets,
        ),
      ).called(1);

      verify(
        () => generalStorageService.writeRawSystemAssets(
          'custom-10000',
          systemAssets,
        ),
      ).called(1);
      verify(
        () => generalStorageService.writeRawSystemAssets(
          'custom-10001',
          systemAssets,
        ),
      ).called(1);

      verifyNoMoreInteractions(connectionsStorageService);
      verifyNoMoreInteractions(generalStorageService);
    });
  });
}
