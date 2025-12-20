import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// How many keys should be displayed on one page
const derivedKeysPerPage = 5;

/// Number of pages that we be able to select.
const derivePageCount = 20;

@injectable
class DeriveKeysSheetModel extends ElementaryModel {
  DeriveKeysSheetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._ledgerService,
    this._connectionsStorageService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final LedgerService _ledgerService;
  final ConnectionsStorageService _connectionsStorageService;

  Seed? findSeed(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeed(publicKey);

  Future<List<PublicKey>> getKeysToDerive({
    required GetPublicKeysParams params,
    required PublicKey masterKey,
  }) async {
    return _ledgerService.runWithLedgerIfKeyIsLedger(
      interactionType: LedgerInteractionType.getPublicKey,
      publicKey: masterKey,
      action: () => _nekotonRepository.getKeysToDerive(params),
    );
  }

  Future<void> removeKeys(List<SeedKey> keys) =>
      _nekotonRepository.removeKeys(keys);

  Future<void> deriveKeys(Iterable<DeriveKeysParams> params) =>
      _nekotonRepository.deriveKeys(
        params: params,
        workchainId: _connectionsStorageService.currentWorkchainId ?? 0,
      );
}
