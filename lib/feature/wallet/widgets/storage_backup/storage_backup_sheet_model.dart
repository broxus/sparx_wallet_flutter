import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class StorageBackupSheetModel extends ElementaryModel {
  StorageBackupSheetModel(
    ErrorHandler errorHandler,
    this._storageBackupService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final StorageBackupService _storageBackupService;
  final MessengerService _messengerService;

  Future<void> backup(String password) =>
      _storageBackupService.backup(password);

  void showSuccess() =>
      _messengerService.showSuccessful(LocaleKeys.storageBackupSuccess.tr());

  void showError() =>
      _messengerService.showError(LocaleKeys.storageBackupError.tr());
}
