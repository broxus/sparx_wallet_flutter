import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/constants.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class CreateSeedModel extends ElementaryModel {
  CreateSeedModel(
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Generate a new seed phrase model
  SeedPhraseModel createSeed() {
    final seed = generateKey(accountType: defaultMnemonicType);
    return SeedPhraseModel.fromWords(seed.words);
  }
}
