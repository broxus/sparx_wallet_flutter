part of 'check_seed_phrase_cubit.dart';

@freezed
sealed class CheckSeedPhraseCubitState with _$CheckSeedPhraseCubitState {
  const factory CheckSeedPhraseCubitState.initial() =
      CheckSeedPhraseCubitStateInitial;

  /// Display answer without any selections
  const factory CheckSeedPhraseCubitState.answer(
    List<String> availableAnswers,
    List<CheckSeedCorrectAnswer> userAnswers,
    int currentAnswerIndex,
  ) = CheckSeedPhraseCubitStateAnswer;

  /// Correct selection. Other selections must be blocked.
  /// Question will change automatically
  const factory CheckSeedPhraseCubitState.correct(
    List<String> availableAnswers,
    List<CheckSeedCorrectAnswer> userAnswers,
  ) = CheckSeedPhraseCubitStateCorrect;

  /// Error selection
  const factory CheckSeedPhraseCubitState.error(
    List<String> availableAnswers,
    List<CheckSeedCorrectAnswer> userAnswers,
  ) = CheckSeedPhraseCubitStateError;
}
