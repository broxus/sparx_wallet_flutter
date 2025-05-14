import 'package:app/app/service/service.dart';
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
      transport.networkType == 'ton'
          ? Future<List<TxTreeSimulationErrorItem>>.value([])
          : _nekotonRepository.simulateTransactionTree(
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
