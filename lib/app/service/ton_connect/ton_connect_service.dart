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
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

// https://bridge.tonapi.io/bridge
const _bridgeUrl = 'https://ton-connect-bridge.sparxwallet.com/bridge';

@singleton
class TonConnectService {
  TonConnectService(
    this._storageService,
    this._nekotonRepository,
    this._messengerService,
    this._appLifecycleService,
  ) {
    _appLifecycleService.appLifecycleStateStream.listen(_onStateChange);
  }

  static final _logger = Logger('TonConnectService');

  final TonConnectStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final AppLifecycleService _appLifecycleService;

  late var _eventId = _storageService.readEventId();
  final _backoff = ExponentialBackoff(
    initialDuration: const Duration(seconds: 2),
    multiplier: 2,
    maxAttempts: 6, // 2^6 = 64 seconds
  );

  StreamSubscription<SseMessage>? _sseSubscription;
  http.Client? _client;

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
        .then((response) => response.stream.transform(EventSourceTransformer()))
        .then((stream) => stream.listen(_handleMessage));

    _sseSubscription?.onError((Object e, StackTrace st) {
      _logger.severe('SSE connection error', e, st);
    });

    _sseSubscription?.onDone(_retryOpen);
  }

  Future<void> closeSseConnection() async {
    await _sseSubscription?.cancel();
    _client?.close();
    _sseSubscription = null;
    _client = null;
  }

  Future<void> connect({
    required ConnectQuery query,
    BuildContext? context,
  }) async {
    context ??= NavigationService.navigatorKey.currentContext;

    if (context == null) return;

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

    final result = await showTCConnectSheet(
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
      manifestUrl: request.manifestUrl,
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

    await openSseConnection(); // reconnect to http bridge
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
    BuildContext? context,
  }) async {
    final response = await _sendTransaction(
      connection: connection,
      payload: payload,
      requestId: requestId ?? _getEventId(),
      context: context,
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

  Future<void> signData({
    required TonAppConnection connection,
    required SignDataPayload payload,
    String? requestId,
    BuildContext? context,
  }) async {
    final response = await _signData(
      connection: connection,
      payload: payload,
      requestId: requestId ?? _getEventId(),
      context: context,
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

  Future<DappManifest> getManifest(String manifestUrl) async {
    final uri = Uri.parse(manifestUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return DappManifest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    throw Exception('Failed to load DappManifest');
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
        signData: (id, params) async {
          final payload = params.firstOrNull;
          if (payload == null) return;
          return signData(
            requestId: id,
            connection: connection,
            payload: SignDataPayload.fromJson(
              jsonDecode(payload) as Map<String, dynamic>,
            ),
          );
        },
      );
    } catch (e, s) {
      _logger.severe('Handle message failed', e, s);
    }
  }

  Future<DeviceInfo> _getDeviceInfo() async => DeviceInfo(
        platform: Platform.operatingSystem,
        appName: 'sparx',
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
    BuildContext? context,
  }) async {
    context ??= NavigationService.navigatorKey.currentContext;

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
      if (context != null && context.mounted) {
        _messengerService.show(
          Message.error(
            context: context,
            message: LocaleKeys.invalidNetworkError.tr(
              args: ['TON'],
            ),
          ),
        );
      }

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
      if (context != null && context.mounted) {
        _messengerService.show(
          Message.error(
            context: context,
            message: LocaleKeys.accountNotFound.tr(
              args: [connection.walletAddress.address],
            ),
          ),
        );
      }

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
      if (context != null && context.mounted) {
        _messengerService.show(
          Message.error(
            context: context,
            message: LocaleKeys.operationTimeout.tr(),
          ),
        );
      }

      return SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Request timed out',
        ),
      );
    }

    if (context == null || !context.mounted) {
      return SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 0,
          message: 'Unknown error',
        ),
      );
    }

    final message = await showTCSendMessageSheet(
      context: context,
      connection: connection,
      payload: payload,
    );

    if (message == null) {
      return SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 300,
          message: 'User declined the transaction',
        ),
      );
    }

    return SendTransactionResponse.success(
      id: requestId,
      result: message.boc,
    );
  }

  Future<SignDataResponse> _signData({
    required TonAppConnection connection,
    required SignDataPayload payload,
    required String requestId,
    BuildContext? context,
  }) async {
    context ??= NavigationService.navigatorKey.currentContext;

    final transport = _nekotonRepository.currentTransport;
    if (transport.networkType != 'ton') {
      if (context != null && context.mounted) {
        _messengerService.show(
          Message.error(
            context: context,
            message: LocaleKeys.invalidNetworkError.tr(
              args: ['TON'],
            ),
          ),
        );
      }

      return SignDataResponse.error(
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
      if (context != null && context.mounted) {
        _messengerService.show(
          Message.error(
            context: context,
            message: LocaleKeys.accountNotFound.tr(
              args: [connection.walletAddress.address],
            ),
          ),
        );
      }

      return SignDataResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Wallet not found',
        ),
      );
    }

    if (payload.publicKey != null && wallet.publicKey != payload.publicKey) {
      if (context != null && context.mounted) {
        _messengerService.show(
          Message.error(
            context: context,
            message: LocaleKeys.invalidPublicKeyError.tr(),
          ),
        );
      }

      return SignDataResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Invalid public key',
        ),
      );
    }

    if (context == null || !context.mounted) {
      return SignDataResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 0,
          message: 'Unknown error',
        ),
      );
    }

    final result = await showTCSignDataSheet(
      context: context,
      connection: connection,
      payload: payload,
    );

    if (result == null) {
      return SignDataResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 300,
          message: 'User declined the transaction',
        ),
      );
    }

    return SignDataResponse.success(
      id: requestId,
      result: result,
    );
  }

  void _retryOpen() {
    _backoff.run(() async {
      if (SchedulerBinding.instance.lifecycleState !=
          AppLifecycleState.resumed) {
        return;
      }

      await openSseConnection();
    }).catchError((Object e, StackTrace s) {
      _logger.severe('Failed to reconnect to http bridge', e, s);
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
