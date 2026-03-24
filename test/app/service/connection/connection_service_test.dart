import 'dart:async';

import 'package:app/app/service/connection/connection_service.dart';
import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/app/service/connection/data/work_chain/workchain_transport_type.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_ids_data.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/feature/messenger/domain/messenger_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class _MockStorage extends Mock implements ConnectionsStorageService {}

class _MockRepo extends Mock implements NekotonRepository {}

class _MockMessenger extends Mock implements MessengerService {}

class _MockProtoTransport extends Mock implements ProtoTransport {}

class _FakeTransportStrategy extends Fake implements TransportStrategy {}

class _FakeGqlClient extends Fake implements GqlConnectionHttpClient {}

class _FakeProtoClient extends Fake implements ProtoConnectionHttpClient {}

class _FakeJrpcClient extends Fake implements JrpcConnectionHttpClient {}

ConnectionWorkchain _wc({
  required int id,
  required String parentId,
  required String name,
  required WorkchainTransportType type,
  String group = 'grp-1',
  List<String> endpoints = const ['https://endpoint-1', 'https://endpoint-2'],
}) {
  return ConnectionWorkchain.custom(
    id: id,
    parentConnectionId: parentId,
    networkType: NetworkType.empty(),
    networkName: name,
    endpoints: endpoints,
    blockExplorerUrl: 'https://explorer.example',
    manifestUrl: 'https://manifest.example',
    networkGroup: group,
  ).copyWith(transportType: type);
}

Connection _connection({
  required String id,
  required String networkName,
  required ConnectionWorkchain defaultWorkchain,
  List<ConnectionWorkchain>? workchains,
  bool isPreset = true,
  bool canBeEdited = false,
}) {
  final list = workchains ?? [defaultWorkchain];
  return Connection(
    id: id,
    networkName: networkName,
    defaultWorkchainId: defaultWorkchain.id,
    workchains: list,
    isPreset: isPreset,
    canBeEdited: canBeEdited,
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeTransportStrategy());
    registerFallbackValue(_FakeGqlClient());
    registerFallbackValue(_FakeProtoClient());
    registerFallbackValue(_FakeJrpcClient());
  });

  test(
    'setUp: initial success -> updateTransport + updateConnectionsIds',
    () async {
      final storage = _MockStorage();
      final repo = _MockRepo();
      final messenger = _MockMessenger();
      final dio = Dio();

      final wc1 = _wc(
        id: 1,
        parentId: 'connA',
        name: 'A',
        type: WorkchainTransportType.proto,
        // ignore: avoid_redundant_argument_values
        group: 'grp-1',
        endpoints: const ['https://proto-1'],
      );

      final controller = StreamController<ConnectionWorkchain>.broadcast();

      when(() => storage.currentWorkchain).thenReturn(wc1);
      when(
        () => storage.currentWorkchainStream,
      ).thenAnswer((_) => controller.stream);
      when(() => storage.updateConnectionsIds(any())).thenReturn(null);

      when(() => repo.updateTransport(any())).thenAnswer((_) async {});

      final transport = _MockProtoTransport();
      when(() => transport.networkId).thenReturn(7);
      when(() => transport.group).thenReturn('grp-1');

      when(
        () => repo.createProtoTransport(
          client: any(named: 'client'),
          name: any(named: 'name'),
          group: any(named: 'group'),
          endpoint: any(named: 'endpoint'),
        ),
      ).thenAnswer((_) async => transport);

      final service = ConnectionService(storage, repo, messenger, dio);

      await service.setUp();

      verify(() => repo.updateTransport(any())).called(1);

      final captured =
          verify(
                () => storage.updateConnectionsIds(captureAny()),
              ).captured.single
              as List<ConnectionIdsData>;

      expect(captured, hasLength(1));
      expect(captured.single.connectionId, 'connA');
      expect(captured.single.workchainId, 1);
      expect(captured.single.networkId, 7);

      await controller.close();
    },
  );

  test('setUp: after initialized, switch failure -> '
      'showConnectionError+ revert to previous', () async {
    final storage = _MockStorage();
    final repo = _MockRepo();
    final messenger = _MockMessenger();
    final dio = Dio();

    final wc1 = _wc(
      id: 1,
      parentId: 'connA',
      name: 'A',
      type: WorkchainTransportType.proto,
      // ignore: avoid_redundant_argument_values
      group: 'grp-1',
      endpoints: const ['https://proto-1'],
    );

    final wc2 = _wc(
      id: 2,
      parentId: 'connB',
      name: 'B',
      type: WorkchainTransportType.gql,
      group: 'grp-2',
      endpoints: const ['https://gql-1'],
    );

    final controller = StreamController<ConnectionWorkchain>.broadcast(
      sync: true,
    );

    when(() => storage.currentWorkchain).thenReturn(wc1);
    when(
      () => storage.currentWorkchainStream,
    ).thenAnswer((_) => controller.stream);
    when(() => storage.updateConnectionsIds(any())).thenReturn(null);

    when(messenger.showConnectionError).thenReturn(null);

    when(() => repo.updateTransport(any())).thenAnswer((_) async {});

    // initial success for wc1
    final transportOk = _MockProtoTransport();
    when(() => transportOk.networkId).thenReturn(1);
    when(() => transportOk.group).thenReturn('grp-1');

    when(
      () => repo.createProtoTransport(
        client: any(named: 'client'),
        name: any(named: 'name'),
        group: any(named: 'group'),
        endpoint: any(named: 'endpoint'),
      ),
    ).thenAnswer((_) async => transportOk);

    when(
      () => repo.createGqlTransport(
        client: any(named: 'client'),
        name: any(named: 'name'),
        group: any(named: 'group'),
        endpoints: any(named: 'endpoints'),
        local: any(named: 'local'),
        latencyDetectionInterval: any(named: 'latencyDetectionInterval'),
        maxLatency: any(named: 'maxLatency'),
        endpointSelectionRetryCount: any(named: 'endpointSelectionRetryCount'),
      ),
    ).thenThrow(Exception('cannot create transport'));

    when(
      () => storage.saveCurrentConnectionId(
        connectionId: any(named: 'connectionId'),
      ),
    ).thenReturn(null);
    when(
      () => storage.saveCurrentConnectionId(
        connectionId: any(named: 'connectionId'),
        workchainId: any(named: 'workchainId'),
      ),
    ).thenReturn(null);

    final service = ConnectionService(storage, repo, messenger, dio);

    await service.setUp();

    controller
      ..add(wc1)
      ..add(wc2);

    verify(messenger.showConnectionError).called(1);

    verify(
      () => storage.saveCurrentConnectionId(
        connectionId: 'connA',
        workchainId: 1,
      ),
    ).called(1);

    await controller.close();
  });

  test(
    // ignore: lines_longer_than_80_chars
    'setUp: if previous already failed, switch failure reverts to baseConnection',
    () async {
      final storage = _MockStorage();
      final repo = _MockRepo();
      final messenger = _MockMessenger();
      final dio = Dio();

      final wc1 = _wc(
        id: 1,
        parentId: 'connA',
        name: 'A',
        type: WorkchainTransportType.proto,
        // ignore: avoid_redundant_argument_values
        group: 'grp-1',
        endpoints: const ['https://proto-1'],
      );

      final wc2 = _wc(
        id: 2,
        parentId: 'connB',
        name: 'B',
        type: WorkchainTransportType.gql,
        group: 'grp-2',
        endpoints: const ['https://gql-1'],
      );

      final baseWc = _wc(
        id: 99,
        parentId: 'baseConn',
        name: 'BaseWc',
        type: WorkchainTransportType.proto,
        group: 'grp-base',
        endpoints: const ['https://proto-base'],
      );

      final baseConnection = _connection(
        id: 'baseConn',
        networkName: 'Base',
        defaultWorkchain: baseWc,
        workchains: [baseWc],
      );

      final controller = StreamController<ConnectionWorkchain>.broadcast(
        sync: true,
      );

      when(() => storage.currentWorkchain).thenReturn(wc1);
      when(
        () => storage.currentWorkchainStream,
      ).thenAnswer((_) => controller.stream);
      when(() => storage.updateConnectionsIds(any())).thenReturn(null);
      when(() => storage.baseConnection).thenReturn(baseConnection);

      when(messenger.showConnectionError).thenReturn(null);
      when(() => repo.updateTransport(any())).thenAnswer((_) async {});

      // initial success for wc1
      final transportOk = _MockProtoTransport();
      when(() => transportOk.networkId).thenReturn(1);
      when(() => transportOk.group).thenReturn('grp-1');

      when(
        () => repo.createProtoTransport(
          client: any(named: 'client'),
          name: any(named: 'name'),
          group: any(named: 'group'),
          endpoint: any(named: 'endpoint'),
        ),
      ).thenAnswer((_) async => transportOk);

      // wc2 fails
      when(
        () => repo.createGqlTransport(
          client: any(named: 'client'),
          name: any(named: 'name'),
          group: any(named: 'group'),
          endpoints: any(named: 'endpoints'),
          local: any(named: 'local'),
          latencyDetectionInterval: any(named: 'latencyDetectionInterval'),
          maxLatency: any(named: 'maxLatency'),
          endpointSelectionRetryCount: any(
            named: 'endpointSelectionRetryCount',
          ),
        ),
      ).thenThrow(Exception('gql broken'));

      // IMPORTANT: stub both call forms
      when(
        () => storage.saveCurrentConnectionId(
          connectionId: any(named: 'connectionId'),
        ),
      ).thenReturn(null);
      when(
        () => storage.saveCurrentConnectionId(
          connectionId: any(named: 'connectionId'),
          workchainId: any(named: 'workchainId'),
        ),
      ).thenReturn(null);

      final service = ConnectionService(storage, repo, messenger, dio);

      await service.setUp();

      controller
        ..add(wc1)
        ..add(wc2);

      verify(
        () => storage.saveCurrentConnectionId(
          connectionId: 'connA',
          workchainId: 1,
        ),
      ).called(1);

      when(
        () => repo.createProtoTransport(
          client: any(named: 'client'),
          name: any(named: 'name'),
          group: any(named: 'group'),
          endpoint: any(named: 'endpoint'),
        ),
      ).thenThrow(Exception('proto broken'));

      controller.add(wc1);

      verify(
        () => storage.saveCurrentConnectionId(connectionId: 'baseConn'),
      ).called(1);

      await controller.close();
    },
  );

  test('getNetworkId: returns transport.networkId and disposes it', () async {
    final storage = _MockStorage();
    final repo = _MockRepo();
    final messenger = _MockMessenger();
    final dio = Dio();

    final wc = _wc(
      id: 1,
      parentId: 'connA',
      name: 'A',
      type: WorkchainTransportType.proto,
      endpoints: const ['https://proto-1'],
    );

    final transport = _MockProtoTransport();
    when(() => transport.networkId).thenReturn(42);
    when(transport.dispose).thenAnswer((_) async {});

    when(
      () => repo.createProtoTransport(
        client: any(named: 'client'),
        name: any(named: 'name'),
        group: any(named: 'group'),
        endpoint: any(named: 'endpoint'),
      ),
    ).thenAnswer((_) async => transport);

    final service = ConnectionService(storage, repo, messenger, dio);

    final id = await service.getNetworkId(wc);
    expect(id, 42);

    verify(transport.dispose).called(1);
  });

  test(
    'getNetworkId: returns null on error and still disposes if created',
    () async {
      final storage = _MockStorage();
      final repo = _MockRepo();
      final messenger = _MockMessenger();
      final dio = Dio();

      final wc = _wc(
        id: 1,
        parentId: 'connA',
        name: 'A',
        type: WorkchainTransportType.proto,
        endpoints: const ['https://proto-1'],
      );

      final transport = _MockProtoTransport();
      when(transport.dispose).thenAnswer((_) async {});
      when(() => transport.networkId).thenThrow(Exception('boom'));

      when(
        () => repo.createProtoTransport(
          client: any(named: 'client'),
          name: any(named: 'name'),
          group: any(named: 'group'),
          endpoint: any(named: 'endpoint'),
        ),
      ).thenAnswer((_) async => transport);

      final service = ConnectionService(storage, repo, messenger, dio);

      final id = await service.getNetworkId(wc);
      expect(id, isNull);

      verify(transport.dispose).called(1);
    },
  );
}
