import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/native_token_ticker/native_token_ticker.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/app/service/connection/data/work_chain/workchain_transport_type.dart';
import 'package:app/app/service/connection/transport_strategies/common_transport_strategy.dart';
import 'package:app/utils/utils.dart';
import 'package:nekoton_repository/nekoton_repository.dart'
    show GqlTransport, TransportStrategy;
import 'package:nekoton_webview/nekoton_webview.dart';
import 'package:uuid/uuid.dart';

extension TransportExtension on TransportStrategy {
  Connection? get connection => switch (this) {
        CommonTransportStrategy(:final connection) => connection,
        _ => null,
      };

  Future<Network> toNetwork() async {
    final data = connection;
    final config = await transport.getBlockchainConfig();
    final signatureId = await transport.getSignatureId();
    final capabilities = config.capabilities.toRadixString(16);

    if (data == null) {
      throw UnsupportedError('Unsupported type: $runtimeType');
    }

    final workchain = data.defaultWorkchain;

    final connectionObject = switch (workchain.transportType) {
      WorkchainTransportType.gql =>
        (transport as GqlTransport).gqlConnection.settings.let(
              (settings) => GqlConnection(
                'graphql',
                GqlSocketParams(
                  workchain.endpoints,
                  settings.latencyDetectionInterval,
                  settings.maxLatency,
                  workchain.isLocal,
                ),
              ),
            ),
      WorkchainTransportType.proto => ProtoConnection(
          'proto',
          JrpcSocketParams(workchain.endpoints.first),
        ),
      WorkchainTransportType.jrpc => JrpcConnection(
          'jrpc',
          JrpcSocketParams(workchain.endpoints.first),
        ),
    };

    return Network(
      data.networkName,
      NetworkDescription(
        config.globalId,
        '0x$capabilities',
        signatureId,
      ),
      connectionObject,
      NetworkConfig(
        workchain.nativeTokenTicker.name,
        workchain.nativeTokenDecimals,
        workchain.blockExplorerUrl,
        workchain.manifestUrl,
      ),
    );
  }
}

extension AddNetworkExtension on AddNetwork {
  Connection getConnection() {
    final connectionId = const Uuid().v4();

    final connection = this.connection as Map<String, dynamic>;

    late List<String> endpoints;
    bool? isLocal;
    int? latencyDetectionInterval;
    int? maxLatency;

    switch (connection['type']) {
      case 'graphql':
        final params = GqlSocketParams.fromJson(
          connection['data'] as Map<String, dynamic>,
        );

        endpoints = params.endpoints;
        isLocal = params.local;
        latencyDetectionInterval = params.latencyDetectionInterval.toInt();
        maxLatency = params.maxLatency.toInt();

      case 'proto':
        final params = JrpcSocketParams.fromJson(
          connection['data'] as Map<String, dynamic>,
        );
        endpoints = [params.endpoint];

      case 'jrpc':
        final params = JrpcSocketParams.fromJson(
          connection['data'] as Map<String, dynamic>,
        );

        endpoints = [params.endpoint];
      default:
        throw Exception('Invalid connection type: ${connection['type']}');
    }

    return Connection(
      id: connectionId,
      networkName: name,
      defaultWorkchainId: 0,
      isUsedOnStart: false,
      workchains: [
        ConnectionWorkchain.custom(
          id: 0,
          parentConnectionId: connectionId,
          networkType: NetworkType.custom,
          networkGroup: 'custom-$name',
          networkName: name,
          endpoints: endpoints,
          blockExplorerUrl: config?.explorerBaseUrl ?? '',
          isLocal: isLocal ?? true,
          manifestUrl: config?.tokensManifestUrl ?? '',
          defaultNativeCurrencyDecimal: 9,
          nativeTokenTicker: NativeTokenTicker(name: config?.symbol ?? ''),
          latencyDetectionInterval: latencyDetectionInterval,
          maxLatency: maxLatency,
        ),
      ],
      isPreset: false,
      canBeEdited: true,
      sortingOrder: 1,
    );
  }
}
