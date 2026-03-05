import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class ManualBackUpModel extends ElementaryModel {
  ManualBackUpModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._storage,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final AppStorageService _storage;

  void setShowingBackUpFlag(String address) {
    final account = _nekotonRepository.accountsStorage.accounts
        .firstWhereOrNull((item) => item.address.address == address);
    final masterPublicKey = account?.let(
      (account) => _nekotonRepository.seedList
          .findSeedByAnyPublicKey(account.publicKey)
          ?.masterPublicKey,
    );

    if (masterPublicKey == null) return;

    _storage.addValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
      true,
    );
  }

  void showMessageAboutCopy() {
    _messengerService.showSuccessful(LocaleKeys.copiedExclamation.tr());
  }
}
