import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/widgets/check_seed_answers_widget.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/widgets/check_seed_available_answers_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

Future<void> showCheckPhraseDialog(
  BuildContext context,
  List<String> words,
  String address,
  VoidCallback finishedBackupCallback,
) {
  return showPrimaryBottomSheet(
    context: context,
    title: LocaleKeys.letsCheckSeedPhrase.tr(),
    subtitle: LocaleKeys.checkSeedPhraseCorrectly.tr(),
    showBackButton: true,
    content: ContentCheckPhrase(
      words: words,
      address: address,
      finishedBackupCallback: finishedBackupCallback,
    ),
  );
}

class ContentCheckPhrase extends ElementaryWidget<CheckPhraseWidgetModel> {
  const ContentCheckPhrase({
    required this.words,
    required this.address,
    required this.finishedBackupCallback,
    Key? key,
    WidgetModelFactory wmFactory = defaultCheckPhraseWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final List<String> words;
  final String address;
  final VoidCallback finishedBackupCallback;

  @override
  Widget build(CheckPhraseWidgetModel wm) {
    return EntityStateNotifierBuilder<CheckPhraseData?>(
      listenableEntityState: wm.screenState,
      builder: (context, data) {
        if (data?.availableAnswers?.isNotEmpty ?? false) {
          return Column(
            children: [
              CheckSeedAnswersWidget(
                userAnswers: data?.userAnswers ?? [],
                currentIndex: data?.currentCheckIndex ?? 0,
                clearAnswer: wm.clearAnswer,
              ),
              const SizedBox(height: DimensSizeV2.d48),
              CheckSeedAvailableAnswersWidget(
                isEnabledWidget: !(data?.isAllChosen ?? true),
                availableAnswers: data?.availableAnswers ?? [],
                selectedAnswers:
                    data?.userAnswers?.map((e) => e.word).toList() ?? [],
                selectAnswer: wm.answerQuestion,
              ),
              const SizedBox(height: DimensSizeV2.d24),
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.check.tr(),
                onPressed: data?.isAllChosen ?? false ? wm.checkPhrase : null,
              ),
              const SizedBox(height: DimensSizeV2.d8),
              LayoutBuilder(
                builder: (context, _) {
                  return PrimaryButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.skipTakeRisk.tr(),
                    onPressed: wm.clickSkip,
                  );
                },
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
