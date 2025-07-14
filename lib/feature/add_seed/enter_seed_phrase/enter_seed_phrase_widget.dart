import 'package:app/feature/add_seed/add_seed.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class EnterSeedPhraseWidget
    extends ElementaryWidget<EnterSeedPhraseWidgetModel> {
  EnterSeedPhraseWidget({
    required bool isOnboarding,
    String? seedName,
    Key? key,
  }) : super(
          (context) => enterSeedPhraseWidgetModelFactory(
            context,
            isOnboarding: isOnboarding,
            seedName: seedName,
          ),
          key: key,
        );

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
                        allowedValues: wm.seedPhraseWordsCount,
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
                  builder: (_, tabData, seedPhraseFormat) =>
                      SeedPhraseFormatView(
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
