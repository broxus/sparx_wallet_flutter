import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@injectable
class TokenWalletSendModel extends ElementaryModel {
  TokenWalletSendModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

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

  void showMessage(Message message) => _messengerService.show(message);
}
