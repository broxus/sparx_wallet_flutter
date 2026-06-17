import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/feature/onboarding/screen/restore_backup/restore_backup_screen.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _timeout = Duration(seconds: 5);

/// [ElementaryModel] for [RestoreBackupScreen]
@injectable
class RestoreBackupScreenModel extends ElementaryModel {
  RestoreBackupScreenModel(
    ErrorHandler errorHandler,
    this._storageBackupService,
    this._messengerService,
    this._nekotonRepository,
    this._currentKeyService,
    this._currentAccountService,
  ) : super(errorHandler: errorHandler);

  final StorageBackupService _storageBackupService;
  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final CurrentAccountsService _currentAccountService;

  Future<void> restore(String password) async {
    await _storageBackupService.restore(password);

    await _nekotonRepository.keyStore.reloadKeystore();
    await _nekotonRepository.accountsStorage.reload();

    // Wait for the seed list to be updated after restore
    await _nekotonRepository.seedListStream
        .firstWhere((seedList) => seedList.seeds.isNotEmpty)
        .timeout(_timeout);

    final accounts = _nekotonRepository.allVisibleAccounts;
    final account =
        accounts.firstWhereOrNull((account) => !account.isExternal) ??
        accounts.firstOrNull;

    if (account == null) throw StateError('No accounts found after restore');

    _currentKeyService.changeCurrentKey(account.publicKey);

    // Wait for the current account to be updated after restore
    await _currentAccountService.currentActiveAccountStream
        .firstWhere((account) => account != null)
        .timeout(_timeout);

    await _storageBackupService.deleteBackupFile();
  }

  void showSuccess() =>
      _messengerService.showSuccessful(LocaleKeys.restoreBackupSuccess.tr());

  void showError() =>
      _messengerService.showError(LocaleKeys.restoreBackupError.tr());
}
