import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class SeedDetailPageModel extends ElementaryModel
    with BleAvailabilityModelMixin {
  SeedDetailPageModel(
    ErrorHandler errorHandler,
    this._currentSeedService,
    this._currentKeyService,
    this._nekotonRepository,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final CurrentSeedService _currentSeedService;
  final CurrentKeyService _currentKeyService;
  final NekotonRepository _nekotonRepository;
  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  Stream<Seed?> get currentSeed => _currentSeedService.currentSeedStream;

  Stream<PublicKey?> get currentKey => _currentKeyService.currentKeyStream;

  Stream<Set<String>> get findingExistingWallets =>
      _nekotonRepository.findingExistingWalletsStream;

  Stream<Seed?> getSeedStream(PublicKey publicKey) =>
      _nekotonRepository.seedListStream.map(
        (seedList) => seedList.findSeed(publicKey),
      );
}
