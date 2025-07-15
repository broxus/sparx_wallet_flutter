import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/constants.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SeedPhraseFormatView extends StatelessWidget {
  const SeedPhraseFormatView({
    required this.networkGroup,
    required this.networkType,
    required this.wordsCount,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String networkGroup;
  final NetworkType networkType;
  final int? wordsCount;
  final SeedPhraseFormat? value;
  final ValueChanged<SeedPhraseFormat>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    // Seed phrase format selector is available only for TON and HMSTR networks
    if (!networkType.isTon && networkGroup != 'hmstr_mainnet') {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: DimensSizeV2.d16,
      ),
      child: Container(
        padding: const EdgeInsets.all(DimensSizeV2.d16),
        decoration: BoxDecoration(
          border: SquircleBoxBorder(
            squircleRadius: DimensRadiusV2.radius12,
            borderSide: BorderSide(color: theme.colors.border0),
          ),
        ),
        child: SeparatedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DimensSizeV2.d12,
          children: [
            Text(_getLabel(), style: theme.textStyles.labelSmall),
            SeparatedRow(
              spacing: DimensSizeV2.d16,
              children: [
                CommonRadioInput(
                  value: SeedPhraseFormat.standard,
                  groupValue: value,
                  onChanged: onChanged,
                  child: Text(
                    _getRadioLabel(SeedPhraseFormat.standard),
                    style: theme.textStyles.labelSmall,
                  ),
                ),
                CommonRadioInput(
                  value: SeedPhraseFormat.ton,
                  groupValue: value,
                  onChanged: onChanged,
                  child: Text(
                    _getRadioLabel(SeedPhraseFormat.ton),
                    style: theme.textStyles.labelSmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRadioLabel(SeedPhraseFormat format) {
    return switch (format) {
      SeedPhraseFormat.standard => switch (wordsCount) {
          actualSeedPhraseLength => LocaleKeys.seedPhrase12FormatStandart.tr(),
          legacySeedPhraseLength => LocaleKeys.seedPhrase24FormatStandart.tr(),
          _ => '',
        },
      SeedPhraseFormat.ton => switch (wordsCount) {
          actualSeedPhraseLength => LocaleKeys.seedPhrase12FormatTON.tr(),
          legacySeedPhraseLength => LocaleKeys.seedPhrase24FormatTON.tr(),
          _ => '',
        },
    };
  }

  String _getLabel() {
    return switch (wordsCount) {
      actualSeedPhraseLength => LocaleKeys.seedPhraseFormatLabel12.tr(),
      legacySeedPhraseLength => LocaleKeys.seedPhraseFormatLabel24.tr(),
      _ => '',
    };
  }
}
