import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class SeedDetailPageModel extends LedgerBaseModel {
  SeedDetailPageModel(
    ErrorHandler errorHandler,
    AppPermissionsService permissionsService,
    MessengerService messengerService,
    LedgerService ledgerService,
    this._currentSeedService,
    this._currentKeyService,
    this._nekotonRepository,
  ) : super(
          errorHandler: errorHandler,
          ledgerService: ledgerService,
          permissionsService: permissionsService,
          messengerService: messengerService,
        );

  final CurrentSeedService _currentSeedService;
  final CurrentKeyService _currentKeyService;
  final NekotonRepository _nekotonRepository;

  Stream<Seed?> get currentSeed => _currentSeedService.currentSeedStream;

  Stream<PublicKey?> get currentKey => _currentKeyService.currentKeyStream;

  Stream<Set<String>> get findingExistingWallets =>
      _nekotonRepository.findingExistingWalletsStream;

  Stream<Seed?> getSeedStream(PublicKey publicKey) =>
      _nekotonRepository.seedListStream.map(
        (seedList) => seedList.findSeed(publicKey),
      );
}
