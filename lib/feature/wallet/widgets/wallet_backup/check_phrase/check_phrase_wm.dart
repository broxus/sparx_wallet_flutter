import 'dart:async';
import 'dart:math';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/secure_string_service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/check_seed_phrase/data/check_seed_correct_answer.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/check_phrase/route.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/manual_backup/route.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CheckPhraseWmParams {
  const CheckPhraseWmParams({required this.seedPhrase, required this.address});

  final SecureString seedPhrase;
  final String address;
}

const defaultWordsToCheckAmount = 3;
const defaultCheckAnswersAmount = 9;

//logic in this class was moved from check_seed_phrase_cubit.dart
@injectable
class CheckPhraseWidgetModel
    extends
        CustomWidgetModelParametrized<
          CheckPhraseScreen,
          CheckPhraseModel,
          CheckPhraseWmParams
        > {
  CheckPhraseWidgetModel(super.model);

  ColorsPaletteV2 get colors => _theme.colors;

  TextStylesV2 get textStyle => _theme.textStyles;

  ThemeStyleV2 get _theme => context.themeStyleV2;

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

  void answerQuestion(String answer) {
    if (userAnswers != null) {
      userAnswers![currentCheckIndex] = userAnswers![currentCheckIndex]
          .copyWith(word: answer);
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

  Future<void> clickSkip() async {
    final params = wmParams.value;
    model.setShowingBackUpFlag(params.address, isSkipped: true);

    if (!isMounted) return;

    await context.compassBack(false);
  }

  Future<void> _init() async {
    _correctAnswers = _selectCorrectAnswers(
      await model.getSeedWords(wmParams.value.seedPhrase),
    );
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
      _validate();
    } else {
      _goNext(nextIndex);
    }
  }

  Future<void> _validate() async {
    if (userAnswers == null) return;
    var hasError = false;
    for (var index = 0; index < _correctAnswers.length; index++) {
      if (_correctAnswers[index].word != userAnswers![index].word) {
        hasError = true;
        break;
      }
    }
    if (hasError) {
      model.showValidateError(LocaleKeys.seedIncorrectTryAgain.tr());
    } else {
      final params = wmParams.value;

      model
        ..setShowingBackUpFlag(params.address, isSkipped: false)
        ..showValidateSuccess(LocaleKeys.seedCorrect.tr());

      Future.delayed(const Duration(seconds: 2), () {
        if (!context.mounted) {
          return;
        }
        if (context.checkIsCurrentRoute<CheckPhraseRoute>()) {
          context.compassBackCount(2);
        }
      });
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

  List<CheckSeedCorrectAnswer> _selectCorrectAnswers(List<String> phrase) {
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

  List<String> _generateAnswerWords(List<CheckSeedCorrectAnswer> correct) {
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
