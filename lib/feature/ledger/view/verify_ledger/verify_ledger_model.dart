import 'package:app/feature/ledger/ledger.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class VerifyLedgerModel extends ElementaryModel with BleAvailabilityModelMixin {
  VerifyLedgerModel(
    ErrorHandler errorHandler,
    this._ledgerService,
    this._nekotonRepository,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final LedgerService _ledgerService;
  final NekotonRepository _nekotonRepository;
  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  @override
  void dispose() {
    super.dispose();
    _ledgerService.currentInteraction?.dispose();
  }

  Stream<LedgerInteraction> get interactionStream =>
      _ledgerService.interactionStream.where(
        (e) => e.interactionType == LedgerInteractionType.getAddress,
      );

  Future<void> verify(KeyAccount account) async {
    final seedKey = _nekotonRepository.seedList.findSeedKey(account.publicKey);
    if (seedKey == null) {
      throw StateError(
        'Seed key not found for public key: ${account.publicKey}',
      );
    }

    return _ledgerService.runWithLedgerIfKeyIsLedger(
      showBottomSheet: false,
      interactionType: LedgerInteractionType.getAddress,
      publicKey: account.publicKey,
      action: () async => _ledgerService.appInterface!.getAddress(
        accountId: seedKey.key.accountId,
        wallet: getContractTypeNumber(account.account.tonWallet.contract),
      ),
    );
  }
}
