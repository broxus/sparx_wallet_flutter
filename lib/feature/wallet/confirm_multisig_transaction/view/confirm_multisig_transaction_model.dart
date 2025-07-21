import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class ConfirmMultisigTransactionModel extends ElementaryModel {
  ConfirmMultisigTransactionModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._ledgerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final LedgerService _ledgerService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  SeedKey? getSeedKey(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeedKey(publicKey);

  Future<TonWalletState> getWalletState(Address address) =>
      _nekotonRepository.walletsMapStream
          .mapNotNull((wallets) => wallets[address])
          .first;

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

  Future<UnsignedMessage> prepareConfirmTransaction({
    required Address address,
    required PublicKey publicKey,
    required String transactionId,
  }) =>
      _nekotonRepository.prepareConfirmTransaction(
        address: address,
        publicKey: publicKey,
        transactionId: transactionId,
        expiration: defaultSendTimeout,
      );

  Future<Future<Transaction>> sendMessage({
    required Address address,
    required Address destination,
    required PublicKey publicKey,
    required UnsignedMessage message,
    required BigInt amount,
    required SignInputAuth signInputAuth,
  }) async {
    final signature = await _nekotonRepository.seedList.sign(
      message: message.message,
      publicKey: publicKey,
      signInputAuth: signInputAuth,
      signatureId: await transport.transport.getSignatureId(),
    );

    await message.refreshTimeout();
    final signedMessage = await message.sign(signature: signature);

    return _nekotonRepository.send(
      address: address,
      signedMessage: signedMessage,
      amount: amount,
      destination: repackAddress(destination),
    );
  }

  void showMessage(Message message) => _messengerService.show(message);

  SignInputAuthLedger getLedgerAuthInput({
    required TonWallet wallet,
    required Currency currency,
  }) {
    return SignInputAuthLedger(
      wallet: wallet.walletType,
      context: _ledgerService.prepareSignatureContext(
        PrepareSignatureContext.confirm(
          wallet: wallet,
          asset: currency.symbol,
          decimals: currency.decimalDigits,
        ),
      ),
    );
  }
}
