import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/app/service/service.dart';
import 'package:app/app/service/ton_connect/event_source_transformer.dart';
import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/app/service/ton_connect/session_crypto.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/app_version_utils.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@singleton
class TonConnectService {
  TonConnectService(
    this._storageService,
    this._nekotonRepository,
    this._messengerService,
  );

  static final _logger = Logger('TonConnectService');

  final TonConnectStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
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
    // TonConnect is only available for TON network
    final transport = _nekotonRepository.currentTransport;
    if (transport.networkType != 'ton') {
      _messengerService.show(
        Message.error(
          context: context,
          message: LocaleKeys.invalidNetworkError.tr(
            args: ['TON'],
          ),
        ),
      );
      return;
    }

    final sessionCrypto = SessionCrypto();
    final request = ConnectRequest.fromJson(
      jsonDecode(Uri.decodeComponent(query.r)) as Map<String, dynamic>,
    );

    final result = await showTonConnectSheet(
      context: context,
      request: request,
    );

    if (result == null) return;

    final oldConnection = _storageService
        .readConnections()
        .whereType<TonAppConnectionRemote>()
        .firstWhereOrNull((e) => e.clientId == query.id);
    if (oldConnection != null) {
      await disconnect(connection: oldConnection);
    }

    final (account, replyItems) = result;
    final connection = TonAppConnection.remote(
      clientId: query.id,
      sessionCrypto: sessionCrypto,
      replyItems: replyItems,
      walletAddress: account.address,
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

  Future<void> disconnect({
    required TonAppConnection connection,
    String? requestId,
  }) async {
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

  Future<void> sendTransaction({
    required TonAppConnection connection,
    required TransactionPayload payload,
    String? requestId,
  }) async {
    final response = await _sendTransaction(
      connection: connection,
      payload: payload,
      requestId: requestId ?? _getEventId(),
    );
    final remote = switch (connection) {
      TonAppConnectionRemote() => connection,
      TonAppConnectionInjected() => null,
    };

    if (remote != null) {
      await _send(
        clientId: remote.clientId,
        sessionCrypto: remote.sessionCrypto,
        data: jsonEncode(response.toJson()),
      );
    }
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

  String _getEventId() {
    _storageService.saveEventId(++_eventId);
    return _eventId.toString();
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
      final json = connection.sessionCrypto.decrypt(msg, from);
      final rpcRequest = RpcRequest.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );

      await rpcRequest.when<Future<void>>(
        disconnect: (id, params) => disconnect(
          requestId: id,
          connection: connection,
        ),
        sendTransaction: (id, params) async {
          final payload = params.firstOrNull;
          if (payload == null) return;
          return sendTransaction(
            requestId: id,
            connection: connection,
            payload: TransactionPayload.fromJson(
              jsonDecode(payload) as Map<String, dynamic>,
            ),
          );
        },
        // this is currently an experimental method
        // and its signature may change in the future
        signData: (id, params) => throw UnimplementedError(),
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

  Future<SendTransactionResponse> _sendTransaction({
    required TonAppConnection connection,
    required TransactionPayload payload,
    required String requestId,
  }) async {
    if (payload.from != null && payload.from != connection.walletAddress) {
      return SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Wrong "from" parameter',
        ),
      );
    }

    final transport = _nekotonRepository.currentTransport;
    final networkId = await transport.transport.getNetworkId();
    if (transport.networkType != 'ton' ||
        payload.network?.toInt() != networkId) {
      return SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Wrong network',
        ),
      );
    }

    final walletState = await _nekotonRepository.getWallet(
      connection.walletAddress,
    );
    final wallet = walletState.wallet;
    if (wallet == null) {
      return SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Wallet not found',
        ),
      );
    }

    final now = NtpTime.now().millisecondsSinceEpoch ~/ 1000;
    if (payload.validUntil != null && payload.validUntil! < now) {
      return SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Request timed out',
        ),
      );
    }
  }
}
