import 'package:app/feature/ledger/ledger.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@injectable
class NewAccountTypeModel extends ElementaryModel
    with BleAvailabilityModelMixin {
  NewAccountTypeModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._ledgerService,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final LedgerService _ledgerService;
  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Future<Address> createAccount({
    required WalletType walletType,
    required PublicKey publicKey,
    required String? password,
    required String? name,
  }) async {
    final seedKey = await _ledgerService.runWithLedgerIfKeyIsLedger(
      interactionType: LedgerInteractionType.getPublicKey,
      publicKey: publicKey,
      action: () => _getSeedKey(
        publicKey: publicKey,
        walletType: walletType,
        password: password,
      ),
    );

    if (seedKey == null) throw Exception(LocaleKeys.createAccountError.tr());

    return seedKey.accountList.addAccount(
      walletType: walletType,
      workchain: defaultWorkchainId,
      name: name,
    );
  }

  List<WalletType> getCreatedAccountTypes(PublicKey publicKey) =>
      _nekotonRepository.seedList
          .findSeedByAnyPublicKey(publicKey)
          ?.masterKey
          .createdAccountTypes ??
      [];

  SeedKey? getMasterKey(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeedByAnyPublicKey(publicKey)?.masterKey;

  Future<SeedKey?> _getSeedKey({
    required WalletType walletType,
    required PublicKey publicKey,
    required String? password,
  }) async {
    final seed = _nekotonRepository.seedList.findSeedByAnyPublicKey(publicKey)!;

    if (!seed.masterKey.createdAccountTypes.contains(walletType)) {
      return seed.masterKey;
    }

    // legacy 24 words seed
    if (seed.masterKey.isLegacy) {
      return seed.masterKey;
    }

    for (final key in seed.subKeys) {
      if (!key.createdAccountTypes.contains(walletType)) {
        return key;
      }
    }

    final addedKeys = seed.subKeys.map((item) => item.publicKey).toSet()
      ..add(seed.publicKey);
    final stream = _nekotonRepository.getKeysToDeriveStream(
      password != null
          ? GetPublicKeysParams.derived(
              masterKey: seed.masterPublicKey,
              password: password,
              limit: 100,
              offset: 0,
            )
          : const GetPublicKeysParams.ledger(
              limit: 100,
              offset: 0,
            ),
    );

    PublicKey? derivedKey;
    var accountId = -1;

    await for (final key in stream) {
      accountId++;

      if (addedKeys.contains(key)) continue;

      final found = await TonWallet.findExistingWallets(
        transport: transport.transport,
        workchainId: defaultWorkchainId,
        publicKey: key,
        walletTypes: [walletType],
      );

      if (found.any((item) => item.isActive)) continue;

      final params = password != null
          ? DeriveKeysParams.derived(
              masterKey: seed.masterPublicKey,
              password: password,
              accountId: accountId,
            )
          : DeriveKeysParams.ledger(accountId: accountId);
      derivedKey = await _nekotonRepository.deriveKey(
        params: params,
        addActiveAccounts: false,
      );
      break;
    }

    if (derivedKey != null) {
      return _nekotonRepository.seedListStream
          .map((seedList) => seedList.findSeedKey(derivedKey!))
          .whereNotNull()
          .first;
    }

    return null;
  }
}
