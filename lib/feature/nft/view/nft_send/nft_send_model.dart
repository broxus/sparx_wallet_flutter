import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class NftSendModel extends LedgerBaseModel {
  NftSendModel(
    ErrorHandler errorHandler,
    AppPermissionsService permissionsService,
    MessengerService messengerService,
    this._nekotonRepository,
    this._nftService,
    this._ledgerService,
  ) : super(
          errorHandler: errorHandler,
          ledgerService: _ledgerService,
          permissionsService: permissionsService,
          messengerService: messengerService,
        );

  final NekotonRepository _nekotonRepository;
  final NftService _nftService;
  final LedgerService _ledgerService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Currency get currency => Currencies()[transport.nativeTokenTicker]!;

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<TonWalletState> getWalletState(Address address) =>
      _nekotonRepository.walletsMapStream
          .mapNotNull((wallets) => wallets[address])
          .first;

  Future<UnsignedMessage> prepareMessage({
    required Address address,
    required PublicKey publicKey,
    required Address destination,
    required BigInt amount,
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
            body: payload,
            bounce: defaultMessageBounce,
          ),
        ],
      );

  Future<InternalMessage> prepareNftTransfer({
    required Address address,
    required Address owner,
    required Address recipient,
  }) =>
      _nekotonRepository.prepareNftTransfer(
        address: repackAddress(address),
        owner: repackAddress(owner),
        recipient: repackAddress(recipient),
        sendGasTo: repackAddress(owner),
      );

  Future<InternalMessage> prepareNftTokenTransfer({
    required String id,
    required BigInt count,
    required Address collection,
    required Address owner,
    required Address recipient,
  }) =>
      _nekotonRepository.prepareNftTokenTransfer(
        id: id,
        count: count,
        collection: repackAddress(collection),
        owner: repackAddress(owner),
        recipient: repackAddress(recipient),
        remainingGasTo: repackAddress(owner),
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

  Future<NftCollection?> getCollection(Address address) =>
      _nftService.getCollection(address);

  Future<NftItem?> getNftItem({
    required Address address,
    required Address owner,
  }) =>
      _nftService.getNftItem(address: address, owner: owner);

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
