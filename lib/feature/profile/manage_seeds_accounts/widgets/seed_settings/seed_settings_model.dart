import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class SeedSettingsModel extends ElementaryModel {
  SeedSettingsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentKeyService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final MessengerService _messengerService;

  PublicKey? get currentKey => _currentKeyService.currentKey;

  void changeCurrentKey(PublicKey publicKey) =>
      _currentKeyService.changeCurrentKey(publicKey);

  SeedKey? getMasterKey(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeedByAnyPublicKey(publicKey)?.masterKey;

  Future<void> triggerAddingAccounts(PublicKey publicKey) =>
      _nekotonRepository.triggerAddingAccounts([publicKey]);

  Future<void> triggerDerivingKeys({
    required PublicKey masterKey,
    required String password,
  }) =>
      _nekotonRepository.triggerDerivingKeys(
        masterKey: masterKey,
        password: password,
      );

  void showMessage(Message message) => _messengerService.show(message);
}
