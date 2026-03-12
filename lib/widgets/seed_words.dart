import 'package:flutter/material.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

class SeedWords extends StatelessWidget {
  const SeedWords({required this.words, this.backgroundColor, super.key});

  final List<String> words;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final lengthHalf = words.length ~/ 2;
    final theme = context.themeStyleV2;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.background1,
        borderRadius: BorderRadius.circular(DimensRadius.radius16),
      ),
      padding: const EdgeInsets.all(DimensSize.d32),
      child: Row(
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
                    child: _Word(
                      theme: theme,
                      word: words[index],
                      index: index,
                    ),
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
                    child: _Word(
                      theme: theme,
                      word: words[index],
                      index: index,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
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
