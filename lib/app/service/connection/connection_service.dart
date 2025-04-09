import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
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
    this._presetsConnectionService,
    this._dio,
  );

  static final _log = Logger('ConnectionService');

  final ConnectionsStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final PresetsConnectionService _presetsConnectionService;
  final Dio _dio;

  /// Set up selected connection.
  Future<void> setUp() async {
    final connection = _storageService.currentConnection;

    _log.info('setUp: starting with ${connection.name}');
    await _updateTransportByConnection(connection);

    // skip 1 due to duplicate events
    _storageService.currentConnectionStream.skip(1).listen((connection) async {
      _log.info('setUp: switching to ${connection.name}');

      await _updateTransportByConnection(connection);
    });
  }

  /// Create TransportStrategy based on [ConnectionData.group] of
  /// [connection] data.
  AppTransportStrategy createStrategyByConnection(
    Transport transport,
    ConnectionData connection,
  ) {
    final data = _presetsConnectionService.transports[connection.group] ??
        ConnectionTransportData.custom(
          networkType: connection.networkType,
          networkName: connection.name,
        );

    return CommonTransportStrategy.fromData(
      transport,
      connection,
      data,
    );
  }

  Future<Transport> createTransportByConnection(ConnectionData connection) =>
      switch (connection) {
        final ConnectionDataGql data => _nekotonRepository.createGqlTransport(
            client: GqlHttpClient(_dio),
            name: data.name,
            group: data.group,
            endpoints: data.endpoints,
            local: data.isLocal,
            latencyDetectionInterval: data.latencyDetectionInterval,
            maxLatency: data.maxLatency,
            endpointSelectionRetryCount: data.endpointSelectionRetryCount,
          ),
        ConnectionDataProto(:final name, :final group, :final endpoint) =>
          _nekotonRepository.createProtoTransport(
            client: ProtoHttpClient(_dio),
            name: name,
            group: group,
            endpoint: endpoint,
          ),
        ConnectionDataJrpc(:final name, :final group, :final endpoint) =>
          _nekotonRepository.createJrpcTransport(
            client: JrpcHttpClient(_dio),
            name: name,
            group: group,
            endpoint: endpoint,
          ),
      };

  /// Create nekoton's transport by connection, create transport's strategy
  /// by its type and put it in nekoton.
  // ignore: long-method
  Future<void> _updateTransportByConnection(ConnectionData connection) async {
    _log.finest('updateTransportByConnection: ${connection.name}');
    try {
      final transport = await createTransportByConnection(connection);
      final strategy = createStrategyByConnection(transport, connection);

      await _nekotonRepository.updateTransport(strategy);
      _storageService.updateNetworksIds(
        [(connection.id, transport.networkId)],
      );

      _log.finest('updateTransportByConnection completed!');
    } catch (e, t) {
      inject<MessengerService>().showConnectionError(null);
      _log.severe('updateTransportByConnection', e, t);

      final base = _storageService.baseConnection;

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

    return '';
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

  bool get isEverscale => networkType == 'ever';
  bool get isTon => networkGroup.startsWith('ton');
  bool get isHmstr => networkGroup.startsWith('hmstr');
}
