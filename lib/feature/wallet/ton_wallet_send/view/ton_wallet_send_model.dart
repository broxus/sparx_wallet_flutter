import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class TonWalletSendModel extends LedgerBaseModel {
  TonWalletSendModel(
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

  @override
  void dispose() {
    _ledgerService.closeLedgerConnection();
    super.dispose();
  }

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
    final signatureId = await transport.transport.getSignatureId();
    final signature = await _ledgerService.runWithLedger(
      interactionType: LedgerInteractionType.signTransaction,
      publicKey: publicKey,
      action: () => _nekotonRepository.seedList.sign(
        message: message.message,
        publicKey: publicKey,
        signInputAuth: signInputAuth,
        signatureId: signatureId,
      ),
    );

    // await message.refreshTimeout();
    final signedMessage = await message.sign(signature: signature);

    return _nekotonRepository.send(
      address: address,
      signedMessage: signedMessage,
      amount: amount,
      destination: repackAddress(destination),
    );
  }

  Future<SignInputAuthLedger> getLedgerAuthInput({
    required Address address,
    required PublicKey custodian,
  }) async {
    final walletState = await _nekotonRepository.getWallet(address);

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
