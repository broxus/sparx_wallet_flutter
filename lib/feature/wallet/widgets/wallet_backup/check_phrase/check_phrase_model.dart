import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/constants.dart';

@injectable
class CheckPhraseModel extends ElementaryModel {
  CheckPhraseModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._secureStringService,
    this._currentAccountsService,
    this._storage,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final SecureStringService _secureStringService;
  final CurrentAccountsService _currentAccountsService;
  final AppStorageService _storage;

  Future<List<String>> getSeedWords(SecureString secureString) async {
    return (await _secureStringService.decrypt(secureString)).split(' ');
  }

  void showValidateSuccess(String message) {
    _messengerService.show(Message.successful(message: message));
  }

  void showValidateError(String message) {
    _messengerService.show(Message.error(message: message));
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
