import 'package:app/app/service/secure_string_service.dart';
import 'package:app/feature/constants.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class CreateSeedModel extends ElementaryModel {
  CreateSeedModel(
    ErrorHandler errorHandler,
    this._secureStringService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final SecureStringService _secureStringService;
  final MessengerService _messengerService;

  /// Generate a new seed phrase
  List<String> createSeed() {
    final seed = generateKey(accountType: defaultMnemonicType);

    return seed.words;
  }

  Future<SecureString> encryptSeed(String phrase) =>
      _secureStringService.encrypt(phrase);

  void showMessageAboutCopy() {
    _messengerService.show(
      Message.successful(message: LocaleKeys.copiedExclamation.tr()),
    );
  }
}
