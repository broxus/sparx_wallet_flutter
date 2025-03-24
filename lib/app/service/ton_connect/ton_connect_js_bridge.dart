import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

const _handlerName = 'sparxTonConnectWebviewHandler';
const _jsBridgeKey = 'sparx';

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
      handlerName: _handlerName,
      callback: (List<dynamic> arguments) async {
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
          code: 0,
          message: 'Unknown error',
        ),
      );
    }

    final payload = message as Map<String, dynamic>;
    final request = ConnectRequest.fromJson(payload);

    final result = await _tonConnectService.connect(request: request);
    if (result == null) {
      return WalletEvent.connectError(
        id: _storageService.getEventId(),
        payload: TonConnectError(
          code: 300,
          message: 'User declined the connection',
        ),
      );
    }

    final (account, replyItems) = result;
    final connection = TonAppConnection.injected(
      origin: origin,
      replyItems: replyItems,
      walletAddress: account.address,
      manifestUrl: request.manifestUrl,
    );
    _storageService.addConnection(connection);

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
        window.$_jsBridgeKey._listeners.forEach((listener) => listener(${jsonEncode(event.toJson())}));
      ''',
    );
  }

  /// https://github.com/ton-blockchain/ton-connect/blob/main/bridge.md#js-bridge
  String _getJsSource(DeviceInfo deviceInfo) => '''
    window.$_jsBridgeKey = window.$_jsBridgeKey || {};
    window.$_jsBridgeKey._listeners = new Set();
    window.$_jsBridgeKey.tonconnect = {
      deviceInfo: ${jsonEncode(deviceInfo.toJson())},
      protocolVersion: ${deviceInfo.maxProtocolVersion},
      isWalletBrowser: true,
      connect: (protocolVersion, message) => {
        if (protocolVersion !== 2) throw new Error('Unsupported protocol version');
        return window.flutter_inappwebview.callHandler('$_handlerName', 'connect', message);
      },
      restoreConnection: () => window.flutter_inappwebview.callHandler('$_handlerName', 'restoreConnection'),
      send: (message) => window.flutter_inappwebview.callHandler('$_handlerName', 'send', message),
      listen: (callback) => {
        window.$_jsBridgeKey._listeners.add(callback);
        return () => window.$_jsBridgeKey._listeners.delete(callback);
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
