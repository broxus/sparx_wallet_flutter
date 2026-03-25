import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/feature/browser/approvals_listener/actions/add_network/add_network_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/change_network/change_network_model.dart';
import 'package:app/feature/messenger/domain/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class _MockErrorHandler extends Mock implements ErrorHandler {}

class _MockMessengerService extends Mock implements MessengerService {}

class _MockConnectionsStorageService extends Mock
    implements ConnectionsStorageService {}

class _MockNekotonRepository extends Mock implements NekotonRepository {}

class _MockConnectionService extends Mock implements ConnectionService {}

class _MockTransportStrategy extends Mock implements CommonTransportStrategy {}

void main() {
  late _MockMessengerService messengerService;
  late _MockConnectionsStorageService connectionsStorageService;
  late _MockNekotonRepository nekotonRepository;
  late _MockConnectionService connectionService;
  late _MockErrorHandler errorHandler;
  late ChangeNetworkModel changeNetworkModel;
  late AddNetworkModel addNetworkModel;
  late StreamController<TransportStrategy> transportController;

  setUp(() {
    messengerService = _MockMessengerService();
    connectionsStorageService = _MockConnectionsStorageService();
    nekotonRepository = _MockNekotonRepository();
    connectionService = _MockConnectionService();
    errorHandler = _MockErrorHandler();
    transportController = StreamController<TransportStrategy>.broadcast();

    when(
      () => nekotonRepository.currentTransportStream,
    ).thenAnswer((_) => transportController.stream);
    when(
      () => connectionsStorageService.saveCurrentConnectionId(
        connectionId: any(named: 'connectionId'),
        workchainId: any(named: 'workchainId'),
      ),
    ).thenReturn(null);

    changeNetworkModel = ChangeNetworkModel(
      errorHandler,
      messengerService,
      connectionsStorageService,
      nekotonRepository,
    );

    addNetworkModel = AddNetworkModel(
      errorHandler,
      messengerService,
      connectionsStorageService,
      connectionService,
      nekotonRepository,
    );
  });

  tearDown(() async {
    await transportController.close();
  });

  group('ChangeNetworkModel.changeConnection', () {
    test(
      'saves connection id and returns matching transport strategy',
      () async {
        final other = _mockStrategy('other');
        final target = _mockStrategy('target');

        final future = changeNetworkModel.changeConnection('target');

        transportController
          ..add(other)
          ..add(target);

        expect(await future, same(target));
        verify(
          () => connectionsStorageService.saveCurrentConnectionId(
            connectionId: 'target',
          ),
        ).called(1);
      },
    );
  });

  group('AddNetworkModel.changeNetwork', () {
    test(
      'saves connection id and waits for matching transport strategy',
      () async {
        final other = _mockStrategy('other');
        final target = _mockStrategy('target');

        final future = addNetworkModel.changeNetwork('target');

        transportController
          ..add(other)
          ..add(target);

        await future;

        verify(
          () => connectionsStorageService.saveCurrentConnectionId(
            connectionId: 'target',
          ),
        ).called(1);
      },
    );
  });
}

_MockTransportStrategy _mockStrategy(String connectionId) {
  final strategy = _MockTransportStrategy();
  final workchain = ConnectionWorkchain.custom(
    id: 0,
    parentConnectionId: connectionId,
    networkType: NetworkType.custom,
    networkName: connectionId,
    endpoints: const ['https://endpoint.test'],
    blockExplorerUrl: '',
    manifestUrl: '',
  );

  when(() => strategy.workchain).thenReturn(workchain);

  return strategy;
}
