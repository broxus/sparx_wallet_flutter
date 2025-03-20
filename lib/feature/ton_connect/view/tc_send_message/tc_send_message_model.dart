import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/app/service/ton_connect/ton_connect.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class TCSendMessageModel extends ElementaryModel {
  TCSendMessageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._tonConnectService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final TonConnectService _tonConnectService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Future<DappManifest> getManifest(String manifestUrl) =>
      _tonConnectService.getManifest(manifestUrl);

  Stream<Money> getBalanceStream(Address address) => _nekotonRepository
      .walletsStream
      .map((wallets) => wallets.firstWhereOrNull((w) => w.address == address))
      .mapNotNull((wallet) => wallet?.wallet?.contractState.balance)
      .map(
        (value) => Money.fromBigIntWithCurrency(
          value,
          Currencies()[transport.nativeTokenTicker]!,
        ),
      );

  Future<TonWalletState> getTonWalletState(Address address) async {
    final wallet = await _nekotonRepository.walletsStream
        .expand((e) => e)
        .firstWhere((wallets) => wallets.address == address);
    return wallet;
  }

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<List<PublicKey>?> getLocalCustodiansAsync(Address address) =>
      _nekotonRepository.getLocalCustodiansAsync(address);

  Future<UnsignedMessage> prepareTransfer({
    required List<TransactionPayloadMessage> messages,
    required Address address,
    required PublicKey publicKey,
  }) =>
      _nekotonRepository.prepareTransfer(
        address: address,
        publicKey: publicKey,
        expiration: defaultSendTimeout,
        params: messages
            .map(
              (e) => TonWalletTransferParams(
                amount: BigInt.parse(e.amount),
                destination: e.address,
                body: e.payload,
                stateInit: e.stateInit,
                bounce: defaultMessageBounce,
              ),
            )
            .toList(),
      );

  Future<BigInt> estimateFees({
    required Address address,
    required UnsignedMessage message,
  }) =>
      _nekotonRepository.estimateFees(
        address: address,
        message: message,
      );

  Future<List<TxTreeSimulationErrorItem>> simulateTransactionTree({
    required Address address,
    required UnsignedMessage message,
  }) =>
      // TODO(komarov): remove when fixed in nekoton
      transport.networkType == 'ton'
          ? Future.value([])
          : _nekotonRepository.simulateTransactionTree(
              address: address,
              message: message,
            );

  String? getSeedName(PublicKey custodian) =>
      _nekotonRepository.seedList.findSeedKey(custodian)?.name;

  void showMessage(Message message) {
    _messengerService.show(message);
  }

  Future<SignedMessage> send({
    required List<TransactionPayloadMessage> messages,
    required Address address,
    required PublicKey publicKey,
    required String password,
  }) async {
    UnsignedMessage? unsignedMessage;
    try {
      unsignedMessage = await prepareTransfer(
        address: address,
        publicKey: publicKey,
        messages: messages,
      );

      final hash = unsignedMessage.hash;
      final transport = _nekotonRepository.currentTransport.transport;
      final destination = messages.first.address;
      final ampunt = messages.fold<BigInt>(
        BigInt.zero,
        (prev, e) => prev + BigInt.parse(e.amount),
      );

      final signature = await _nekotonRepository.seedList.sign(
        data: hash,
        publicKey: publicKey,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);

      await _nekotonRepository.sendUnawaited(
        address: address,
        amount: ampunt,
        destination: repackAddress(destination),
        signedMessage: signedMessage,
      );

      return signedMessage;
    } finally {
      unsignedMessage?.dispose();
    }
  }
}
