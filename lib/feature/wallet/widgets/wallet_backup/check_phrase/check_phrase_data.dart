import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';

class CheckPhraseData {
  CheckPhraseData({
    required this.availableAnswers,
    this.userAnswers,
    this.currentCheckIndex = 0,
    this.isAllChosen = false,
  });

  final List<CheckSeedCorrectAnswer>? userAnswers;
  final List<String>? availableAnswers;
  final int currentCheckIndex;
  final bool isAllChosen;
}
