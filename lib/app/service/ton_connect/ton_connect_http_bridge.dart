import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@lazySingleton
class TonConnectHttpBridge {
  TonConnectHttpBridge(
    this._tonConnectService,
    this._appLifecycleService,
    this._storageService,
    this._client,
  ) {
    _appLifecycleService.appLifecycleStateStream.listen(_onStateChange);
  }

  static final _logger = Logger('TonConnectHttpBridge');

  final TonConnectService _tonConnectService;
  final AppLifecycleService _appLifecycleService;
  final TonConnectStorageService _storageService;
  final http.Client _client;

  final _backoff = ExponentialBackoff(
    initialDuration: tonConnectBackoffInitialDuration,
    multiplier: tonConnectBackoffMultiplier,
    maxAttempts: tonConnectBackoffMaxAttempts,
  );

  StreamSubscription<SseMessage>? _sseSubscription;
  bool isRetrying = false;

  Future<void> openSseConnection() async {
    try {
      await _openSseConnection();
    } catch (e, s) {
      _logger.severe('Failed to open SSE connection', e, s);
      _retryOpen();
    }
  }

  Future<void> closeSseConnection() async {
    if (_sseSubscription != null) {
      _logger.info('SSE connection closed');
    }

    await _sseSubscription?.cancel();
    _sseSubscription = null;
  }

  Future<void> connect({
    required ConnectQuery query,
  }) async {
    final sessionCrypto = SessionCrypto();
    final request = ConnectRequest.fromJson(
      jsonDecode(Uri.decodeComponent(query.r)) as Map<String, dynamic>,
    );

    final result = await _tonConnectService.connect(request: request);

    if (result is ConnectResultError) {
      final response = WalletEvent.connectError(
        id: _storageService.getEventId(),
        payload: result.error,
      );
      await _send(
        clientId: query.id,
        sessionCrypto: sessionCrypto,
        data: jsonEncode(response.toJson()),
      );
      return;
    }

    final r = result as ConnectResultSuccess;
    final connection = TonAppConnection.remote(
      clientId: query.id,
      sessionCrypto: sessionCrypto,
      replyItems: r.replyItems,
      walletAddress: r.account.address,
      manifest: r.manifest,
    );
    _storageService.addConnection(connection);

    final response = WalletEvent.connectSuccess(
      id: _storageService.getEventId(),
      payload: ConnectEventSuccessPayload(
        device: await _tonConnectService.getDeviceInfo(),
        items: r.replyItems,
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
    num? ttl = tonConnectMessageDefaultTtl,
  }) async {
    final client = RetryClient(
      _client,
      retries: tonConnectHttpBridgeSendRetries,
      when: (_) => true,
    );
    try {
      await client.post(
        Uri.parse(
          '$tonConnectHttpBridgeUrl/message?client_id=${sessionCrypto.sessionId}&to=$clientId&ttl=$ttl',
        ),
        body: sessionCrypto.encrypt(data, clientId),
      );
    } catch (e, s) {
      _logger.severe('Send message failed', e, s);
    } finally {
      client.close();
    }
  }

  Future<void> _openSseConnection() async {
    await closeSseConnection();

    if (SchedulerBinding.instance.lifecycleState != AppLifecycleState.resumed) {
      return;
    }

    final connections =
        _storageService.readConnections().whereType<TonAppConnectionRemote>();

    if (connections.isEmpty) return;

    final ids = connections.map((e) => e.sessionCrypto.sessionId).join(',');
    final lastEventId = _storageService.readLastEventId();
    var uri = '$tonConnectHttpBridgeUrl/events?client_id=$ids';

    if (lastEventId != null) {
      uri += '&last_event_id=$lastEventId';
    }

    final request = http.Request('GET', Uri.parse(uri))
      ..headers['Accept'] = 'text/event-stream';

    final stream = await _client.send(request).then(
          (response) => response.stream.transform(
            ResponseBodyToSseMessageTransformer(),
          ),
        );

    _sseSubscription = stream.listen(
      _handleMessage,
      onError: (Object e, StackTrace st) {
        _logger.severe('SSE connection error', e, st);
      },
      onDone: _retryOpen,
    );

    _logger.info('SSE connection opened');
  }

  void _retryOpen() {
    if (isRetrying) return;
    isRetrying = true;

    _logger.finest('Retrying to open SSE connection');

    _backoff.run(() async {
      _logger.finest('Reconnect attempt');
      if (SchedulerBinding.instance.lifecycleState !=
          AppLifecycleState.resumed) {
        return;
      }

      await _openSseConnection();
      _logger.finest('Reconnect attempt success');
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
