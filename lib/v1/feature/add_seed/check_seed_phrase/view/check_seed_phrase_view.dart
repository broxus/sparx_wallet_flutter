import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _errorDisplayDuration = Duration(seconds: 2);
const _errorDelayDuration = Duration(seconds: 3);

/// Screen that allows user to check seed phrase for correctness.
class CheckSeedPhraseView extends StatelessWidget {
  const CheckSeedPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSizeV2.d24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
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
                    const SizedBox(height: DimensSizeV2.d12),
                    Text(
                      LocaleKeys.checkSeedPhraseCorrectly.tr(),
                      style: theme.textStyles.paragraphMedium,
                    ),
                    const SizedBox(height: DimensSizeV2.d24),
                    BlocConsumer<CheckSeedPhraseCubit,
                        CheckSeedPhraseCubitState>(
                      listener: (context, state) {
                        if (state is CheckSeedPhraseCubitStateError) {
                          inject<MessengerService>().show(
                            Message.error(
                              message: LocaleKeys.seedIsWrong.tr(),
                              duration: _errorDisplayDuration,
                              debounceTime: _errorDelayDuration,
                            ),
                          );
                        }
                      },
                      builder: (context, state) => switch (state) {
                        CheckSeedPhraseCubitStateInitial() => Container(),
                        CheckSeedPhraseCubitStateAnswer(
                          :final availableAnswers,
                          :final userAnswers,
                          :final currentAnswerIndex
                        ) =>
                          _buildAnswers(
                            availableAnswers,
                            userAnswers,
                            currentIndex: currentAnswerIndex,
                          ),
                        CheckSeedPhraseCubitStateCorrect(
                          :final availableAnswers,
                          :final userAnswers
                        ) =>
                          _buildAnswers(availableAnswers, userAnswers),
                        CheckSeedPhraseCubitStateError(
                          :final availableAnswers,
                          :final userAnswers
                        ) =>
                          _buildAnswers(availableAnswers, userAnswers),
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DimensSizeV2.d12),
            BlocBuilder<CheckSeedPhraseCubit, CheckSeedPhraseCubitState>(
              builder: (context, state) => switch (state) {
                CheckSeedPhraseCubitStateInitial() => Container(),
                CheckSeedPhraseCubitStateAnswer(
                  :final availableAnswers,
                  :final userAnswers,
                ) =>
                  _buildCheckAnswers(availableAnswers, userAnswers),
                CheckSeedPhraseCubitStateCorrect(
                  :final availableAnswers,
                  :final userAnswers
                ) =>
                  _buildCheckAnswers(availableAnswers, userAnswers),
                CheckSeedPhraseCubitStateError(
                  :final availableAnswers,
                  :final userAnswers
                ) =>
                  _buildCheckAnswers(availableAnswers, userAnswers),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswers(
    List<String> _,
    List<CheckSeedCorrectAnswer> userAnswers, {
    int? currentIndex,
  }) {
    return Builder(
      builder: (context) {
        final cubit = context.read<CheckSeedPhraseCubit>();

        return CheckSeedAnswersWidget(
          userAnswers: userAnswers,
          currentIndex: currentIndex,
          clearAnswer: cubit.clearAnswer,
        );
      },
    );
  }

  Widget _buildCheckAnswers(
    List<String> available,
    List<CheckSeedCorrectAnswer> userAnswers,
  ) {
    return Builder(
      builder: (context) {
        final cubit = context.read<CheckSeedPhraseCubit>();

        return CheckSeedAvailableAnswersWidget(
          availableAnswers: available,
          selectedAnswers: userAnswers.map((e) => e.word).toList(),
          selectAnswer: cubit.answerQuestion,
        );
      },
    );
  }
}
