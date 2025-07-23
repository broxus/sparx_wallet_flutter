import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/http/repository/repository.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class TCSendMessageModel extends LedgerBaseModel {
  TCSendMessageModel(
    ErrorHandler errorHandler,
    AppPermissionsService permissionsService,
    MessengerService messengerService,
    this._nekotonRepository,
    this._tonRepository,
    this._ledgerService,
  ) : super(
          errorHandler: errorHandler,
          ledgerService: _ledgerService,
          permissionsService: permissionsService,
          messengerService: messengerService,
        );

  final NekotonRepository _nekotonRepository;
  final TonRepository _tonRepository;
  final LedgerService _ledgerService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Stream<Money> getBalanceStream(Address address) =>
      _nekotonRepository.walletsMapStream
          .map((wallets) => wallets[address])
          .mapNotNull((wallet) => wallet?.wallet?.contractState.balance)
          .map(
            (value) => Money.fromBigIntWithCurrency(
              value,
              Currencies()[transport.nativeTokenTicker]!,
            ),
          );

  Future<TonWalletState> getTonWalletState(Address address) async {
    final wallet = await _nekotonRepository.walletsMapStream
        .mapNotNull((wallets) => wallets[address])
        .first;
    return wallet;
  }

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<List<PublicKey>?> getLocalCustodiansAsync(Address address) =>
      _nekotonRepository.getLocalCustodiansAsync(address);

  Future<UnsignedMessage> prepareTransfer({
    required List<TransactionPayloadMessage> messages,
    required Address address,
    PublicKey? publicKey,
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
      _nekotonRepository.simulateTransactionTree(
        address: address,
        message: message,
      );

  String? getSeedName(PublicKey custodian) =>
      _nekotonRepository.seedList.findSeedKey(custodian)?.name;

  Future<SignedMessage> send({
    required List<TransactionPayloadMessage> messages,
    required Address address,
    required PublicKey publicKey,
    required SignInputAuth signInputAuth,
  }) async {
    UnsignedMessage? message;
    try {
      message = await prepareTransfer(
        address: address,
        publicKey: publicKey,
        messages: messages,
      );

      final transport = _nekotonRepository.currentTransport.transport;
      final destination = messages.first.address;
      final ampunt = messages.fold<BigInt>(
        BigInt.zero,
        (prev, e) => prev + BigInt.parse(e.amount),
      );

      final signatureId = await transport.getSignatureId();
      final signature = await _ledgerService.runWithLedger(
        interactionType: LedgerInteractionType.signTransaction,
        publicKey: publicKey,
        action: () async {
          await message!.refreshTimeout();
          return _nekotonRepository.seedList.sign(
            message: message.message,
            publicKey: publicKey,
            signInputAuth: signInputAuth,
            signatureId: signatureId,
          );
        },
      );

      final signedMessage = await message.sign(signature: signature);

      await _nekotonRepository.sendUnawaited(
        address: address,
        amount: ampunt,
        destination: repackAddress(destination),
        signedMessage: signedMessage,
      );

      return signedMessage;
    } finally {
      message?.dispose();
    }
  }

  Future<(Address, JettonRootData)> getJettonRootDetails(
    Address address,
  ) =>
      JettonWallet.getJettonRootDetailsFromJettonWallet(
        address: address,
        transport: transport.transport,
      );

  Future<Symbol> getSymbol(Address rootTokenContract) async {
    final info = await _tonRepository.getTokenInfo(
      address: rootTokenContract,
    );

    final symbol = Symbol(
      name: info.symbol ?? 'UNKNOWN',
      fullName: info.name ?? 'Unknown token',
      decimals: info.decimals ?? 0,
      rootTokenContract: info.address,
    );

    return symbol;
  }

  Future<SignInputAuthLedger> getLedgerAuthInput({
    required Address address,
    required PublicKey custodian,
    required Currency currency,
  }) async {
    final walletState = await getTonWalletState(address);

    return SignInputAuthLedger(
      wallet: walletState.wallet!.walletType,
      context: _ledgerService.prepareSignatureContext(
        PrepareSignatureContext.transfer(
          wallet: walletState.wallet!,
          asset: currency.symbol,
          decimals: currency.decimalDigits,
          custodian: custodian,
        ),
      ),
    );
  }
}
