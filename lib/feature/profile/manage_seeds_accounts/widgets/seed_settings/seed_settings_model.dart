import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class SeedSettingsModel extends LedgerBaseModel {
  SeedSettingsModel(
    ErrorHandler errorHandler,
    AppPermissionsService permissionsService,
    MessengerService messengerService,
    this._nekotonRepository,
    this._currentKeyService,
    this._ledgerService,
  ) : super(
          errorHandler: errorHandler,
          ledgerService: _ledgerService,
          permissionsService: permissionsService,
          messengerService: messengerService,
        );

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final LedgerService _ledgerService;

  PublicKey? get currentKey => _currentKeyService.currentKey;

  void changeCurrentKey(PublicKey publicKey) =>
      _currentKeyService.changeCurrentKey(publicKey);

  SeedKey? getMasterKey(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeedByAnyPublicKey(publicKey)?.masterKey;

  Future<void> triggerAddingAccounts(PublicKey publicKey) =>
      _nekotonRepository.triggerAddingAccounts([publicKey]);

  Future<void> triggerDerivingKeys({
    required PublicKey masterKey,
    String? password,
  }) =>
      _ledgerService.runWithLedger(
        interactionType: LedgerInteractionType.getPublicKey,
        publicKey: masterKey,
        action: () => _nekotonRepository.triggerDerivingKeys(
          masterKey: masterKey,
          password: password,
        ),
      );
}
