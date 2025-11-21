import 'package:app/app/service/ntp_service.dart';
import 'package:app/feature/ton_connect/data/data.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@lazySingleton
class TonConnectRequestValidator {
  TonConnectRequestValidator(this._nekotonRepository, this._ntpService);

  final NekotonRepository _nekotonRepository;
  final NtpService _ntpService;

  Future<TonConnectError?> validateSignDataRequest({
    required TonAppConnection connection,
    required SignDataPayload payload,
  }) async {
    final walletState = await _nekotonRepository.getWallet(
      connection.walletAddress,
    );
    final wallet = walletState.wallet;
    if (wallet == null) {
      return TonConnectError(
        code: TonConnectErrorCode.badRequest,
        message: 'Wallet not found',
      );
    }

    if (payload.from != null &&
        wallet.address != Address(address: payload.from!)) {
      return TonConnectError(
        code: TonConnectErrorCode.badRequest,
        message: 'Invalid wallet address',
      );
    }

    return null;
  }

  Future<TonConnectError?> validateSendTransactionRequest({
    required TonAppConnection connection,
    required TransactionPayload payload,
  }) async {
    if (payload.from != null && payload.from != connection.walletAddress) {
      return TonConnectError(
        code: TonConnectErrorCode.badRequest,
        message: 'Wrong "from" parameter',
      );
    }

    if (payload.messages.isEmpty) {
      return TonConnectError(
        code: TonConnectErrorCode.badRequest,
        message: 'Messages cannot be empty',
      );
    }

    for (final message in payload.messages) {
      if (!message.address.isValid || message.address.isRaw) {
        return TonConnectError(
          code: TonConnectErrorCode.badRequest,
          message: 'Invalid address format',
        );
      }

      if (message.payload != null && !validateCell(message.payload!)) {
        return TonConnectError(
          code: TonConnectErrorCode.badRequest,
          message: 'Payload is invalid',
        );
      }

      if (message.stateInit != null && !validateCell(message.stateInit!)) {
        return TonConnectError(
          code: TonConnectErrorCode.badRequest,
          message: 'StateInit is invalid',
        );
      }
    }

    final walletState = await _nekotonRepository.getWallet(
      connection.walletAddress,
    );
    final wallet = walletState.wallet;
    if (wallet == null) {
      return TonConnectError(
        code: TonConnectErrorCode.badRequest,
        message: 'Wallet not found',
      );
    }

    final totalAmount = payload.messages.fold<BigInt>(
      BigInt.zero,
      (prev, e) => prev + BigInt.parse(e.amount),
    );
    if (totalAmount > wallet.contractState.balance) {
      return TonConnectError(
        code: TonConnectErrorCode.badRequest,
        message: 'Insufficient funds',
      );
    }

    final now = _ntpService.now().secondsSinceEpoch;
    if (payload.validUntil != null && payload.validUntil! < now) {
      return TonConnectError(
        code: TonConnectErrorCode.badRequest,
        message: 'Request timed out',
      );
    }

    return null;
  }
}
