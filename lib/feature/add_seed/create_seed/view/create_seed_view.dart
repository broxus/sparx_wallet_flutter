import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/bottom_space.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Callback that calls if user taps skip checking or check phrase.
typedef CreateSeedCompleteCallback = ValueChanged<SeedPhraseModel>;

/// {@template create_seed_view}
/// Widget that allows user to create random seed phrase, copy it and check
/// {@endtemplate}
class CreateSeedView extends StatelessWidget {
  /// {@macro create_seed_view}
  const CreateSeedView({
    required this.seed,
    required this.isCopied,
    required this.onCopy,
    required this.onCheck,
    required this.onSkip,
    super.key,
  });

  final SeedPhraseModel seed;
  final bool isCopied;
  final VoidCallback onCopy;
  final CreateSeedCompleteCallback onCheck;
  final CreateSeedCompleteCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.saveSeedPhrase.tr(),
                      style: theme.textStyles.headingXLarge,
                    ),
                    const SizedBox(height: DimensSizeV2.d12),
                    Text(
                      LocaleKeys.saveSeedWarning.tr(),
                      style: theme.textStyles.paragraphMedium,
                    ),
                    const SizedBox(height: DimensSizeV2.d24),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _WordsField(seed: seed),
                        const SizedBox(height: DimensSizeV2.d4),
                        _CopyButton(copied: isCopied, onCopy: onCopy),
                      ],
                    ),
                    const SizedBox(height: DimensSizeV2.d8),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                AccentButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.checkSeedPhrase.tr(),
                  onPressed: () => onCheck(seed),
                ),
                const SizedBox(height: DimensSizeV2.d8),
                PrimaryButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.skipTakeRisk.tr(),
                  onPressed: () => onSkip(seed),
                ),
                const BottomSpace(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WordsField extends StatelessWidget {
  const _WordsField({required this.seed});

  final SeedPhraseModel seed;

  @override
  Widget build(BuildContext context) {
    final lengthHalf = seed.wordsCount ~/ 2;

    return SeparatedRow(
      children: [
        Expanded(
          child: SeparatedColumn(
            children: seed.words
                .getRange(0, lengthHalf)
                .mapIndexed(
                  (i, word) =>
                      _TextPair(key: ValueKey(i), word: word, index: i + 1),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: SeparatedColumn(
            children: seed.words
                .getRange(lengthHalf, seed.wordsCount)
                .mapIndexed(
                  (i, word) => _TextPair(
                    key: ValueKey(i + lengthHalf),
                    word: word,
                    index: i + lengthHalf + 1,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _TextPair extends StatelessWidget {
  const _TextPair({required this.word, required this.index, super.key});

  static final _format = NumberFormat('0');

  final String word;
  final int index;

  @override
  Widget build(BuildContext context) {
    final indexText = _format.format(index);

    return IgnorePointer(
      child: PrimaryTextField(
        labelText: indexText,
        textEditingController: TextEditingController(text: word),
        sizeType: PrimaryTextFieldSizeType.medium,
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  const _CopyButton({required this.copied, required this.onCopy});

  final bool copied;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    if (copied) {
      return GhostButton(
        buttonShape: ButtonShape.pill,
        buttonSize: ButtonSize.small,
        postfixIcon: LucideIcons.checkCheck,
        title: LocaleKeys.copiedExclamation.tr(),
        onPressed: () {},
      );
    }

    return GhostButton(
      buttonSize: ButtonSize.small,
      postfixIcon: LucideIcons.copy,
      title: LocaleKeys.copyWords.tr(),
      onPressed: onCopy,
      buttonShape: ButtonShape.pill,
    );
  }
}
