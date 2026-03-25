import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class CheckPhraseModel extends ElementaryModel {
  CheckPhraseModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._storage,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final AppStorageService _storage;

  void showValidateError(String message) {
    handleError(message);
  }

  void setShowingBackUpFlag(String address, {required bool isSkipped}) {
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
      isSkipped,
    );
  }
}
