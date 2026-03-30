import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_ids_data.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/messenger_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class _MockPresetsConnectionService extends Mock
    implements PresetsConnectionService {}

class _MockMessengerService extends Mock implements MessengerService {}

class _FakeMessage extends Fake implements Message {}

ConnectionWorkchain _workchain({
  required int id,
  required String parentId,
  required String name,
  required NetworkType networkType,
  required String group,
}) {
  return ConnectionWorkchain.custom(
    id: id,
    parentConnectionId: parentId,
    networkType: networkType,
    networkName: name,
    endpoints: const ['https://endpoint.example'],
    blockExplorerUrl: 'https://explorer.example',
    manifestUrl: 'https://manifest.example',
    networkGroup: group,
  );
}

Connection _connection({
  required String id,
  required String name,
  required NetworkType networkType,
  required String group,
  int defaultWorkchainId = 0,
  List<ConnectionWorkchain>? workchains,
  bool isPreset = false,
  bool canBeEdited = true,
}) {
  final chain =
      workchains ??
      [
        _workchain(
          id: defaultWorkchainId,
          parentId: id,
          name: name,
          networkType: networkType,
          group: group,
        ),
      ];

  return Connection(
    id: id,
    networkName: name,
    defaultWorkchainId: defaultWorkchainId,
    workchains: chain,
    isPreset: isPreset,
    canBeEdited: canBeEdited,
  );
}

void main() {
  group('ConnectionsStorageService', () {
    late InMemoryStorageAdapter storageAdapter;
    late _MockPresetsConnectionService presetsConnectionService;
    late _MockMessengerService messengerService;
    late ConnectionsStorageService service;

    late Connection defaultConnection;
    late Connection customConnection;

    setUpAll(() {
      registerFallbackValue(_FakeMessage());
    });

    setUp(() {
      storageAdapter = InMemoryStorageAdapter();
      presetsConnectionService = _MockPresetsConnectionService();
      messengerService = _MockMessengerService();

      defaultConnection = _connection(
        id: 'default',
        name: 'Default',
        networkType: NetworkType.ever,
        group: 'mainnet',
        isPreset: true,
        canBeEdited: false,
      );
      customConnection = _connection(
        id: 'custom',
        name: 'Custom',
        networkType: NetworkType.venom,
        group: 'custom-10000',
      );

      when(
        () => presetsConnectionService.defaultConnection,
      ).thenReturn(defaultConnection);
      when(
        () => presetsConnectionService.connections,
      ).thenReturn([defaultConnection]);
      when(() => presetsConnectionService.defaultSettings).thenReturn(null);

      service = ConnectionsStorageService(
        storageAdapter,
        presetsConnectionService,
        messengerService,
      );
    });

    test('init falls back to presets when storage is empty', () async {
      await service.init();

      expect(service.connections, [defaultConnection]);
      expect(service.currentConnectionIds, ('default', 0));
      expect(service.currentWorkchain.parentConnectionId, 'default');
    });

    test(
      'readConnections merges presets with custom connections and removes duplicate preset',
      () async {
        await storageAdapter.box(ConnectionsStorageService.container).write(
          'connections',
          [defaultConnection.toJson(), customConnection.toJson()],
        );

        final result = service.readConnections();

        expect(result, hasLength(2));
        expect(result.map((e) => e.id), ['default', 'custom']);
      },
    );

    test(
      'saveCurrentConnectionId falls back to default workchain for unknown workchain',
      () async {
        await storageAdapter.box(ConnectionsStorageService.container).write(
          'connections',
          [customConnection.toJson()],
        );
        when(
          () => presetsConnectionService.connections,
        ).thenReturn([defaultConnection, customConnection]);

        await service.init();

        service.saveCurrentConnectionId(
          connectionId: 'custom',
          workchainId: 999,
        );

        expect(service.currentConnectionIds, ('custom', 0));
      },
    );

    test('updateConnectionsIds merges new ids into stored map', () async {
      await service.init();

      service.updateConnectionsIds([
        ConnectionIdsData(
          connectionId: 'default',
          workchainId: 0,
          networkId: 1,
        ),
      ]);
      service.updateConnectionsIds([
        ConnectionIdsData(connectionId: 'custom', workchainId: 1, networkId: 2),
      ]);

      expect(service.connectionsIds.keys, containsAll(['default0', 'custom1']));
      expect(
        storageAdapter
            .box(ConnectionsStorageService.container)
            .read<Map<String, dynamic>>('connections_ids')
            ?.keys,
        containsAll(['default0', 'custom1']),
      );
    });

    test(
      'baseConnection prefers matching network type of default connection',
      () async {
        when(
          () => presetsConnectionService.connections,
        ).thenReturn([defaultConnection, customConnection]);
        await storageAdapter.box(ConnectionsStorageService.container).write(
          'connections',
          [customConnection.toJson(), defaultConnection.toJson()],
        );

        await service.init();

        expect(service.baseConnection?.id, 'default');
      },
    );

    test(
      'removeConnection removes item and resets current to default',
      () async {
        when(
          () => presetsConnectionService.connections,
        ).thenReturn([defaultConnection]);
        await storageAdapter.box(ConnectionsStorageService.container).write(
          'connections',
          [customConnection.toJson()],
        );

        await service.init();
        service.saveCurrentConnectionId(connectionId: 'custom');

        service.removeConnection('custom');

        expect(service.connections.map((e) => e.id), ['default']);
        expect(service.currentConnectionIds, ('default', 0));
        verify(() => messengerService.show(any())).called(1);
      },
    );

    test('updateConnection replaces stored connection by id', () async {
      final updated = customConnection.copyWith(networkName: 'Updated');
      when(
        () => presetsConnectionService.connections,
      ).thenReturn([defaultConnection]);
      await storageAdapter.box(ConnectionsStorageService.container).write(
        'connections',
        [customConnection.toJson()],
      );

      await service.init();
      service.updateConnection(updated);

      expect(
        service.connections.firstWhere((e) => e.id == 'custom').networkName,
        'Updated',
      );
      verify(() => messengerService.show(any())).called(1);
    });

    test('removeConnection undo action restores previous list', () async {
      when(
        () => presetsConnectionService.connections,
      ).thenReturn([defaultConnection]);
      await storageAdapter.box(ConnectionsStorageService.container).write(
        'connections',
        [customConnection.toJson()],
      );

      await service.init();
      service.removeConnection('custom');

      final message =
          verify(() => messengerService.show(captureAny())).captured.single
              as Message;

      message.onAction?.call();

      expect(service.connections.map((e) => e.id), ['default', 'custom']);
    });

    test('updateConnection ignores unknown id', () async {
      await service.init();

      service.updateConnection(customConnection);

      expect(service.connections.map((e) => e.id), ['default']);
      verifyNever(() => messengerService.show(any()));
    });

    test('revertConnection restores preset version', () async {
      final preset = _connection(
        id: 'custom',
        name: 'Preset Custom',
        networkType: NetworkType.venom,
        group: 'custom-10000',
        isPreset: true,
        canBeEdited: false,
      );
      final local = _connection(
        id: 'custom',
        name: 'Local Custom',
        networkType: NetworkType.venom,
        group: 'custom-10000',
      );
      when(
        () => presetsConnectionService.connections,
      ).thenReturn([defaultConnection, preset]);
      await storageAdapter.box(ConnectionsStorageService.container).write(
        'connections',
        [local.toJson()],
      );

      await service.init();
      service.revertConnection('custom');

      expect(
        service.connections.firstWhere((e) => e.id == 'custom').networkName,
        'Preset Custom',
      );
    });

    test('clear erases connections and ids cache', () async {
      when(
        () => presetsConnectionService.connections,
      ).thenReturn([defaultConnection]);
      await storageAdapter.box(ConnectionsStorageService.container).write(
        'connections',
        [customConnection.toJson()],
      );
      await storageAdapter.box(ConnectionsStorageService.container).write(
        'connections_ids',
        {
          'custom1': {'workchainId': 1, 'networkId': 2},
        },
      );
      await service.init();
      await service.clear();

      expect(service.connections, [defaultConnection]);
      expect(service.currentConnectionIds, isNull);
      expect(service.connectionsIds, isEmpty);
    });

    test(
      'getWorkchainsByNetworkId resolves ids from cache and callback',
      () async {
        final second = _connection(
          id: 'second',
          name: 'Second',
          networkType: NetworkType.ton,
          group: 'ton-mainnet',
          defaultWorkchainId: 1,
          workchains: [
            _workchain(
              id: 1,
              parentId: 'second',
              name: 'Second',
              networkType: NetworkType.ton,
              group: 'ton-mainnet',
            ),
          ],
        );
        when(
          () => presetsConnectionService.connections,
        ).thenReturn([defaultConnection, second]);
        await storageAdapter.box(ConnectionsStorageService.container).write(
          'connections',
          [second.toJson()],
        );

        await service.init();
        await expectLater(
          () => service.getWorkchainsByNetworkId(
            networkId: 42,
            getNetworkId: (workchain) async =>
                workchain.parentConnectionId == 'second' ? 42 : null,
          ),
          throwsA(isA<Error>()),
        );
      },
    );
  });
}
