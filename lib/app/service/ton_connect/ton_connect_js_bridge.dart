import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class TonConnectJsBridge {
  TonConnectJsBridge(
    this._tonConnectService,
    this._storageService,
  );

  static final _logger = Logger('TonConnectJsBridge');

  final TonConnectService _tonConnectService;
  final TonConnectStorageService _storageService;

  Uri? url;
  InAppWebViewController? _controller;

  Future<void> initJsBridge(InAppWebViewController controller) async {
    final deviceInfo = await _tonConnectService.getDeviceInfo();
    final source = _getJsSource(deviceInfo);

    await controller.addUserScript(
      userScript: UserScript(
        source: source,
        injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
      ),
    );

    controller.addJavaScriptHandler(
      handlerName: tonConnectJsHandlerName,
      callback: (List<dynamic> arguments) async {
        _logger.finest('Received message: $arguments');

        final method = arguments.elementAt(0) as String;
        final result = await switch (method) {
          'connect' => _connect(arguments.elementAt(1)),
          'restoreConnection' => _restoreConnection(),
          'send' => _handleMessage(arguments.elementAt(1)),
          _ => throw Exception('Unknown method: $method'),
        };

        if (result != null) return result;
      },
    );
  }

  Future<WalletEvent> _connect(dynamic message) async {
    final origin = url?.origin;
    if (origin == null) {
      return WalletEvent.connectError(
        id: _storageService.getEventId(),
        payload: TonConnectError(
          code: TonConnectErrorCode.unknownError,
          message: 'Unknown error',
        ),
      );
    }

    final payload = message as Map<String, dynamic>;
    final request = ConnectRequest.fromJson(payload);

    final result = await _tonConnectService.connect(request: request);

    if (result is ConnectResultError) {
      return WalletEvent.connectError(
        id: _storageService.getEventId(),
        payload: result.error,
      );
    }

    final r = result as ConnectResultSuccess;
    final connection = TonAppConnection.injected(
      origin: origin,
      replyItems: r.replyItems,
      walletAddress: r.account.address,
      manifest: r.manifest,
    );
    _storageService.addConnection(connection);

    _logger.info('Connected: ${connection.toJson()}');

    return WalletEvent.connectSuccess(
      id: _storageService.getEventId(),
      payload: ConnectEventSuccessPayload(
        device: await _tonConnectService.getDeviceInfo(),
        items: connection.replyItems,
      ),
    );
  }

  Future<WalletEvent?> _restoreConnection() async {
    final connection = _getConnection();
    if (connection == null) return null;

    _logger.info('Restoring connection: ${connection.toJson()}');

    return WalletEvent.connectSuccess(
      id: _storageService.getEventId(),
      payload: ConnectEventSuccessPayload(
        device: await _tonConnectService.getDeviceInfo(),
        items: connection.replyItems,
      ),
    );
  }

  Future<dynamic> _handleMessage(dynamic message) async {
    try {
      final json = message as Map<String, dynamic>;
      final rpcRequest = RpcRequest.fromJson(json);
      final connection = _getConnection();

      if (connection == null) return;

      return await switch (rpcRequest) {
        DisconnectRpcRequest() => _disconnect(connection: connection),
        final SendTransactionRpcRequest request => _sendTransaction(
            request: request,
            connection: connection,
          ),
        final SignDataRpcRequest request => _signData(
            request: request,
            connection: connection,
          ),
      };
    } catch (e, s) {
      _logger.severe('Handle message failed', e, s);
    }
  }

  Future<WalletResponse> _disconnect({
    required TonAppConnectionInjected connection,
  }) async {
    final eventId = _storageService.getEventId();

    _tonConnectService.disconnect(connection: connection);

    await _triggerEvent(WalletEvent.disconnect(id: eventId));

    return WalletResponse.success(id: eventId, result: '');
  }

  Future<SendTransactionResponse?> _sendTransaction({
    required SendTransactionRpcRequest request,
    required TonAppConnectionInjected connection,
  }) async {
    final payload = request.params.firstOrNull;
    if (payload == null) return null;

    return _tonConnectService.sendTransaction(
      requestId: request.id,
      connection: connection,
      payload: TransactionPayload.fromJson(
        jsonDecode(payload) as Map<String, dynamic>,
      ),
    );
  }

  /// this is currently an experimental method
  /// and its signature may change in the future
  Future<SignDataResponse?> _signData({
    required SignDataRpcRequest request,
    required TonAppConnectionInjected connection,
  }) async {
    final payload = request.params.firstOrNull;
    if (payload == null) return null;

    return _tonConnectService.signData(
      requestId: request.id,
      connection: connection,
      payload: SignDataPayload.fromJson(
        jsonDecode(payload) as Map<String, dynamic>,
      ),
    );
  }

  Future<void> _triggerEvent(WalletEvent event) async {
    await _controller?.evaluateJavascript(
      source: '''
        window.$tonConnectJsBridgeKey._listeners.forEach((listener) => listener(${jsonEncode(event.toJson())}));
      ''',
    );
  }

  /// https://github.com/ton-blockchain/ton-connect/blob/main/bridge.md#js-bridge
  String _getJsSource(DeviceInfo deviceInfo) => '''
    window.$tonConnectJsBridgeKey = window.$tonConnectJsBridgeKey || {};
    window.$tonConnectJsBridgeKey._listeners = new Set();
    window.$tonConnectJsBridgeKey.tonconnect = {
      deviceInfo: ${jsonEncode(deviceInfo.toJson())},
      protocolVersion: ${deviceInfo.maxProtocolVersion},
      isWalletBrowser: true,
      connect: (protocolVersion, message) => {
        if (protocolVersion !== 2) throw new Error('Unsupported protocol version');
        return window.flutter_inappwebview.callHandler('$tonConnectJsHandlerName', 'connect', message);
      },
      restoreConnection: () => window.flutter_inappwebview.callHandler('$tonConnectJsHandlerName', 'restoreConnection'),
      send: (message) => window.flutter_inappwebview.callHandler('$tonConnectJsHandlerName', 'send', message),
      listen: (callback) => {
        window.$tonConnectJsBridgeKey._listeners.add(callback);
        return () => window.$tonConnectJsBridgeKey._listeners.delete(callback);
      },
    };
    ''';

  TonAppConnectionInjected? _getConnection() => url?.let(
        (url) => _storageService
            .readConnections()
            .whereType<TonAppConnectionInjected>()
            .firstWhereOrNull((e) => e.origin == url.origin),
      );
}
