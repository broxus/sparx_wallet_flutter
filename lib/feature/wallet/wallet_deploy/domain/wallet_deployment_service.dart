import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@singleton
class WalletDeploymentService {
  WalletDeploymentService(
    this._nekotonRepository,
  );

  final NekotonRepository _nekotonRepository;

  SignedMessage? _message;

  // ignore: use_setters_to_change_properties
  void storeSignedMessage(SignedMessage message) {
    _message = message;
  }

  void clearStoredMessage() {
    _message = null;
  }

  Future<Transaction> deploy({
    required String messageHash,
    required Address address,
    required BigInt amount,
  }) async {
    final message = _message;
    if (message == null) {
      throw StateError('No signed message stored');
    }
    if (message.hash != messageHash) {
      throw StateError('Stored message hash does not match the provided hash');
    }

    clearStoredMessage();

    return _nekotonRepository.send(
      address: address,
      signedMessage: message,
      amount: amount,
      destination: address,
    );
  }
}
