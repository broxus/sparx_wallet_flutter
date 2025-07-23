import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class TokenWalletSendModel extends LedgerBaseModel {
  TokenWalletSendModel(
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

  Currency get currency => Currencies()[transport.nativeTokenTicker]!;

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<TonWalletState> getWalletState(Address address) =>
      _nekotonRepository.walletsMapStream
          .mapNotNull((wallets) => wallets[address])
          .first;

  Future<TokenWalletState> getTokenWalletState({
    required Address owner,
    required Address rootTokenContract,
  }) =>
      _nekotonRepository.tokenWalletsStream.expand((e) => e).firstWhere(
            (wallet) =>
                wallet.owner == owner &&
                wallet.rootTokenContract == rootTokenContract,
          );

  Future<(InternalMessage, UnsignedMessage)> prepareTransfer({
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
      payload: comment?.let((it) => encodeComment(it, plain: transport.isTon)),
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

    return (internalMessage, unsignedMessage);
  }

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
    final signatureId = await transport.transport.getSignatureId();
    final signature = await _ledgerService.runWithLedger(
      interactionType: LedgerInteractionType.signTransaction,
      publicKey: publicKey,
      action: () async {
        await message.refreshTimeout();
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
    required GenericTokenWallet tokenWallet,
    required PublicKey custodian,
  }) {
    return SignInputAuthLedger(
      wallet: wallet.walletType,
      context: _ledgerService.prepareSignatureContext(
        PrepareSignatureContext.transfer(
          wallet: wallet,
          asset: tokenWallet.currency.symbol,
          decimals: tokenWallet.currency.decimalDigits,
          custodian: custodian,
        ),
      ),
    );
  }
}
