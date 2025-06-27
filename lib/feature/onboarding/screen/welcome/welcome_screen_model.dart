import 'package:app/app/service/service.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [WelcomeScreen]
@injectable
class WelcomeScreenModel extends ElementaryModel {
  WelcomeScreenModel(
    ErrorHandler errorHandler,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final AppStorageService _storageService;

  void saveUserNew({required bool userWithNewWallet}) => _storageService
      .addValue(StorageKey.userWithNewWallet(), userWithNewWallet);
}
