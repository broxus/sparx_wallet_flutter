import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

const _walletV5R1 = WalletType.walletV5R1();

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

  Stream<bool> getIsUnsupportedWalletTypeStram(KeyAccount account) =>
      transport.map(
        (transport) =>
            (transport.isEverscale || transport.isVenom) &&
            account.account.tonWallet.contract == _walletV5R1,
      );

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

  void hideBackupNotification(
    KeyAccount account, {
    required bool isCompleted,
  }) {
    final masterPublicKey = getMasterPublicKey(account);

    return _storageService.addValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
      !isCompleted,
    );
  }
}
