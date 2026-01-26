import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

// Errors are handled via WM/Model messaging.

/// Screen that allows user to check seed phrase for correctness.
class CheckSeedPhraseView extends StatelessWidget {
  const CheckSeedPhraseView({
    required this.availableAnswers,
    required this.userAnswers,
    required this.currentAnswerIndex,
    required this.selectAnswer,
    required this.clearAnswer,
    super.key,
  });

  final List<String> availableAnswers;
  final List<CheckSeedCorrectAnswer> userAnswers;
  final int? currentAnswerIndex;
  final ValueChanged<String> selectAnswer;
  final ValueChanged<String> clearAnswer;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.letsCheckSeedPhrase.tr(),
                      style: theme.textStyles.headingXLarge,
                    ),
                    const SizedBox(height: DimensSize.d12),
                    Text(
                      LocaleKeys.checkSeedPhraseCorrectly.tr(),
                      style: theme.textStyles.paragraphMedium,
                    ),
                    const SizedBox(height: DimensSize.d24),
                    CheckSeedAnswersWidget(
                      userAnswers: userAnswers,
                      currentIndex: currentAnswerIndex,
                      clearAnswer: clearAnswer,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DimensSize.d12),
            CheckSeedAvailableAnswersWidget(
              availableAnswers: availableAnswers,
              selectedAnswers: userAnswers.map((e) => e.word).toList(),
              selectAnswer: selectAnswer,
            ),
          ],
        ),
      ),
    );
  }
}
