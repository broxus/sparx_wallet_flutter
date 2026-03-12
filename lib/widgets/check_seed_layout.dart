import 'package:app/feature/add_seed/check_seed_phrase/data/check_seed_correct_answer.dart';
import 'package:app/feature/add_seed/check_seed_phrase/widgets/check_seed_answers_widget.dart';
import 'package:app/feature/add_seed/check_seed_phrase/widgets/check_seed_available_answers_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CheckSeedLayout extends StatelessWidget {
  const CheckSeedLayout({
    required this.availableAnswers,
    required this.userAnswers,
    required this.currentCheckIndex,
    required this.clearAnswer,
    required this.answerQuestion,
    super.key,
  });

  final List<String> availableAnswers;
  final List<CheckSeedCorrectAnswer> userAnswers;
  final int currentCheckIndex;
  final ValueChanged<String> clearAnswer;
  final ValueChanged<String> answerQuestion;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final textStyles = theme.textStyles;

    return Column(
      children: [
        Image.asset(
          Assets.images.circleCheck.path,
          width: DimensSize.d56,
          height: DimensSize.d56,
        ),
        const SizedBox(height: DimensSize.d16),
        Text(
          LocaleKeys.letsCheckSeedPhrase.tr(),
          style: textStyles.headingLarge,
        ),
        const SizedBox(height: DimensSize.d8),
        Text(
          LocaleKeys.checkSeedPhraseCorrectly.tr(),
          style: textStyles.paragraphMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSize.d24),
        CheckSeedAnswersWidget(
          userAnswers: userAnswers,
          currentIndex: currentCheckIndex,
          clearAnswer: clearAnswer,
        ),
        const SizedBox(height: DimensSize.d24),
        CheckSeedAnswersCounterWidget(
          currentIndex: currentCheckIndex,
          count: userAnswers.length,
        ),
        const SizedBox(height: DimensSize.d24),
        const Spacer(),
        CheckSeedAvailableAnswersWidget(
          availableAnswers: availableAnswers,
          selectedAnswers: userAnswers.map((e) => e.word).toList(),
          selectAnswer: answerQuestion,
        ),
        const SizedBox(height: DimensSize.d16),
      ],
    );
  }
}
