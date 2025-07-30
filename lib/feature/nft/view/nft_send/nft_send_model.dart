import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@injectable
class NftSendModel extends ElementaryModel {
  NftSendModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._nftService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final NftService _nftService;

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
    required String password,
    required Address destination,
    required BigInt amount,
  }) async {
    final signature = await _nekotonRepository.seedList.sign(
      data: message.hash,
      publicKey: publicKey,
      password: password,
      signatureId: await transport.transport.getSignatureId(),
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

  void showMessage(Message message) => _messengerService.show(message);
}
