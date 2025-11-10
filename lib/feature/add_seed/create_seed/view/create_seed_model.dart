import 'package:app/app/service/secure_string_service.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/constants.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class CreateSeedModel extends ElementaryModel {
  CreateSeedModel(ErrorHandler errorHandler, this._secureStringService)
    : super(errorHandler: errorHandler);

  final SecureStringService _secureStringService;

  /// Generate a new seed phrase model
  SeedPhraseModel createSeed() {
    final seed = generateKey(accountType: defaultMnemonicType);
    return SeedPhraseModel.fromWords(seed.words);
  }

  Future<SecureString> encryptSeed(String phrase) =>
      _secureStringService.encrypt(phrase);
}
