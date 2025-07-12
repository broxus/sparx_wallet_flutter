import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class EnterPasswordModel extends ElementaryModel {
  EnterPasswordModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._biometryService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final BiometryService _biometryService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  bool get isBiometryEnabled => _biometryService.isEnabled;

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  void showError(String message) {
    _messengerService.show(
      Message.error(message: message),
    );
  }

  Future<bool> hasKeyPassword(PublicKey publicKey) =>
      _biometryService.hasKeyPassword(publicKey);

  Future<void> setKeyPassword({
    required PublicKey publicKey,
    required String password,
  }) =>
      _biometryService.setKeyPassword(publicKey: publicKey, password: password);

  Future<bool> checkKeyPassword({
    required PublicKey publicKey,
    required String password,
  }) async =>
      _nekotonRepository.seedList.checkKeyPassword(
        publicKey: publicKey,
        password: password,
        signatureId: await transport.transport.getSignatureId(),
      );

  /// Returns true if face biometry is available, else fingerprint.
  Future<bool> isFaceBiometry() async {
    final available = await _biometryService.getAvailableBiometry();
    return available.contains(BiometricType.face);
  }

  Future<String> getKeyPassword({
    required PublicKey publicKey,
    required String localizedReason,
  }) =>
      _biometryService.getKeyPassword(
        publicKey: publicKey,
        localizedReason: localizedReason,
      );

  Seed? findSeedByAnyPublicKey(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeedByAnyPublicKey(publicKey);
}
