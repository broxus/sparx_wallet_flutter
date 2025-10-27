import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template check_seed_phrase_page}
/// Entry point to check if user wrote down seed phrase correctly.
/// {@endtemplate}
class CheckSeedPhrasePage
    extends
        InjectedElementaryParametrizedWidget<
          CheckSeedPhrasePageWidgetModel,
          CheckSeedPhraseWmParams
        > {
  /// {@macro check_seed_phrase_page}
  CheckSeedPhrasePage({required SecureString seed, String? name, super.key})
    : super(
        wmFactoryParam: CheckSeedPhraseWmParams(seed: seed, name: name),
      );

  @override
  Widget build(CheckSeedPhrasePageWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        actions: [
          CommonButton.ghost(
            padding: EdgeInsets.zero,
            text: LocaleKeys.skipWord.tr(),
            onPressed: wm.skip,
          ),
        ],
      ),
      body: EntityStateNotifierBuilder<CheckSeedPhraseData>(
        listenableEntityState: wm.screenState,
        loadingBuilder: (_, __) => const SizedBox.shrink(),
        builder: (_, data) => data == null
            ? const SizedBox.shrink()
            : CheckSeedPhraseView(
                availableAnswers: data.availableAnswers,
                userAnswers: data.userAnswers,
                currentAnswerIndex: data.currentCheckIndex,
                selectAnswer: wm.answerQuestion,
                clearAnswer: wm.clearAnswer,
              ),
      ),
    );
  }
}
