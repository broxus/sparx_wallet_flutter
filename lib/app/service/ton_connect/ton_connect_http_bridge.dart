import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

// https://bridge.tonapi.io/bridge
const _bridgeUrl = 'https://ton-connect-bridge.sparxwallet.com/bridge';

@lazySingleton
class TonConnectHttpBridge {
  TonConnectHttpBridge(
    this._tonConnectService,
    this._appLifecycleService,
    this._storageService,
  ) {
    _appLifecycleService.appLifecycleStateStream.listen(_onStateChange);
  }

  static final _logger = Logger('TonConnectHttpBridge');

  final TonConnectService _tonConnectService;
  final AppLifecycleService _appLifecycleService;
  final TonConnectStorageService _storageService;

  final _backoff = ExponentialBackoff(
    initialDuration: const Duration(seconds: 2),
    multiplier: 2,
    maxAttempts: 6, // 2^6 = 64 seconds
  );

  StreamSubscription<SseMessage>? _sseSubscription;
  http.Client? _client;
  bool isRetrying = false;

  Future<void> openSseConnection() async {
    await closeSseConnection();

    if (SchedulerBinding.instance.lifecycleState != AppLifecycleState.resumed) {
      return;
    }

    final connections =
        _storageService.readConnections().whereType<TonAppConnectionRemote>();

    if (connections.isEmpty) return;

    final ids = connections.map((e) => e.sessionCrypto.sessionId).join(',');
    final lastEventId = _storageService.readLastEventId();
    var uri = '$_bridgeUrl/events?client_id=$ids';

    if (lastEventId != null) {
      uri += '&last_event_id=$lastEventId';
    }

    final request = http.Request('GET', Uri.parse(uri))
      ..headers['Accept'] = 'text/event-stream';

    _client = http.Client();
    _sseSubscription = await _client!
        .send(request)
        .then(
          (response) =>
              response.stream.transform(ResponseBodyToSseMessageTransformer()),
        )
        .then((stream) => stream.listen(_handleMessage));

    _sseSubscription?.onError((Object e, StackTrace st) {
      _logger.severe('SSE connection error', e, st);
    });

    _sseSubscription?.onDone(_retryOpen);

    _logger.info('SSE connection opened');
  }

  Future<void> closeSseConnection() async {
    if (_sseSubscription != null) {
      _logger.info('SSE connection closed');
    }

    await _sseSubscription?.cancel();
    _client?.close();
    _sseSubscription = null;
    _client = null;
  }

  Future<void> connect({
    required ConnectQuery query,
    BuildContext? context,
  }) async {
    final sessionCrypto = SessionCrypto();
    final request = ConnectRequest.fromJson(
      jsonDecode(Uri.decodeComponent(query.r)) as Map<String, dynamic>,
    );

    final result = await _tonConnectService.connect(request: request);

    if (result == null) {
      final response = WalletEvent.connectError(
        id: _storageService.getEventId(),
        payload: TonConnectError(
          code: 300,
          message: 'User declined the connection',
        ),
      );
      await _send(
        clientId: query.id,
        sessionCrypto: sessionCrypto,
        data: jsonEncode(response.toJson()),
      );
      return;
    }

    final (account, replyItems) = result;
    final connection = TonAppConnection.remote(
      clientId: query.id,
      sessionCrypto: sessionCrypto,
      replyItems: replyItems,
      walletAddress: account.address,
      manifestUrl: request.manifestUrl,
    );
    _storageService.addConnection(connection);

    final response = WalletEvent.connectSuccess(
      id: _storageService.getEventId(),
      payload: ConnectEventSuccessPayload(
        device: await _tonConnectService.getDeviceInfo(),
        items: replyItems,
      ),
    );
    await _send(
      clientId: query.id,
      sessionCrypto: sessionCrypto,
      data: jsonEncode(response.toJson()),
    );

    await openSseConnection(); // reconnect to http bridge
  }

  Future<void> _handleMessage(SseMessage message) async {
    if (message.event == 'heartbeat') return;

    if (message.id != null) {
      _storageService.saveLastEventId(message.id!);
    }

    late final Map<String, dynamic> json;
    try {
      json = jsonDecode(message.data ?? '{}') as Map<String, dynamic>;
    } catch (e) {
      _logger.severe('Failed to decode JSON', e);
      return;
    }

    final from = json['from'] as String?;
    final msg = json['message'] as String?;

    if (from == null || msg == null) return;

    final connection = _storageService
        .readConnections()
        .whereType<TonAppConnectionRemote>()
        .firstWhereOrNull((e) => e.clientId == from);

    if (connection == null) return;

    try {
      final json = connection.sessionCrypto.decrypt(msg, from);
      final rpcRequest = RpcRequest.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );

      _logger.finest('Received message: ${rpcRequest.toJson()}');

      await switch (rpcRequest) {
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

  Future<void> _disconnect({
    required TonAppConnectionRemote connection,
  }) async {
    _tonConnectService.disconnect(connection: connection);

    await _send(
      clientId: connection.clientId,
      sessionCrypto: connection.sessionCrypto,
      data: jsonEncode(
        WalletEvent.disconnect(id: _storageService.getEventId()).toJson(),
      ),
    );
  }

  Future<void> _sendTransaction({
    required SendTransactionRpcRequest request,
    required TonAppConnectionRemote connection,
  }) async {
    final payload = request.params.firstOrNull;
    if (payload == null) return;

    final response = await _tonConnectService.sendTransaction(
      requestId: request.id,
      connection: connection,
      payload: TransactionPayload.fromJson(
        jsonDecode(payload) as Map<String, dynamic>,
      ),
    );

    await _send(
      clientId: connection.clientId,
      sessionCrypto: connection.sessionCrypto,
      data: jsonEncode(response.toJson()),
    );
  }

  /// this is currently an experimental method
  /// and its signature may change in the future
  Future<void> _signData({
    required SignDataRpcRequest request,
    required TonAppConnectionRemote connection,
  }) async {
    final payload = request.params.firstOrNull;
    if (payload == null) return;

    final response = await _tonConnectService.signData(
      requestId: request.id,
      connection: connection,
      payload: SignDataPayload.fromJson(
        jsonDecode(payload) as Map<String, dynamic>,
      ),
    );

    await _send(
      clientId: connection.clientId,
      sessionCrypto: connection.sessionCrypto,
      data: jsonEncode(response.toJson()),
    );
  }

  Future<void> _send({
    required String clientId,
    required SessionCrypto sessionCrypto,
    required String data,
    num? ttl = 300,
  }) async {
    final client = RetryClient(http.Client(), retries: 2, when: (_) => true);
    try {
      await client.post(
        Uri.parse(
          '$_bridgeUrl/message?client_id=${sessionCrypto.sessionId}&to=$clientId&ttl=$ttl',
        ),
        body: sessionCrypto.encrypt(data, clientId),
      );
    } catch (e, s) {
      _logger.severe('Send message failed', e, s);
    } finally {
      client.close();
    }
  }

  void _retryOpen() {
    if (isRetrying) return;

    _backoff.run(() async {
      if (SchedulerBinding.instance.lifecycleState !=
          AppLifecycleState.resumed) {
        return;
      }

      await openSseConnection();
    }).catchError((Object e, StackTrace s) {
      _logger.severe('Failed to reconnect to http bridge', e, s);
    }).whenComplete(() {
      isRetrying = false;
    });
  }

  void _onStateChange(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      openSseConnection();
    } else if (state == AppLifecycleState.inactive) {
      closeSseConnection();
    }
  }
}
