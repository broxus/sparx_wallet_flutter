import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/transport_strategies/common_transport_strategy.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nekoton_repository/nekoton_repository.dart'
    show GqlTransport, TransportStrategy;
import 'package:nekoton_webview/nekoton_webview.dart';

void openBrowserUrl(String url) {
  inject<BrowserService>().openUrl(WebUri(url));
}

extension TransportExtension on TransportStrategy {
  ConnectionData? get connection => switch (this) {
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

    final connectionObject = switch (data) {
      ConnectionDataGql(:final endpoints, :final isLocal) =>
        (transport as GqlTransport).gqlConnection.settings.let(
              (settings) => GqlConnection(
                'graphql',
                GqlSocketParams(
                  endpoints,
                  settings.latencyDetectionInterval,
                  settings.maxLatency,
                  isLocal,
                ),
              ),
            ),
      ConnectionDataProto(:final endpoint) => ProtoConnection(
          'proto',
          JrpcSocketParams(endpoint),
        ),
      ConnectionDataJrpc(:final endpoint) => JrpcConnection(
          'jrpc',
          JrpcSocketParams(endpoint),
        ),
    };

    return Network(
      data.name,
      NetworkDescription(
        config.globalId,
        '0x$capabilities',
        signatureId,
      ),
      connectionObject,
      NetworkConfig(
        data.nativeTokenTicker,
        data.nativeTokenDecimals,
        data.blockExplorerUrl,
        data.manifestUrl,
      ),
    );
  }
}

extension AddNetworkExtension on AddNetwork {
  ConnectionData getConnection() {
    final connection = this.connection as Map<String, dynamic>;

    switch (connection['type']) {
      case 'graphql':
        final params = GqlSocketParams.fromJson(
          connection['data'] as Map<String, dynamic>,
        );
        return ConnectionData.gqlCustom(
          name: name,
          group: 'custom-$name',
          networkType: NetworkType.custom,
          manifestUrl: config?.tokensManifestUrl ?? '',
          blockExplorerUrl: config?.explorerBaseUrl ?? '',
          nativeTokenTicker: config?.symbol ?? '',
          endpoints: params.endpoints,
          isLocal: params.local,
          latencyDetectionInterval: params.latencyDetectionInterval.toInt(),
          maxLatency: params.maxLatency.toInt(),
        );

      case 'proto':
        final params = JrpcSocketParams.fromJson(
          connection['data'] as Map<String, dynamic>,
        );
        return ConnectionData.protoCustom(
          name: name,
          group: 'custom-$name',
          networkType: NetworkType.custom,
          manifestUrl: config?.tokensManifestUrl ?? '',
          blockExplorerUrl: config?.explorerBaseUrl ?? '',
          nativeTokenTicker: config?.symbol ?? '',
          endpoint: params.endpoint,
        );

      case 'jrpc':
        final params = JrpcSocketParams.fromJson(
          connection['data'] as Map<String, dynamic>,
        );
        return ConnectionData.jrpcCustom(
          name: name,
          group: 'custom-$name',
          networkType: NetworkType.custom,
          manifestUrl: config?.tokensManifestUrl ?? '',
          blockExplorerUrl: config?.explorerBaseUrl ?? '',
          nativeTokenTicker: config?.symbol ?? '',
          endpoint: params.endpoint,
        );

      default:
        throw Exception('Invalid connection type: ${connection['type']}');
    }
  }
}
