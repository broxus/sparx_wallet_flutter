import 'package:app/data/models/seed/seed_phrase_format.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/data/tab_data.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_wm.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/widgets/words.dart';
import 'package:app/feature/constants.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class EnterSeedPhrase extends ElementaryWidget<EnterSeedPhraseWidgetModel> {
  const EnterSeedPhrase({
    Key? key,
    WidgetModelFactory wmFactory = defaultEnterSeedPhraseWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(EnterSeedPhraseWidgetModel wm) {
    final theme = wm.themeStyleV2;
    final colors = wm.colors;

    return GestureDetector(
      onTap: wm.onPressedResetFocus,
      child: Scaffold(
        backgroundColor: theme.colors.background0,
        resizeToAvoidBottomInset: false,
        appBar: DefaultAppBar(
          onClosePressed: wm.onClosePressed,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.only(bottom: DimensSizeV2.d16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
            child: Column(
              children: [
                Image.asset(
                  Assets.images.seedPhraseIcon.path,
                  width: DimensSizeV2.d56,
                  height: DimensSizeV2.d56,
                ),
                const SizedBox(height: DimensSizeV2.d16),
                Text(
                  LocaleKeys.enterSeedPhrase.tr(),
                  style: theme.textStyles.headingLarge,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: DimensSizeV2.d8,
                    left: DimensSizeV2.d16,
                    right: DimensSizeV2.d16,
                  ),
                  child: PrimaryText(
                    LocaleKeys.pasteSeedIntoFirstBox.tr(),
                  ),
                ),
                if (wm.isExistBottomPadding)
                  Divider(
                    color: colors.strokePrimary,
                    height: DimensStroke.small,
                    thickness: DimensStroke.small,
                  ),
                Expanded(
                  child: StateNotifierBuilder(
                    listenableState: wm.tabState,
                    builder: (_, EnterSeedPhraseTabData? tabData) {
                      if (tabData == null) {
                        return const SizedBox.shrink();
                      }
                      return EnterSeedPhraseWords(
                        formKey: wm.formKey,
                        allowedValues: tabData.allowedValues,
                        currentValue: tabData.currentValue,
                        displayPasteButtonState: wm.displayPasteButtonState,
                        tabState: wm.tabState,
                        changeTab: wm.changeTab,
                        pastePhrase: wm.pastePhrase,
                        clearFields: wm.clearFields,
                        onSuggestions: wm.onSuggestions,
                        onSuggestionSelected: wm.onSuggestionSelected,
                        onNext: wm.nextOrConfirm,
                      );
                    },
                  ),
                ),
                SizedBox(
                  // subtract commonButtonHeight to avoid button above keyboard
                  height: wm.isExistBottomPadding
                      ? wm.bottomPadding - commonButtonHeight
                      : 0,
                ),
                DoubleSourceBuilder(
                  firstSource: wm.tabState,
                  secondSource: wm.seedPhraseFormat,
                  builder: (_, tabData, seedPhraseFormat) => _SeedPhraseFormat(
                    networkGroup: wm.networkGroup,
                    wordsCount: tabData?.currentValue,
                    value: seedPhraseFormat,
                    onChanged: wm.onSeedPhraseFormatChanged,
                  ),
                ),
                AccentButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.confirm.tr(),
                  onPressed: wm.confirm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SeedPhraseFormat extends StatelessWidget {
  const _SeedPhraseFormat({
    required this.networkGroup,
    required this.wordsCount,
    required this.value,
    required this.onChanged,
  });

  final String networkGroup;
  final int? wordsCount;
  final SeedPhraseFormat? value;
  final ValueChanged<SeedPhraseFormat>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    // Seed phrase format selector is available only for
    // TON and HMSTR network and when seed phrase length is 24
    if (wordsCount != legacySeedPhraseLength ||
        (networkGroup != 'ton' && networkGroup != 'hmstr_mainnet')) {
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
          separatorSize: DimensSizeV2.d12,
          children: [
            Text(
              LocaleKeys.seedPhraseFormatLabel.tr(),
              style: theme.textStyles.labelSmall,
            ),
            SeparatedRow(
              separatorSize: DimensSizeV2.d16,
              children: [
                CommonRadioInput(
                  value: SeedPhraseFormat.standart,
                  groupValue: value,
                  onChanged: onChanged,
                  child: Text(
                    LocaleKeys.seedPhraseFormatStandart.tr(),
                    style: theme.textStyles.labelSmall,
                  ),
                ),
                CommonRadioInput(
                  value: SeedPhraseFormat.bip39,
                  groupValue: value,
                  onChanged: onChanged,
                  child: Text(
                    LocaleKeys.seedPhraseFormatBIP39.tr(),
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
}
