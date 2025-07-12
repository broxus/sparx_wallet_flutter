import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class TonWalletSendModel extends ElementaryModel {
  TonWalletSendModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._ledgerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final LedgerService _ledgerService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Currency get currency => Currencies()[transport.nativeTokenTicker]!;

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<TonWalletState> getWalletState(Address address) =>
      _nekotonRepository.walletsMapStream
          .mapNotNull((wallets) => wallets[address])
          .first;

  Future<UnsignedMessage> prepareTransfer({
    required Address address,
    required PublicKey publicKey,
    required Address destination,
    required BigInt amount,
    String? comment,
    String? payload,
  }) =>
      _nekotonRepository.prepareTransfer(
        address: address,
        publicKey: publicKey,
        expiration: defaultSendTimeout,
        params: [
          TonWalletTransferParams(
            destination: repackAddress(destination),
            amount: amount,
            body: payload ??
                comment?.let((it) => encodeComment(it, plain: transport.isTon)),
            bounce: defaultMessageBounce,
          ),
        ],
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

  Future<Future<Transaction>> sendMessage({
    required Address address,
    required PublicKey publicKey,
    required UnsignedMessage message,
    required SignInputAuth signInputAuth,
    required Address destination,
    required BigInt amount,
  }) async {
    final walletState = await _nekotonRepository.getWallet(address);
    final signature = await _nekotonRepository.seedList.sign(
      message: message.message,
      publicKey: publicKey,
      signInputAuth: _prepareAuth(
        signInputAuth: signInputAuth,
        publicKey: publicKey,
        wallet: walletState.wallet!,
      ),
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

  SignInputAuth _prepareAuth({
    required SignInputAuth signInputAuth,
    required PublicKey publicKey,
    required TonWallet wallet,
  }) =>
      switch (signInputAuth) {
        SignInputAuthPassword() => signInputAuth,
        SignInputAuthLedger() => signInputAuth.copyWith(
            context: _ledgerService.prepareSignatureContext(
              PrepareSignatureContext.transfer(
                wallet: wallet,
                asset: currency.symbol,
                decimals: currency.decimalDigits,
                custodian: publicKey,
              ),
            ),
          ),
      };
}
