import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class WalletAccountBodyModel extends ElementaryModel {
  WalletAccountBodyModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final AppStorageService _storageService;

  Stream<TransportStrategy> get transport =>
      _nekotonRepository.currentTransportStream;

  Stream<bool> getShowingManualBackupBadgeStream(KeyAccount account) =>
      _storageService
          .getValueStream<bool>(
            StorageKey.showingManualBackupBadge(
              getMasterPublicKey(account).publicKey,
            ),
          )
          .map((isShowingBackup) => isShowingBackup ?? true);

  Stream<bool> getIsUnsupportedWalletTypeStream(KeyAccount account) =>
      transport.map(
        (transport) =>
            (transport.isEverscale || transport.isVenom) &&
            account.account.tonWallet.contract is WalletTypeWalletV5R1,
      );

  /// Returns true if current public key is not a custodian of the external
  /// wallet (invalid external account)
  Stream<bool> getIsInvalidExternalAccountStream(KeyAccount account) =>
      !account.isExternal
      ? Stream.value(false)
      : _getWalletStream(account.address).map((state) {
          final custodians = state?.wallet?.custodians ?? [];
          return !custodians.contains(account.publicKey);
        });

  PublicKey getMasterPublicKey(KeyAccount account) {
    final masterPublicKey = _nekotonRepository.seedList
        .findSeedByAnyPublicKey(account.publicKey)
        ?.masterPublicKey;

    if (masterPublicKey == null) throw Exception('Invalid app state');

    return masterPublicKey;
  }

  bool? isShowingBadge(KeyAccount account) {
    final masterPublicKey = _nekotonRepository.seedList
        .findSeedByAnyPublicKey(account.publicKey)
        ?.masterPublicKey;

    if (masterPublicKey == null) return null;

    return _storageService.getValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
    );
  }

  Stream<TonWalletState?> _getWalletStream(Address address) =>
      _nekotonRepository.walletsMapStream
          .map((wallets) => wallets[address])
          .distinct();
}
