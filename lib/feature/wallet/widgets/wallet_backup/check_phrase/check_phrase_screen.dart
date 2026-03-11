import 'package:app/app/service/secure_string_service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/check_seed_phrase/widgets/check_seed_answers_widget.dart';
import 'package:app/feature/add_seed/check_seed_phrase/widgets/check_seed_available_answers_widget.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CheckPhraseScreen
    extends
        InjectedElementaryParametrizedWidget<
          CheckPhraseWidgetModel,
          CheckPhraseWmParams
        > {
  CheckPhraseScreen({
    required SecureString seedPhrase,
    required String address,
    super.key,
  }) : super(
         wmFactoryParam: CheckPhraseWmParams(
           seedPhrase: seedPhrase,
           address: address,
         ),
       );

  @override
  Widget build(CheckPhraseWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.colors.background0,
      appBar: DefaultAppBar(
        actions: [
          GhostButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.skip.tr(),
            onPressed: wm.clickSkip,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: EntityStateNotifierBuilder<CheckPhraseData?>(
          listenableEntityState: wm.screenState,
          builder: (context, data) {
            if (data?.availableAnswers?.isNotEmpty ?? false) {
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
                    style: wm.textStyle.headingLarge,
                  ),
                  const SizedBox(height: DimensSize.d8),
                  Text(
                    LocaleKeys.checkSeedPhraseCorrectly.tr(),
                    style: wm.textStyle.paragraphMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: DimensSize.d24),
                  CheckSeedAnswersWidget(
                    userAnswers: data?.userAnswers ?? [],
                    currentIndex: data?.currentCheckIndex ?? 0,
                    clearAnswer: wm.clearAnswer,
                  ),
                  const SizedBox(height: DimensSize.d24),
                  CheckSeedAnswersCounterWidget(
                    currentIndex: data?.currentCheckIndex ?? 0,
                    count: data?.userAnswers?.length ?? 0,
                  ),
                  const SizedBox(height: DimensSize.d24),
                  const Spacer(),
                  CheckSeedAvailableAnswersWidget(
                    availableAnswers: data?.availableAnswers ?? [],
                    selectedAnswers:
                        data?.userAnswers?.map((e) => e.word).toList() ?? [],
                    selectAnswer: wm.answerQuestion,
                  ),
                  const SizedBox(height: DimensSize.d16),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
