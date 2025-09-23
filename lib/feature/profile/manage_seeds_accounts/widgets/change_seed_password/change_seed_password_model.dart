import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class ChangeSeedPasswordModel extends ElementaryModel {
  ChangeSeedPasswordModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._biometryService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final BiometryService _biometryService;
  final MessengerService _messengerService;

  Future<void> changePassword({
    required PublicKey publicKey,
    required String oldPassword,
    required String newPassword,
  }) async {
    final seed = _nekotonRepository.seedList.findSeed(publicKey);
    if (seed == null) {
      throw StateError('Seed not found for provided public key');
    }

    await seed.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    await _biometryService.updatePasswordIfPossible(
      publicKey: publicKey,
      newPassword: newPassword,
    );
  }

  void showMessage(Message message) => _messengerService.show(message);
}
