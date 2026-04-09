import 'package:app/di/di.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/seed_words.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper method that displays [ExportSeedSavePhrase] sheet.
ModalRoute<void> exportSeedSavePhraseRoute(
  TextStyle titleTextStyle,
  TextStyle subtitleStyle,
  List<String> phrase,
) {
  return commonBottomSheetRoute(
    titleTextStyle: titleTextStyle,
    subtitleStyle: subtitleStyle,
    title: LocaleKeys.exportSeed.tr(),
    subtitle: LocaleKeys.manualBackupSubtitleDialog.tr(),
    centerTitle: true,
    centerSubtitle: true,
    body: (_, controller) => ProtectedContent(
      child: ProtectedContent(
        child: ExportSeedSavePhrase(phrase: phrase, controller: controller),
      ),
    ),
  );
}

/// Widget that shows the seed phrase that could be copied.
class ExportSeedSavePhrase extends StatelessWidget {
  const ExportSeedSavePhrase({
    required this.phrase,
    required this.controller,
    super.key,
  });

  final List<String> phrase;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            controller: controller,
            child: SeedWords(
              words: phrase,
              backgroundColor: context.themeStyleV2.colors.background2,
            ),
          ),
        ),
        const SizedBox(height: DimensSize.d24),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.copyWords.tr(),
          postfixIcon: LucideIcons.copy,
          onPressed: () {
            inject<MessengerService>().show(
              Message.successful(message: LocaleKeys.copiedExclamation.tr()),
            );
            setClipBoardData(phrase.join(' '), isSensitive: true);
          },
        ),
      ],
    );
  }
}
