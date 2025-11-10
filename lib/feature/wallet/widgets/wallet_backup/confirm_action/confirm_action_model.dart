import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class ConfirmActionModel extends ElementaryModel {
  ConfirmActionModel(
    ErrorHandler errorHandler,
    this._biometryService,
    this._nekotonRepository,
    this._currentSeedService,
    this._messengerService,
    this._passwordService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final BiometryService _biometryService;
  final CurrentSeedService _currentSeedService;
  final MessengerService _messengerService;
  final PasswordService _passwordService;

  Seed? get currentSeed => _currentSeedService.currentSeed;

  PasswordLockState getLockState(PublicKey publicKey) =>
      _passwordService.getLockState(publicKey);

  Seed? findSeed(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeed(publicKey);

  Future<List<BiometricType>> getAvailableBiometry(PublicKey publicKey) async {
    final isBiometryEnabled = _biometryService.isEnabled;
    final hasKeyPassword = await _biometryService.hasKeyPassword(publicKey);

    if (isBiometryEnabled && hasKeyPassword) {
      return _biometryService.getAvailableBiometry();
    }

    return [];
  }

  Future<String?> requestBiometry(PublicKey publicKey) async {
    try {
      final password = await _biometryService.getKeyPassword(
        publicKey: publicKey,
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
      );

      return password;
    } catch (_) {
      return null;
    }
  }

  void showValidateError(String message) {
    _messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }

  Future<bool> checkKeyPassword({
    required PublicKey publicKey,
    required String password,
  }) async => _passwordService.checkKeyPassword(
    publicKey: publicKey,
    password: password,
    signatureId: await _nekotonRepository.currentTransport.transport
        .getSignatureId(),
  );

  void showError(String message) {
    _messengerService.show(Message.error(message: message));
  }
}
