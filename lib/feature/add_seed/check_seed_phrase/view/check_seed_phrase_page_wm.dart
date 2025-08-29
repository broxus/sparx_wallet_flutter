import 'dart:math';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CheckSeedPhraseWmParams {
  const CheckSeedPhraseWmParams({
    required this.seed,
    this.name,
  });

  final SeedPhraseModel seed;
  final String? name;
}

class CheckSeedPhraseData {
  const CheckSeedPhraseData({
    required this.availableAnswers,
    required this.userAnswers,
    required this.currentCheckIndex,
  });

  final List<String> availableAnswers;
  final List<CheckSeedCorrectAnswer> userAnswers;
  final int? currentCheckIndex;
}

const _defaultWordsToCheckAmount = 3;
const _defaultCheckAnswersAmount = 9;

@injectable
class CheckSeedPhrasePageWidgetModel extends CustomWidgetModelParametrized<
    CheckSeedPhrasePage, CheckSeedPhrasePageModel, CheckSeedPhraseWmParams> {
  CheckSeedPhrasePageWidgetModel(super.model);

  late final screenState = createEntityNotifier<CheckSeedPhraseData>();

  late final _correctAnswers = _selectCorrectAnswers(wmParams.value.seed);
  late final List<String> _availableAnswers =
      _generateAnswerWords(_correctAnswers);
  late final List<CheckSeedCorrectAnswer> _userAnswers =
      _correctAnswers.map((e) => e.copyWith(word: '')).toList();
  int? _currentCheckIndex = 0;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    screenState.content(
      CheckSeedPhraseData(
        availableAnswers: _availableAnswers,
        userAnswers: List.of(_userAnswers),
        currentCheckIndex: _currentCheckIndex,
      ),
    );
  }

  void answerQuestion(String answer) {
    if (_currentCheckIndex == null) return;
    _userAnswers[_currentCheckIndex!] =
        _userAnswers[_currentCheckIndex!].copyWith(word: answer);
    _goNextOrValidate();
  }

  void clearAnswer(String answer) {
    final answerIndex = _userAnswers.indexWhere((a) => a.word == answer);
    if (answerIndex < 0) return;
    _userAnswers[answerIndex] = _userAnswers[answerIndex].copyWith(word: '');
    _goNextOrValidate();
  }

  void skip() {
    final params = wmParams.value;
    context.compassContinue(
      CreateSeedPasswordRouteData(
        seedPhrase: params.seed.phrase,
        name: params.name,
        type: SeedAddType.create,
      ),
    );
  }

  void _goNextOrValidate() {
    final nextIndex = _firstEmptyAnswer();
    if (nextIndex == null) {
      _validate();
    } else {
      _goNext(nextIndex);
    }
  }

  void _validate() {
    var hasError = false;
    for (var i = 0; i < _correctAnswers.length; i++) {
      if (_correctAnswers[i].word != _userAnswers[i].word) {
        hasError = true;
        break;
      }
    }
    if (hasError) {
      model.showValidateError(LocaleKeys.seedIsWrong.tr());
      for (var i = 0; i < _userAnswers.length; i++) {
        _userAnswers[i] = _userAnswers[i].copyWith(word: '');
      }
      _currentCheckIndex = 0;
      screenState.content(
        CheckSeedPhraseData(
          availableAnswers: _availableAnswers,
          userAnswers: List.of(_userAnswers),
          currentCheckIndex: _currentCheckIndex,
        ),
      );
    } else {
      final params = wmParams.value;
      context.compassContinue(
        CreateSeedPasswordRouteData(
          seedPhrase: params.seed.phrase,
          name: params.name,
          type: SeedAddType.create,
          isChecked: true,
        ),
      );
    }
  }

  void _goNext(int nextIndex) {
    _currentCheckIndex = nextIndex;
    screenState.content(
      CheckSeedPhraseData(
        availableAnswers: _availableAnswers,
        userAnswers: List.of(_userAnswers),
        currentCheckIndex: _currentCheckIndex,
      ),
    );
  }

  int? _firstEmptyAnswer() {
    for (var i = 0; i < _userAnswers.length; i++) {
      if (_userAnswers[i].word.isEmpty) return i;
    }
    return null;
  }

  static List<CheckSeedCorrectAnswer> _selectCorrectAnswers(
    SeedPhraseModel seed,
  ) {
    if (seed.isEmpty) return [];
    final rng = Random();
    final indices = <int>[];
    while (indices.length < _defaultWordsToCheckAmount) {
      final number = rng.nextInt(seed.wordsCount);
      if (indices.contains(number)) continue;
      indices.add(number);
    }
    indices.sort();
    return [
      for (final index in indices)
        CheckSeedCorrectAnswer(
          seed.words[index],
          index,
        ),
    ];
  }

  List<String> _generateAnswerWords(
    List<CheckSeedCorrectAnswer> correct,
  ) {
    final correctWords = correct.map((e) => e.word).toList();
    final dictionary = getHints(input: '');
    final answers = <String>[...correctWords];
    final random = Random();
    while (answers.length < _defaultCheckAnswersAmount) {
      final number = random.nextInt(dictionary.length);
      if (answers.contains(dictionary[number])) continue;
      answers.add(dictionary[number]);
    }
    answers
      ..shuffle()
      ..shuffle()
      ..shuffle();
    return answers;
  }
}
