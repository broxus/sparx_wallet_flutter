import 'package:app/generated/generated.dart';
import 'package:app/widgets/protected_content.dart';
import 'package:app/widgets/seed_words.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/utils/view_utils.dart';

class SeedViewLayout extends StatelessWidget {
  const SeedViewLayout({
    required this.title,
    required this.description,
    required this.wordsState,
    required this.onPressSkip,
    required this.onPressCopy,
    required this.onPressCheck,
    super.key,
  });

  final String title;
  final String description;
  final ListenableState<List<String>> wordsState;
  final VoidCallback onPressSkip;
  final VoidCallback onPressCopy;
  final VoidCallback onPressCheck;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final colors = theme.colors;
    final textStyles = theme.textStyles;

    return Scaffold(
      backgroundColor: colors.background0,
      appBar: DefaultAppBar(
        actions: [
          GhostButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.skip.tr(),
            onPressed: onPressSkip,
          ),
        ],
      ),
      body: ProtectedContent(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: Column(
            children: [
              Image.asset(
                Assets.images.seedPhraseIcon.path,
                width: DimensSize.d56,
                height: DimensSize.d56,
              ),
              if (isSmallScreenHeight)
                const SizedBox(height: DimensSize.d8)
              else
                const SizedBox(height: DimensSize.d16),
              Text(title, style: textStyles.headingLarge),
              if (isSmallScreenHeight)
                const SizedBox(height: DimensSize.d4)
              else
                const SizedBox(height: DimensSize.d8),
              Text(
                description,
                style: textStyles.paragraphMedium,
                textAlign: TextAlign.center,
              ),
              if (isSmallScreenHeight)
                const SizedBox(height: DimensSize.d12)
              else
                const SizedBox(height: DimensSize.d24),
              StateNotifierBuilder<List<String>>(
                listenableState: wordsState,
                builder: (_, words) => words == null
                    ? const SizedBox.shrink()
                    : SeedWords(words: words),
              ),
              if (!isSmallScreenHeight) const SizedBox(height: DimensSize.d24),
              GhostButton(
                buttonSize: ButtonSize.small,
                postfixIcon: LucideIcons.copy,
                title: LocaleKeys.copyWords.tr(),
                onPressed: onPressCopy,
                buttonShape: ButtonShape.pill,
              ),
              const Spacer(),
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.checkPhrasesLabel.tr(),
                postfixIcon: LucideIcons.textCursorInput,
                onPressed: onPressCheck,
              ),
              const SizedBox(height: DimensSize.d12),
            ],
          ),
        ),
      ),
    );
  }
}
