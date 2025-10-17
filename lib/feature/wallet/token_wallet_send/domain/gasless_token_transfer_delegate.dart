import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/fee.dart';
import 'package:app/feature/wallet/token_wallet_send/token_wallet_send.dart';
import 'package:app/http/repository/gasless_repository.dart';
import 'package:app/utils/utils.dart';
import 'package:convert/convert.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
final class GaslessTokenTransferDelegate extends TokenTransferDelegate {
  GaslessTokenTransferDelegate(
    this._nekotonRepository,
    this._gaslessRepository,
  );

  final NekotonRepository _nekotonRepository;
  final GaslessRepository _gaslessRepository;

  TransportStrategy get _transport => _nekotonRepository.currentTransport;

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
    final config = await _gaslessRepository.getConfig();
    if (config == null) throw StateError('Gasless config is not available');

    final internalMessage = await _nekotonRepository.prepareTokenTransfer(
      owner: owner,
      rootTokenContract: rootTokenContract,
      destination: repackAddress(destination),
      amount: amount,
      payload: comment?.let((it) => encodeComment(it, plain: _transport.isTon)),
      attachedAmount: attachedAmount,
      notifyReceiver: notifyReceiver ?? false,
      // remainingGasTo: config.relayAddress,
    );

    final boc = await encodeInternalMessage(
      dst: internalMessage.destination,
      amount: internalMessage.amount,
      body: internalMessage.body,
      bounce: true,
    );

    final response = await _gaslessRepository.estimate(
      masterId: rootTokenContract.toRaw(),
      walletAddress: owner,
      walletPublicKey: publicKey,
      messages: [boc],
    );

    final (hash, payload) = await _prepareWalletV5R1MessageBody(
      address: owner,
      publicKey: publicKey,
      expiration: defaultSendTimeout,
      params: response.messages
          .map(
            (msg) => TonWalletTransferParams(
              destination: msg.address,
              amount: msg.amount,
              body: msg.payload,
              bounce: defaultMessageBounce,
              stateInit: msg.stateInit,
            ),
          )
          .toList(),
      isInternalFlow: true,
    );

    final walletState = await _nekotonRepository.getTokenWallet(
      owner,
      rootTokenContract,
    );
    if (walletState.error != null) {
      throw UiException(walletState.error!.toString());
    }

    return PreparedTokenTransfer.gasless(
      amount: amount,
      hash: hash,
      payload: payload,
      destination: internalMessage.destination,
      owner: owner,
      rootTokenContract: rootTokenContract,
      publicKey: publicKey,
      fee: Fee.token(
        amount: Money.fromBigIntWithCurrency(
          response.commission,
          walletState.wallet!.currency,
        ),
        tokenRootAddress: rootTokenContract,
      ),
    );
  }

  @override
  Future<TokenTransactionCompleter> sendMessage({
    required PreparedTokenTransfer transfer,
    required TokenTransferSigner signer,
  }) async {
    if (transfer is! PreparedTokenTransferGasless) {
      throw StateError(
        'GaslessTokenTransferDelegate can send only gasless transfers',
      );
    }

    final signature = await signer.signDataRaw(
      base64Encode(hex.decode(transfer.hash)),
    );
    final body = await TonWallet.appendSignatureToWalletV5R1Payload(
      payload: transfer.payload,
      base64Signature: signature,
    );

    final walletState = await _nekotonRepository.getWallet(transfer.owner);
    String? stateInit;

    if (walletState.wallet != null) {
      final contractState = await _transport.transport.getContractState(
        transfer.owner,
      );
      final seqno = await walletState.wallet!.getWalletV5R1Seqno(
        contractState: contractState,
        publicKey: transfer.publicKey,
      );

      if (seqno == 0) {
        stateInit = await walletState.wallet!.makeStateInit();
      }
    }

    final message = await createRawExternalMessage(
      dst: transfer.owner,
      body: body,
      timeout: const Duration(seconds: 60),
      stateInit: stateInit,
    );

    final completer = Completer<void>();

    unawaited(
      _send(
        transfer: transfer,
        message: message,
      ).then(completer.complete).catchError(completer.completeError),
    );

    return TokenTransactionCompleter(completer);
  }

  @override
  Future<Fee> estimateFees(PreparedTokenTransfer transfer) async {
    if (transfer is! PreparedTokenTransferGasless) {
      throw StateError(
        'GaslessTokenTransferDelegate can estimate only gasless transfers',
      );
    }

    return transfer.fee;
  }

  @override
  Future<List<TxTreeSimulationErrorItem>> simulateTransactionTree(
    PreparedTokenTransfer transfer,
  ) async {
    return [];
  }

  Future<(String, String)> _prepareWalletV5R1MessageBody({
    required Address address,
    required Expiration expiration,
    required List<TonWalletTransferParams> params,
    PublicKey? publicKey,
    bool isInternalFlow = false,
  }) async {
    final walletState = await _nekotonRepository.getWallet(address);
    final wallet = walletState.wallet;

    if (wallet == null) {
      throw TonWalletStateNotInitializedException(
        address: address,
        subscriptionError: walletState.error,
      );
    }

    final contractState = await wallet.transport.getContractState(address);

    if (!contractState.isExists()) {
      return wallet.prepareNonexistWalletV5R1MessageBody(
        expiration: expiration,
        params: params,
        isInternalFlow: isInternalFlow,
      );
    }

    return wallet.prepareWalletV5R1MessageBody(
      contractState: contractState,
      publicKey: publicKey ?? wallet.publicKey,
      expiration: expiration,
      params: params,
      isInternalFlow: isInternalFlow,
    );
  }

  Future<void> _send({
    required PreparedTokenTransferGasless transfer,
    required SignedMessage message,
  }) async {
    await _gaslessRepository.send(
      walletPublicKey: transfer.publicKey,
      boc: message.boc,
    );
  }
}
