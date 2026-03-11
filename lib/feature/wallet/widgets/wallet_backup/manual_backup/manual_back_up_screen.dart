import 'package:app/app/service/secure_string_service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ManualBackupScreen
    extends
        InjectedElementaryParametrizedWidget<
          ManualBackUpWidgetModel,
          ManualBackUpWmParams
        > {
  ManualBackupScreen({
    required SecureString seedPhrase,
    required String address,
    super.key,
  }) : super(
         wmFactoryParam: ManualBackUpWmParams(
           seedPhrase: seedPhrase,
           address: address,
         ),
       );

  @override
  Widget build(ManualBackUpWidgetModel wm) {
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
      body: ProtectedContent(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: Column(
            children: [
              const SizedBox(height: DimensSize.d16),
              Text(
                LocaleKeys.manualBackupTitleDialog.tr(),
                style: wm.textStyle.headingLarge,
              ),
              const SizedBox(height: DimensSize.d8),
              Text(
                LocaleKeys.manualBackupSubtitleDialog.tr(),
                style: wm.textStyle.paragraphMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DimensSize.d24),
              Container(
                decoration: BoxDecoration(
                  color: wm.colors.background1,
                  borderRadius: BorderRadius.circular(DimensRadius.radius16),
                ),
                padding: const EdgeInsets.all(DimensSize.d32),
                child: StateNotifierBuilder<List<String>>(
                  listenableState: wm.wordsState,
                  builder: (_, words) => words == null
                      ? const SizedBox.shrink()
                      : _ListWords(words),
                ),
              ),
              const SizedBox(height: DimensSize.d24),
              EntityStateNotifierBuilder<ManualBackUpData?>(
                listenableEntityState: wm.screenState,
                builder: (context, data) {
                  return GhostButton(
                    buttonSize: ButtonSize.small,
                    postfixIcon: LucideIcons.copy,
                    title: LocaleKeys.copyWords.tr(),
                    onPressed: wm.copySeed,
                    buttonShape: ButtonShape.pill,
                  );
                },
              ),
              const Spacer(),
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.checkPhrasesLabel.tr(),
                postfixIcon: LucideIcons.textCursorInput,
                onPressed: wm.clickCheckPhrase,
              ),
              const SizedBox(height: DimensSize.d12)
            ],
          ),
        ),
      ),
    );
  }
}

class _ListWords extends StatelessWidget {
  const _ListWords(this.words);

  final List<String> words;

  @override
  Widget build(BuildContext context) {
    final lengthHalf = words.length ~/ 2;
    final theme = context.themeStyleV2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              for (int index = 0; index < lengthHalf; index++)
                Padding(
                  //add padding between rows
                  padding: index != lengthHalf - 1
                      ? const EdgeInsets.only(bottom: DimensSize.d12)
                      : EdgeInsets.zero,
                  child: _Word(theme: theme, word: words[index], index: index),
                ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              for (int index = lengthHalf; index < words.length; index++)
                Padding(
                  padding: index != words.length - 1
                      ? const EdgeInsets.only(bottom: DimensSize.d12)
                      : EdgeInsets.zero,
                  child: _Word(theme: theme, word: words[index], index: index),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Word extends StatelessWidget {
  const _Word({required this.theme, required this.word, required this.index});

  final ThemeStyleV2 theme;
  final String word;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${index + 1}',
          style: theme.textStyles.labelSmall.copyWith(
            color: theme.colors.content3,
          ),
        ),
        const SizedBox(width: DimensSize.d8),
        Text(
          word,
          style: theme.textStyles.labelSmall.copyWith(
            color: theme.colors.content0,
          ),
        ),
      ],
    );
  }
}
