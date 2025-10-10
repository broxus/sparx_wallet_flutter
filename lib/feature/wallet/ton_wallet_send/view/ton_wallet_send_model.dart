import 'package:app/app/service/connection/connection_service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@injectable
class TonWalletSendModel extends ElementaryModel
    with BleAvailabilityModelMixin {
  TonWalletSendModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._ledgerService,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final LedgerService _ledgerService;
  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Currency get currency => Currencies()[transport.nativeTokenTicker]!;

  @override
  void dispose() {
    _ledgerService.closeLedgerConnection();
    super.dispose();
  }

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<TonWalletState> getWalletState(Address address) => _nekotonRepository
      .walletsMapStream
      .mapNotNull((wallets) => wallets[address])
      .first;

  Future<UnsignedMessage> prepareTransfer({
    required Address address,
    required PublicKey publicKey,
    required Address destination,
    required BigInt amount,
    String? comment,
    String? payload,
  }) => _nekotonRepository.prepareTransfer(
    address: address,
    publicKey: publicKey,
    expiration: defaultSendTimeout,
    params: [
      TonWalletTransferParams(
        destination: repackAddress(destination),
        amount: amount,
        body:
            payload ??
            comment?.let((it) => encodeComment(it, plain: transport.isTon)),
        bounce: defaultMessageBounce,
      ),
    ],
  );

  Future<BigInt> estimateFees({
    required Address address,
    required UnsignedMessage message,
  }) => _nekotonRepository.estimateFees(address: address, message: message);

  Future<List<TxTreeSimulationErrorItem>> simulateTransactionTree({
    required Address address,
    required UnsignedMessage message,
  }) => _nekotonRepository.simulateTransactionTree(
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
    final signature = await _ledgerService.runWithLedgerIfKeyIsLedger(
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
