import 'package:app/app/service/service.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_ids_data.dart';
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

  var _initialized = false;
  var _failedConnections = <String>{};
  ConnectionWorkchain? _prevWorkchain;

  /// Set up selected connection.
  Future<void> setUp() async {
    final workchain = _storageService.currentWorkchain;

    _log.info('setUp: starting with ${workchain.networkName}');

    await _updateTransportByWorkchain(workchain);

    // skip 1 due to duplicate events
    _storageService.currentWorkchainStream.skip(1).listen((workchain) async {
      _log.info('setUp: switching to ${workchain.networkName}');

      await _updateTransportByWorkchain(workchain);
    });

    _initialized = true;
  }

  /// Create TransportStrategy based on ConnectionNetwork networkGroup
  /// of [workchain] data.
  AppTransportStrategy createStrategyByWorkchain(
    Transport transport,
    ConnectionWorkchain workchain,
  ) {
    return CommonTransportStrategy.fromData(
      dio: _dio,
      transport: transport,
      workchain: workchain,
    );
  }

  Future<Transport> createTransportByWorkchain(ConnectionWorkchain workchain) {
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

  Future<int?> getNetworkId(ConnectionWorkchain workchain) async {
    Transport? transport;

    try {
      transport = await createTransportByWorkchain(workchain);
      return transport.networkId;
    } catch (e) {
      _log.severe(
        'Error getting network id for connection: '
        '${workchain.networkName} '
        '(${workchain.parentConnectionId} '
        '${workchain.id})',
      );
    } finally {
      await transport?.dispose();
    }

    return null;
  }

  /// Create nekoton's transport by connection, create transport's strategy
  /// by its type and put it in nekoton.
  // ignore: long-method
  Future<void> _updateTransportByWorkchain(
    ConnectionWorkchain workchain,
  ) async {
    _log.finest('updateTransportByConnection: ${workchain.networkName}');
    try {
      final transport = await createTransportByWorkchain(workchain);
      final strategy = createStrategyByWorkchain(transport, workchain);

      await _nekotonRepository.updateTransport(strategy);

      _storageService.updateConnectionsIds([
        ConnectionIdsData(
          connectionId: workchain.parentConnectionId,
          workchainId: workchain.id,
          networkId: transport.networkId,
        ),
      ]);
      _prevWorkchain = workchain;
      _failedConnections = {};

      _log.finest('updateTransportByConnection completed!');
    } catch (e, t) {
      _log.severe('updateTransportByConnection', e, t);

      // Skip reverting if app was not initialized yet. Let user to choose
      // another network manually.
      if (_initialized) {
        _messengerService.showConnectionError();
        _failedConnections.add(workchain.fullId);

        // try to revert to previous connection
        if (_prevWorkchain != null &&
            !_failedConnections.contains(_prevWorkchain!.fullId)) {
          _storageService.saveCurrentConnectionId(
            connectionId: _prevWorkchain!.parentConnectionId,
            workchainId: _prevWorkchain!.id,
          );
          return;
        }

        // try to revert to base connection if previous is not available
        final base = _storageService.baseConnection;

        if (base != null && base.id != workchain.parentConnectionId) {
          _storageService.saveCurrentConnectionId(connectionId: base.id);
          return;
        }
      }

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
      return (this as CommonTransportStrategy).workchain.parentConnectionId;
    }

    return '';
  }

  NftInformation? get nftInformation {
    if (this is CommonTransportStrategy) {
      return (this as CommonTransportStrategy).nftInformation;
    }

    return null;
  }

  int get workchainId {
    if (this is CommonTransportStrategy) {
      return (this as CommonTransportStrategy).workchain.id;
    }

    return 0;
  }

  bool get isEverscale => networkType.isEver;

  bool get isVenom => networkType.isVenom;

  bool get isTon => networkType.isTon;

  bool get isHmstr => networkGroup.startsWith('hmstr');
}
