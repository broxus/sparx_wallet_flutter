import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/nft_information/nft_information.dart';
import 'package:app/app/service/connection/data/work_chain/workchain_transport_type.dart';
import 'package:app/app/service/connection/group.dart';
import 'package:app/app/service/connection/transport_strategies/app_transport_strategy.dart';
import 'package:app/app/service/connection/transport_strategies/common_transport_strategy.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// This is a service that switches between connections by creating
/// [Transport] and putting it in [NekotonRepository]. It has no public
/// methods, it uses [ConnectionsStorageService] as a source of connection
/// data.
/// The app should use [ConnectionsStorageService] to interact with
/// connection-related data.
@singleton
class ConnectionService {
  ConnectionService(
    this._storageService,
    this._nekotonRepository,
    this._messengerService,
    this._dio,
  );

  static final _log = Logger('ConnectionService');

  final ConnectionsStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final Dio _dio;

  /// Set up selected connection.
  Future<void> setUp() async {
    final connection = _storageService.currentConnection;

    _log.info('setUp: starting with ${connection.networkName}');

    await _updateTransportByConnection(connection);

    // skip 1 due to duplicate events
    _storageService.currentConnectionStream.skip(1).listen((connection) async {
      _log.info('setUp: switching to ${connection.networkName}');

      await _updateTransportByConnection(connection);
    });
  }

  /// Create TransportStrategy based on ConnectionNetwork networkGroup
  /// of [connection] data.
  AppTransportStrategy createStrategyByConnection(
    Transport transport,
    Connection connection,
  ) {
    return CommonTransportStrategy.fromData(
      dio: _dio,
      transport: transport,
      connection: connection,
    );
  }

  Future<Transport> createTransportByConnection(
    Connection connection,
  ) {
    final workchain = connection.defaultWorkchain;

    return switch (workchain.transportType) {
      WorkchainTransportType.gql => _nekotonRepository.createGqlTransport(
          client: GqlHttpClient(_dio),
          name: workchain.networkName,
          group: workchain.networkGroup,
          endpoints: workchain.endpoints,
          local: workchain.isLocal,
          latencyDetectionInterval: workchain.latencyDetectionInterval,
          maxLatency: workchain.maxLatency,
          endpointSelectionRetryCount: workchain.endpointSelectionRetryCount,
        ),
      WorkchainTransportType.proto => _nekotonRepository.createProtoTransport(
          client: ProtoHttpClient(_dio),
          name: workchain.networkName,
          group: workchain.networkGroup,
          endpoint: workchain.endpoints.first,
        ),
      WorkchainTransportType.jrpc => _nekotonRepository.createJrpcTransport(
          client: JrpcHttpClient(_dio),
          name: workchain.networkName,
          group: workchain.networkGroup,
          endpoint: workchain.endpoints.first,
        ),
    };
  }

  /// Create nekoton's transport by connection, create transport's strategy
  /// by its type and put it in nekoton.
  // ignore: long-method
  Future<void> _updateTransportByConnection(
    Connection connection,
  ) async {
    _log.finest('updateTransportByConnection: ${connection.networkName}');
    try {
      //
      final transport = await createTransportByConnection(connection);
      final strategy = createStrategyByConnection(transport, connection);

      await _nekotonRepository.updateTransport(strategy);

      _storageService.updateConnectionsIds(
        [(connection.id, connection.defaultWorkchainId, transport.networkId)],
      );

      _log.finest('updateTransportByConnection completed!');
    } catch (e, t) {
      _messengerService.showConnectionError(null);
      _log.severe('updateTransportByConnection', e, t);

      final base = _storageService.baseNetwork;

      if (base != null && base.id != connection.id) {
        _storageService.saveCurrentConnectionId(base.id);
        return;
      }

      /// Тут. Вернуть на 1 сеть
      // allow level above to track fail
      rethrow;
    }
  }
}

extension TransportTypeExtension on TransportStrategy {
  NetworkType get networkType {
    if (this is CommonTransportStrategy) {
      return (this as CommonTransportStrategy).networkType;
    }

    return NetworkType.empty();
  }

  NetworkGroup get networkGroup {
    if (this is CommonTransportStrategy) {
      return (this as CommonTransportStrategy).networkGroup;
    }

    return '';
  }

  String get connectionId {
    if (this is CommonTransportStrategy) {
      return (this as CommonTransportStrategy).connection.id;
    }

    return '';
  }

  NftInformation? get nftInformation {
    if (this is CommonTransportStrategy) {
      return (this as CommonTransportStrategy).nftInformation;
    }

    return null;
  }

  bool get isEverscale => networkType.isEver;

  bool get isVenom => networkType.isVenom;

  bool get isTon => networkType.isTon;

  bool get isHmstr => networkGroup.startsWith('hmstr');
}
