import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/app/service/service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/app_version_utils.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@lazySingleton
class TonConnectService {
  TonConnectService(
    this._storageService,
    this._nekotonRepository,
    this._messengerService,
  );

  final TonConnectStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

  Future<(KeyAccount, List<ConnectItemReply>)?> connect({
    required ConnectRequest request,
    BuildContext? context,
  }) async {
    context ??= NavigationService.navigatorKey.currentContext;

    if (context == null) return null;

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
      return null;
    }

    return showTCConnectSheet(
      context: context,
      request: request,
    );
  }

  void disconnect({
    required TonAppConnection connection,
  }) =>
      _storageService.removeConnection(connection);

  Future<SendTransactionResponse> sendTransaction({
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
    final networkId = transport.transport.networkId;
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

  Future<SignDataResponse> signData({
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
