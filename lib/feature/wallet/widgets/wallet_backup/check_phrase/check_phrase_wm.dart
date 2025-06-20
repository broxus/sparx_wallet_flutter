import 'dart:math';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:injectable/injectable.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/cubit/check_seed_correct_answer.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class CheckPhraseWmParams {
  const CheckPhraseWmParams({
    required this.words,
    required this.address,
    required this.finishedBackupCallback,
  });

  final List<String> words;
  final String address;
  final VoidCallback finishedBackupCallback;
}

const defaultWordsToCheckAmount = 3;
const defaultCheckAnswersAmount = 9;

//logic in this class was moved from check_seed_phrase_cubit.dart
@injectable
class CheckPhraseWidgetModel
    extends CustomWidgetModel<ContentCheckPhrase, CheckPhraseModel> {
  CheckPhraseWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final CheckPhraseWmParams _wmParams;

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  late final screenState = createEntityNotifier<CheckPhraseData>()
    ..loading(
      CheckPhraseData(
        userAnswers: userAnswers,
        availableAnswers: availableAnswers,
        currentCheckIndex: currentCheckIndex,
      ),
    );
  List<String>? availableAnswers;
  List<CheckSeedCorrectAnswer>? userAnswers;
  int currentCheckIndex = 0;
  late List<CheckSeedCorrectAnswer> _correctAnswers;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  void checkPhrase() {
    _validate();
  }

  void answerQuestion(String answer) {
    if (userAnswers != null) {
      userAnswers![currentCheckIndex] =
          userAnswers![currentCheckIndex].copyWith(word: answer);
      _checkNewAnswer();
    }
  }

  void clearAnswer(String answer) {
    if (userAnswers != null) {
      final answerIndex = userAnswers!.indexWhere((a) => a.word == answer);
      userAnswers![answerIndex] = userAnswers![answerIndex].copyWith(word: '');
      _checkNewAnswer();
    }
  }

  void clickSkip() {
    model.setShowingBackUpFlag(_wmParams.address);

    if (!isMounted) return;
    _wmParams.finishedBackupCallback();
    context
      ..compassBack() //close manual backup dialog
      ..compassBack(); //close current dialog
    showGoodJobDialog(context);
  }

  void _init() {
    _correctAnswers = _selectCorrectAnswers(_wmParams.words);
    availableAnswers = _generateAnswerWords(_correctAnswers);
    userAnswers = _correctAnswers.map((e) => e.copyWith(word: '')).toList();
    screenState.content(
      CheckPhraseData(
        userAnswers: userAnswers,
        availableAnswers: availableAnswers,
        currentCheckIndex: currentCheckIndex,
      ),
    );
  }

  void _checkNewAnswer() {
    final nextIndex = _firstEmptyAnswer();
    if (nextIndex == null) {
      screenState.content(
        CheckPhraseData(
          userAnswers: userAnswers,
          availableAnswers: availableAnswers,
          currentCheckIndex: currentCheckIndex,
          isAllChosen: true,
        ),
      );
    } else {
      _goNext(nextIndex);
    }
  }

  void _validate() {
    if (userAnswers == null) return;
    var hasError = false;
    for (var index = 0; index < _correctAnswers.length; index++) {
      if (_correctAnswers[index].word != userAnswers![index].word) {
        hasError = true;
        break;
      }
    }
    if (hasError) {
      model.showValidateError(LocaleKeys.seedIsMissing.tr());
    } else {
      // TODO(malochka): think about get rid of compassBack method
      model.setShowingBackUpFlag(_wmParams.address);
      _wmParams.finishedBackupCallback();
      context
        ..compassBack() //close manual backup
        ..compassBack(); //close check your seed phrase
      showGoodJobDialog(context);
    }
  }

  void _goNext(int nextIndex) {
    currentCheckIndex = nextIndex;
    screenState.content(
      CheckPhraseData(
        userAnswers: userAnswers,
        availableAnswers: availableAnswers,
        currentCheckIndex: currentCheckIndex,
      ),
    );
  }

  int? _firstEmptyAnswer() {
    if (userAnswers != null) {
      for (var i = 0; i < userAnswers!.length; i++) {
        if (userAnswers![i].word.isEmpty) return i;
      }
    }
    return null;
  }

  List<CheckSeedCorrectAnswer> _selectCorrectAnswers(
    List<String> phrase,
  ) {
    final rng = Random();
    final indices = <int>[];
    while (indices.length < defaultWordsToCheckAmount) {
      final number = rng.nextInt(phrase.length);
      if (indices.contains(number)) continue;
      indices.add(number);
    }
    indices.sort();
    return [
      for (final index in indices) CheckSeedCorrectAnswer(phrase[index], index),
    ];
  }

  List<String> _generateAnswerWords(
    List<CheckSeedCorrectAnswer> correct,
  ) {
    final correctWords = correct.map((e) => e.word).toList();
    final dictionary = getHints(input: '');
    final answers = <String>[...correctWords];
    final random = Random();
    while (answers.length < defaultCheckAnswersAmount) {
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
