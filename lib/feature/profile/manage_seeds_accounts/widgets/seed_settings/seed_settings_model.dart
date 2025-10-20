import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class SeedSettingsModel extends ElementaryModel with BleAvailabilityModelMixin {
  SeedSettingsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentKeyService,
    this._ledgerService,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final LedgerService _ledgerService;
  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  PublicKey? get currentKey => _currentKeyService.currentKey;

  void changeCurrentKey(PublicKey publicKey) =>
      _currentKeyService.changeCurrentKey(publicKey);

  SeedKey? getMasterKey(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeedByAnyPublicKey(publicKey)?.masterKey;

  Future<void> triggerAddingAccounts(PublicKey publicKey) => _nekotonRepository
      .triggerAddingAccounts(publicKeys: [publicKey], workchainId: 0);

  Future<void> triggerDerivingKeys({
    required PublicKey masterKey,
    String? password,
  }) => _ledgerService.runWithLedgerIfKeyIsLedger(
    interactionType: LedgerInteractionType.getPublicKey,
    publicKey: masterKey,
    action: () => _nekotonRepository.triggerDerivingKeys(
      masterKey: masterKey,
      password: password,
      workchainId: 0,
    ),
  );
}
