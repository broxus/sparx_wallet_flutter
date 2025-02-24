import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/app/service/storage_service/storage_service.dart';
import 'package:app/app/service/ton_connect/event_source_transformer.dart';
import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/app/service/ton_connect/session_crypto.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/utils/app_version_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class TonConnectService {
  TonConnectService(this._storageService);

  static final _logger = Logger('TonConnectService');

  final TonConnectStorageService _storageService;
  final _bridgeUrl = 'https://bridge.tonapi.io/bridge';

  late var _eventId = _storageService.readEventId();
  StreamSubscription<SseMessage>? _subscription;
  http.Client? _client;

  Future<void> open() async {
    await close();

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
    _subscription = await _client!
        .send(request)
        .then((response) => response.stream.transform(EventSourceTransformer()))
        .then((stream) => stream.listen(_handleMessage));
  }

  Future<void> close() async {
    await _subscription?.cancel();
    _client?.close();
    _subscription = null;
    _client = null;
  }

  Future<void> connect({
    required ConnectQuery query,
    required BuildContext context,
  }) async {
    final sessionCrypto = SessionCrypto();
    final request = ConnectRequest.fromJson(
      jsonDecode(Uri.decodeComponent(query.r)) as Map<String, dynamic>,
    );

    final replyItems = await showTonConnectSheet(
      context: context,
      request: request,
    );

    if (replyItems == null) return;

    final connection = TonAppConnection.remote(
      clientId: query.id,
      sessionCrypto: sessionCrypto,
      replyItems: replyItems,
    );
    _storageService.addConnection(connection);

    final response = WalletEvent.connectSuccess(
      id: _getEventId(),
      payload: ConnectEventSuccessPayload(
        device: await _getDeviceInfo(),
        items: replyItems,
      ),
    );
    await _send(
      clientId: query.id,
      sessionCrypto: sessionCrypto,
      data: jsonEncode(response.toJson()),
    );

    await open(); // reconnect to http bridge
  }

  Future<void> disconnect(TonAppConnection connection) async {
    _storageService.removeConnection(connection);

    final remote = switch (connection) {
      TonAppConnectionRemote() => connection,
      TonAppConnectionInjected() => null,
    };

    if (remote == null) return;

    await _send(
      clientId: remote.clientId,
      sessionCrypto: remote.sessionCrypto,
      data: jsonEncode(
        WalletEvent.disconnect(id: _getEventId()).toJson(),
      ),
    );
  }

  Future<void> _send({
    required String clientId,
    required SessionCrypto sessionCrypto,
    required String data,
    num? ttl = 300,
  }) async {
    try {
      await http.post(
        Uri.parse(
          '$_bridgeUrl/message?client_id=${sessionCrypto.sessionId}&to=$clientId&ttl=$ttl',
        ),
        body: sessionCrypto.encrypt(data, clientId),
      );
    } catch (e, s) {
      _logger.severe('Send message failed', e, s);
    }
  }

  num _getEventId() {
    _storageService.saveEventId(++_eventId);
    return _eventId;
  }

  Future<void> _handleMessage(SseMessage message) async {
    if (message.event == 'heartbeat') return;

    if (message.id != null) {
      _storageService.saveLastEventId(message.id!);
    }

    final json = jsonDecode(message.data ?? '{}') as Map<String, dynamic>;
    final from = json['from'] as String?;
    final msg = json['message'] as String?;

    if (from == null || msg == null) return;

    final connection = _storageService
        .readConnections()
        .whereType<TonAppConnectionRemote>()
        .firstWhereOrNull((e) => e.clientId == from);

    if (connection == null) return;

    try {
      // "{"method":"disconnect","params":[],"id":"0"}"
      final json = connection.sessionCrypto.decrypt(msg, from);
      final rpcRequest = RpcRequest.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );

      await rpcRequest.when<Future<void>>(
        disconnect: (id, params) => disconnect(connection),
        sendTransaction: (id, params) async {},
      );
    } catch (e, s) {
      _logger.severe('Handle message failed', e, s);
    }
  }

  Future<DeviceInfo> _getDeviceInfo() async => DeviceInfo(
        platform: Platform.operatingSystem,
        appName: 'SparX Wallet',
        appVersion: await AppVersion.appVersion,
        maxProtocolVersion: 2,
        features: const [
          Feature.sendTransaction(maxMessages: 4),
          Feature.signData(),
        ],
      );
}
