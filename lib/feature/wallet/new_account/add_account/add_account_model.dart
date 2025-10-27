import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class AddAccountModel extends ElementaryModel with BleAvailabilityModelMixin {
  AddAccountModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentSeedService,
    this._delegate,
    this._secureStringService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentSeedService _currentSeedService;
  final BleAvailabilityModelDelegate _delegate;
  final SecureStringService _secureStringService;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  Stream<List<Seed>> get seedWithAccounts =>
      _nekotonRepository.seedListStream.map((seedList) => seedList.seeds);

  Stream<Seed?> get currentAccount => _currentSeedService.currentSeedStream;

  Future<SecureString> encryptSeed(String phrase) =>
      _secureStringService.encrypt(phrase);
}
