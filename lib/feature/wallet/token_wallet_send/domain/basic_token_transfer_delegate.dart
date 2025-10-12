import 'dart:async';

import 'package:app/app/service/connection/connection.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/token_wallet_send/token_wallet_send.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
final class BasicTokenTransferDelegate extends TokenTransferDelegate {
  BasicTokenTransferDelegate(
    this._nekotonRepository,
  );

  final NekotonRepository _nekotonRepository;

  TransportStrategy get _transport => _nekotonRepository.currentTransport;

  Currency get _currency => Currencies()[_transport.nativeTokenTicker]!;

  @override
  Future<PreparedTokenTransfer> prepareTransfer({
    required Address owner,
    required Address rootTokenContract,
    required PublicKey publicKey,
    required Address destination,
    required BigInt amount,
    BigInt? attachedAmount,
    String? comment,
    bool? notifyReceiver,
  }) async {
    final internalMessage = await _nekotonRepository.prepareTokenTransfer(
      owner: owner,
      rootTokenContract: rootTokenContract,
      destination: repackAddress(destination),
      amount: amount,
      payload: comment?.let((it) => encodeComment(it, plain: _transport.isTon)),
      attachedAmount: attachedAmount,
      notifyReceiver: notifyReceiver ?? false,
    );

    final unsignedMessage = await _nekotonRepository.prepareTransfer(
      address: owner,
      publicKey: publicKey,
      expiration: defaultSendTimeout,
      params: [
        TonWalletTransferParams(
          destination: internalMessage.destination,
          amount: internalMessage.amount,
          body: internalMessage.body,
          bounce: defaultMessageBounce,
        ),
      ],
    );

    return PreparedTokenTransfer.basic(
      unsignedMessage: unsignedMessage,
      destination: internalMessage.destination,
      attachedAmount: internalMessage.amount,
      owner: owner,
      rootTokenContract: rootTokenContract,
    );
  }

  @override
  Future<TokenTransactionCompleter> sendMessage({
    required PreparedTokenTransfer transfer,
    required TokenTransferSigner signer,
  }) async {
    if (transfer is! PreparedTokenTransferBasic) {
      throw StateError(
        'BasicTokenTransferDelegate can send only basic transfers',
      );
    }

    final signedMessage = await signer.signMessage(transfer.unsignedMessage);
    final completer = Completer<void>();

    unawaited(
      _nekotonRepository
          .send(
            address: transfer.owner,
            signedMessage: signedMessage,
            amount: transfer.attachedAmount,
            destination: transfer.destination,
          )
          .then(completer.complete)
          .catchError(completer.completeError),
    );

    return TokenTransactionCompleter(completer);
  }

  @override
  Future<Fee> estimateFees(PreparedTokenTransfer transfer) async {
    if (transfer is! PreparedTokenTransferBasic) {
      throw StateError(
        'BasicTokenTransferDelegate can send only basic transfers',
      );
    }

    final value = await _nekotonRepository.estimateFees(
      address: transfer.owner,
      message: transfer.unsignedMessage,
    );

    return Fee.native(
      Money.fromBigIntWithCurrency(value, _currency),
    );
  }

  @override
  Future<List<TxTreeSimulationErrorItem>> simulateTransactionTree(
    PreparedTokenTransfer transfer,
  ) {
    if (transfer is! PreparedTokenTransferBasic) {
      throw StateError(
        'BasicTokenTransferDelegate can send only basic transfers',
      );
    }

    return _nekotonRepository.simulateTransactionTree(
      address: transfer.owner,
      message: transfer.unsignedMessage,
    );
  }
}
