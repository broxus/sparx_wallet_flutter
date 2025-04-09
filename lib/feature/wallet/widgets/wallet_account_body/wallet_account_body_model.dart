import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class WalletAccountBodyModel extends ElementaryModel {
  WalletAccountBodyModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final AppStorageService _storageService;

  late final AppStorageService storageService = _storageService;

  Stream<TransportStrategy> get transport =>
      _nekotonRepository.currentTransportStream;

  Stream<T?> getValueStream<T>(StorageKey key) =>
      _storageService.getValueStream<T>(key);

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

  void hideBackupNotification(KeyAccount account) {
    final masterPublicKey = getMasterPublicKey(account);

    return _storageService.addValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
      false,
    );
  }
}
