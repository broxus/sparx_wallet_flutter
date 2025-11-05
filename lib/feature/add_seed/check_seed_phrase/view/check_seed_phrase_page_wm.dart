import 'dart:math';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CheckSeedPhraseWmParams {
  const CheckSeedPhraseWmParams({required this.seed, this.name});

  final SecureString seed;
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

const _defaultCheckAnswersAmount = 9;

@injectable
class CheckSeedPhrasePageWidgetModel
    extends
        CustomWidgetModelParametrized<
          CheckSeedPhrasePage,
          CheckSeedPhrasePageModel,
          CheckSeedPhraseWmParams
        > {
  CheckSeedPhrasePageWidgetModel(super.model);

  late final screenState = createEntityNotifier<CheckSeedPhraseData>();

  late final List<CheckSeedCorrectAnswer> _correctAnswers;
  late final List<String> _availableAnswers;
  late final List<CheckSeedCorrectAnswer> _userAnswers;
  int? _currentCheckIndex = 0;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  void answerQuestion(String answer) {
    if (_currentCheckIndex == null) return;
    _userAnswers[_currentCheckIndex!] = _userAnswers[_currentCheckIndex!]
        .copyWith(word: answer);
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
        seedPhrase: params.seed,
        name: params.name,
        type: SeedAddType.create,
      ),
    );
  }

  Future<void> _init() async {
    _correctAnswers = await model.selectCorrectAnswers(wmParams.value.seed);
    _availableAnswers = _generateAnswerWords(_correctAnswers);
    _userAnswers = _correctAnswers.map((e) => e.copyWith(word: '')).toList();

    screenState.content(
      CheckSeedPhraseData(
        availableAnswers: _availableAnswers,
        userAnswers: List.of(_userAnswers),
        currentCheckIndex: _currentCheckIndex,
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
          seedPhrase: params.seed,
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

  List<String> _generateAnswerWords(List<CheckSeedCorrectAnswer> correct) {
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
