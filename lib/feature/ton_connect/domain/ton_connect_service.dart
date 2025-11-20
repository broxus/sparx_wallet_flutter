import 'dart:async';
import 'dart:io';

import 'package:app/app/service/app_version_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@lazySingleton
class TonConnectService {
  TonConnectService(
    this._storageService,
    this._nekotonRepository,
    this._appVersionService,
    this._connectionsStorageService,
    this._connectionService,
    this._validator,
    this._dio,
  );

  static final _logger = Logger('TonConnectService');

  final TonConnectStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final AppVersionService _appVersionService;
  final ConnectionsStorageService _connectionsStorageService;
  final ConnectionService _connectionService;
  final TonConnectRequestValidator _validator;
  final Dio _dio;

  final _uiEvents = BehaviorSubject<TonConnectUiEvent>();

  Stream<TonConnectUiEvent> get uiEventsStream => _uiEvents.stream;

  String get _platform => switch (Platform.operatingSystem) {
    'ios' => 'iphone',
    'android' => 'android',
    _ => Platform.operatingSystem,
  };

  Future<ConnectResult> connect({required ConnectRequest request}) async {
    final manifestJson = await _getManifestJson(request.manifestUrl);
    if (manifestJson == null) {
      _uiEvents.add(
        TonConnectUiEvent.error(message: LocaleKeys.dappManifestError.tr()),
      );
      return ConnectResult.error(
        error: TonConnectError(
          code: TonConnectErrorCode.appManifestNotFound,
          message: 'App manifest not found',
        ),
      );
    }

    final manifest = await _parseManifestJson(manifestJson);
    if (manifest == null) {
      _uiEvents.add(
        TonConnectUiEvent.error(message: LocaleKeys.dappManifestError.tr()),
      );
      return ConnectResult.error(
        error: TonConnectError(
          code: TonConnectErrorCode.appManifestContentError,
          message: 'App manifest content error',
        ),
      );
    }

    final networkError = await _validateNetwork(manifest: manifest);
    if (networkError != null) {
      return ConnectResult.error(error: networkError);
    }

    final completer =
        Completer<
          TonConnectUiEventResult<(KeyAccount, List<ConnectItemReply>)>
        >();
    _uiEvents.add(
      TonConnectUiEvent.connect(
        request: request,
        manifest: manifest,
        completer: completer,
      ),
    );

    final result = await completer.future;

    return switch (result) {
      TonConnectUiEventResultData<(KeyAccount, List<ConnectItemReply>)>(
        :final data,
      ) =>
        ConnectResult.success(
          account: data.$1,
          replyItems: data.$2,
          manifest: manifest,
        ),
      TonConnectUiEventResultError(:final error) => ConnectResult.error(
        error: TonConnectError(code: error.code, message: error.message),
      ),
      TonConnectUiEventResultCanceled() => ConnectResult.error(
        error: TonConnectError(
          code: TonConnectErrorCode.userDeclined,
          message: 'User declined the connection',
        ),
      ),
    };
  }

  void disconnect({required TonAppConnection connection}) =>
      _storageService.removeConnection(connection);

  void disconnectAllInBrowser() {
    _storageService
        .readConnections()
        .whereType<TonAppConnectionInjected>()
        .forEach((connection) => disconnect(connection: connection));
  }

  Future<SendTransactionResponse> sendTransaction({
    required TonAppConnection connection,
    required Map<String, dynamic> payloadJson,
    required String requestId,
  }) async {
    final payload = _tryParseTransactionPayload(payloadJson);
    if (payload == null) {
      return SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: TonConnectErrorCode.badRequest,
          message: 'Invalid payload format',
        ),
      );
    }

    final networkError = await _validateNetwork(
      manifest: connection.manifest,
      network: payload.network,
    );
    if (networkError != null) {
      return SendTransactionResponse.error(id: requestId, error: networkError);
    }

    final error = await _validator.validateSendTransactionRequest(
      connection: connection,
      payload: payload,
    );
    if (error != null) {
      return SendTransactionResponse.error(id: requestId, error: error);
    }

    final completer = Completer<TonConnectUiEventResult<SignedMessage>>();
    _uiEvents.add(
      TonConnectUiEvent.sendTransaction(
        connection: connection,
        payload: payload,
        completer: completer,
      ),
    );

    final message = await completer.future;

    return switch (message) {
      TonConnectUiEventResultData<SignedMessage>(:final data) =>
        SendTransactionResponse.success(id: requestId, result: data.boc),
      TonConnectUiEventResultError(:final error) =>
        SendTransactionResponse.error(
          id: requestId,
          error: TonConnectError(code: error.code, message: error.message),
        ),
      TonConnectUiEventResultCanceled() => SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: TonConnectErrorCode.userDeclined,
          message: 'User declined the transaction',
        ),
      ),
    };
  }

  Future<SignDataResponse> signData({
    required TonAppConnection connection,
    required Map<String, dynamic> payloadJson,
    required String requestId,
  }) async {
    final networkError = await _validateNetwork(manifest: connection.manifest);
    if (networkError != null) {
      return SignDataResponse.error(id: requestId, error: networkError);
    }

    final payload = _tryParseSignDataPayload(payloadJson);
    if (payload == null) {
      return SignDataResponse.error(
        id: requestId,
        error: TonConnectError(
          code: TonConnectErrorCode.badRequest,
          message: 'Invalid payload format',
        ),
      );
    }

    final error = await _validator.validateSignDataRequest(
      connection: connection,
      payload: payload,
    );
    if (error != null) {
      return SignDataResponse.error(id: requestId, error: error);
    }

    final completer = Completer<TonConnectUiEventResult<SignDataResult>>();
    _uiEvents.add(
      TonConnectUiEvent.signData(
        connection: connection,
        payload: payload,
        completer: completer,
      ),
    );

    final result = await completer.future;

    return switch (result) {
      TonConnectUiEventResultData<SignDataResult>(:final data) =>
        SignDataResponse.success(id: requestId, result: data),
      TonConnectUiEventResultError(:final error) => SignDataResponse.error(
        id: requestId,
        error: TonConnectError(code: error.code, message: error.message),
      ),
      TonConnectUiEventResultCanceled() => SignDataResponse.error(
        id: requestId,
        error: TonConnectError(
          code: TonConnectErrorCode.userDeclined,
          message: 'User declined the signing',
        ),
      ),
    };
  }

  Future<DeviceInfo> getDeviceInfo() async => DeviceInfo(
    platform: _platform,
    appName: 'sparx',
    appVersion: await _appVersionService.appVersion(),
    maxProtocolVersion: 2,
    features: const [
      'SendTransaction',
      Feature.sendTransaction(maxMessages: 4),
      Feature.signData(types: ['text', 'binary']), // 'text' | 'binary' | 'cell'
    ],
  );

  Future<Map<String, dynamic>?> _getManifestJson(String manifestUrl) async {
    try {
      final uri = Uri.parse(manifestUrl);
      final response = await _dio.getUri<Map<String, dynamic>>(uri);
      final data = response.data;

      if (response.statusCode == 200) {
        return data;
      }
    } catch (e, s) {
      _logger.warning('Failed to get manifest', e, s);
    }

    return null;
  }

  Future<DappManifest?> _parseManifestJson(Map<String, dynamic> json) async {
    try {
      return DappManifest.fromJson(json);
    } catch (e, s) {
      _logger.warning('Failed to parse manifest', e, s);
    }

    return null;
  }

  Future<TonConnectError?> _validateNetwork({
    required DappManifest manifest,
    TonNetwork? network,
  }) async {
    var transport = _nekotonRepository.currentTransport;

    if (!transport.networkType.isTon ||
        (network != null && network.toInt() != transport.transport.networkId)) {
      final completer = Completer<TransportStrategy?>();

      final connections = network == null
          ? _connectionsStorageService.connections.where(
              (connection) => connection.networkType.isTon,
            )
          : await _connectionsStorageService.getConnectionsByNetworkId(
              networkId: network.toInt(),
              getNetworkId: _connectionService.getNetworkId,
            );

      if (connections.isNotEmpty) {
        _uiEvents.add(
          TonConnectUiEvent.changeNetwork(
            origin: Uri.parse(manifest.url),
            networkId: network?.toInt() ?? TonNetwork.mainnet.toInt(),
            connections: connections.toList(),
            completer: completer,
          ),
        );

        transport = await completer.future ?? transport;
      }
    }

    if (!transport.networkType.isTon ||
        (network != null && network.toInt() != transport.transport.networkId)) {
      return TonConnectError(
        code: TonConnectErrorCode.badRequest,
        message: 'Wrong network',
      );
    }

    return null;
  }

  SignDataPayload? _tryParseSignDataPayload(Map<String, dynamic> json) {
    try {
      return SignDataPayload.fromJson(json);
    } catch (e, s) {
      _logger.warning('Failed to parse sign data payload', e, s);
      return null;
    }
  }

  TransactionPayload? _tryParseTransactionPayload(Map<String, dynamic> json) {
    try {
      return TransactionPayload.fromJson(json);
    } catch (e, s) {
      _logger.warning('Failed to parse transaction payload', e, s);
      return null;
    }
  }
}
