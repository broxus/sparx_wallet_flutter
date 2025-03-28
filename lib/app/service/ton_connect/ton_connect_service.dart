import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/app_version_utils.dart';
import 'package:app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@lazySingleton
class TonConnectService {
  TonConnectService(
    this._storageService,
    this._nekotonRepository,
    this._client,
  );

  final TonConnectStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final http.Client _client;

  final _uiEvents = BehaviorSubject<TonConnectUiEvent>();

  Stream<TonConnectUiEvent> get uiEventsStream => _uiEvents.stream;

  Future<(KeyAccount, List<ConnectItemReply>)?> connect({
    required ConnectRequest request,
  }) async {
    // TonConnect is only available for TON network
    final transport = _nekotonRepository.currentTransport;
    if (transport.networkType != 'ton') {
      _uiEvents.add(
        TonConnectUiEvent.error(
          message: LocaleKeys.invalidNetworkError.tr(
            args: ['TON'],
          ),
        ),
      );
      return null;
    }

    final completer = Completer<(KeyAccount, List<ConnectItemReply>)?>();
    _uiEvents.add(
      TonConnectUiEvent.connect(
        request: request,
        completer: completer,
      ),
    );

    return completer.future;
  }

  void disconnect({
    required TonAppConnection connection,
  }) =>
      _storageService.removeConnection(connection);

  Future<SendTransactionResponse> sendTransaction({
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
    final networkId = transport.transport.networkId;
    if (transport.networkType != 'ton' ||
        payload.network?.toInt() != networkId) {
      _uiEvents.add(
        TonConnectUiEvent.error(
          message: LocaleKeys.invalidNetworkError.tr(
            args: ['TON'],
          ),
        ),
      );

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
      _uiEvents.add(
        TonConnectUiEvent.error(
          message: LocaleKeys.accountNotFound.tr(
            args: [connection.walletAddress.address],
          ),
        ),
      );

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
      _uiEvents.add(
        TonConnectUiEvent.error(
          message: LocaleKeys.operationTimeout.tr(),
        ),
      );

      return SendTransactionResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Request timed out',
        ),
      );
    }

    final completer = Completer<SignedMessage?>();
    _uiEvents.add(
      TonConnectUiEvent.sendTransaction(
        connection: connection,
        payload: payload,
        completer: completer,
      ),
    );

    final message = await completer.future;

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

  Future<SignDataResponse> signData({
    required TonAppConnection connection,
    required SignDataPayload payload,
    required String requestId,
  }) async {
    final transport = _nekotonRepository.currentTransport;
    if (transport.networkType != 'ton') {
      _uiEvents.add(
        TonConnectUiEvent.error(
          message: LocaleKeys.invalidNetworkError.tr(
            args: ['TON'],
          ),
        ),
      );

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
      _uiEvents.add(
        TonConnectUiEvent.error(
          message: LocaleKeys.accountNotFound.tr(
            args: [connection.walletAddress.address],
          ),
        ),
      );

      return SignDataResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Wallet not found',
        ),
      );
    }

    if (payload.publicKey != null && wallet.publicKey != payload.publicKey) {
      _uiEvents.add(
        TonConnectUiEvent.error(
          message: LocaleKeys.invalidPublicKeyError.tr(),
        ),
      );

      return SignDataResponse.error(
        id: requestId,
        error: TonConnectError(
          code: 1, // bad request
          message: 'Invalid public key',
        ),
      );
    }

    final completer = Completer<SignDataResult?>();
    _uiEvents.add(
      TonConnectUiEvent.signData(
        connection: connection,
        payload: payload,
        completer: completer,
      ),
    );

    final result = await completer.future;

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

  Future<DappManifest> getManifest(String manifestUrl) async {
    final uri = Uri.parse(manifestUrl);
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      return DappManifest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    throw Exception('Failed to load DappManifest');
  }

  Future<DeviceInfo> getDeviceInfo() async => DeviceInfo(
        platform: Platform.operatingSystem,
        appName: 'sparx',
        appVersion: await AppVersion.appVersion,
        maxProtocolVersion: 2,
        features: const [
          Feature.sendTransaction(maxMessages: 4),
          Feature.signData(),
        ],
      );
}
