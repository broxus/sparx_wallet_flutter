import 'dart:math';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

const _defaultWordsToCheckAmount = 3;

@injectable
class CheckSeedPhrasePageModel extends ElementaryModel {
  CheckSeedPhrasePageModel(ErrorHandler errorHandler, this._secureStringService)
    : super(errorHandler: errorHandler);

  final SecureStringService _secureStringService;

  void showValidateError(String message) {
    handleError(message);
  }

  Future<List<CheckSeedCorrectAnswer>> selectCorrectAnswers(
    SecureString seed,
  ) async {
    final seedPhrase = SeedPhraseModel(
      await _secureStringService.decrypt(seed),
    );

    if (seedPhrase.isEmpty) return [];
    final rng = Random();
    final indices = <int>[];
    while (indices.length < _defaultWordsToCheckAmount) {
      final number = rng.nextInt(seedPhrase.wordsCount);
      if (indices.contains(number)) continue;
      indices.add(number);
    }
    indices.sort();
    return [
      for (final index in indices)
        CheckSeedCorrectAnswer(seedPhrase.words[index], index),
    ];
  }
}
