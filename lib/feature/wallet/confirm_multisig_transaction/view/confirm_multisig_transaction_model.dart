import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@injectable
class ConfirmMultisigTransactionModel extends ElementaryModel {
  ConfirmMultisigTransactionModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

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
    required String password,
  }) async {
    final hash = message.hash;

    final signature = await _nekotonRepository.seedList.sign(
      data: hash,
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
