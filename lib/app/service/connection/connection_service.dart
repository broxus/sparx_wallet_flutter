import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/transport_strategies/app_transport_strategy.dart';
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
    this._presetsConnectionService,
    this._messengerService,
    this._dio,
  );

  static final _log = Logger('ConnectionService');

  final ConnectionsStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final PresetsConnectionService _presetsConnectionService;
  final MessengerService _messengerService;
  final Dio _dio;

  /// Set up selected connection.
  Future<void> setUp() async {
    final network = _storageService.currentNetwork;

    _log.info('setUp: starting with ${network.networkName}');
    await _updateTransportByNetwork(network);

    // skip 1 due to duplicate events
    _storageService.currentConnectionStream.skip(1).listen((network) async {
      _log.info('setUp: switching to ${network.networkName}');

      await _updateTransportByNetwork(network);
    });
  }

  /// Create TransportStrategy based on [ConnectionData.group] of
  /// [network] data.
  AppTransportStrategy createStrategyByConnection(
    Transport transport,
    ConnectionNetwork network,
  ) {
    final data = _presetsConnectionService.transports[network.group] ??
        ConnectionTransportData.custom(
          networkType: connection.networkType,
          networkName: connection.name,
        );

    return CommonTransportStrategy.fromData(
      dio: _dio,
      transport: transport,
      connection: connection,
      transportData: data,
    );
  }

  Future<Transport> createTransportByNetwork(ConnectionNetwork network) =>
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
  Future<void> _updateTransportByNetwork(ConnectionNetwork network) async {
    _log.finest('updateTransportByConnection: ${network.networkName}');
    try {
      //
      final transport = await createTransportByNetwork(network);
      final strategy = createStrategyByConnection(transport, network);

      await _nekotonRepository.updateTransport(strategy);
      _storageService.updateNetworksIds(
        [(network.id, transport.networkId)],
      );

      _log.finest('updateTransportByConnection completed!');
    } catch (e, t) {
      _messengerService.showConnectionError(null);
      _log.severe('updateTransportByConnection', e, t);

      final base = _storageService.baseConnection;

      if (base != null && base.id != connection.id) {
        _storageService.saveCurrentConnectionData(base.id);
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
