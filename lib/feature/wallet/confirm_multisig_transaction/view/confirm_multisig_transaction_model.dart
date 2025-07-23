import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class ConfirmMultisigTransactionModel extends LedgerBaseModel {
  ConfirmMultisigTransactionModel(
    ErrorHandler errorHandler,
    AppPermissionsService permissionsService,
    MessengerService messengerService,
    this._nekotonRepository,
    this._ledgerService,
  ) : super(
          errorHandler: errorHandler,
          ledgerService: _ledgerService,
          permissionsService: permissionsService,
          messengerService: messengerService,
        );

  final NekotonRepository _nekotonRepository;
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
    final signatureId = await transport.transport.getSignatureId();
    final signature = await _ledgerService.runWithLedger(
      interactionType: LedgerInteractionType.signTransaction,
      publicKey: publicKey,
      action: () async {
        return _nekotonRepository.seedList.sign(
          message: message.message,
          publicKey: publicKey,
          signInputAuth: signInputAuth,
          signatureId: signatureId,
        );
      },
    );

    final signedMessage = await message.sign(signature: signature);

    return _nekotonRepository.send(
      address: address,
      signedMessage: signedMessage,
      amount: amount,
      destination: repackAddress(destination),
    );
  }

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
