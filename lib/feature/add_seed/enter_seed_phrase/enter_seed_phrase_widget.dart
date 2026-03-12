import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/add_seed.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EnterSeedPhraseWidget
    extends
        InjectedElementaryParametrizedWidget<
          EnterSeedPhraseWidgetModel,
          EnterSeedWmParams
        > {
  EnterSeedPhraseWidget({
    required bool isOnboarding,
    String? seedName,
    super.key,
  }) : super(
         wmFactoryParam: EnterSeedWmParams(
           isOnboarding: isOnboarding,
           seedName: seedName,
         ),
       );

  @override
  Widget build(EnterSeedPhraseWidgetModel wm) {
    final theme = wm.themeStyleV2;
    return GestureDetector(
      onTap: wm.onPressedResetFocus,
      child: Scaffold(
        backgroundColor: theme.colors.background0,
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          controller: wm.screenScrollController,
          slivers: [
            const SliverToBoxAdapter(child: DefaultAppBar()),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
              sliver: SliverList.list(
                children: [
                  Align(
                    child: Text(
                      LocaleKeys.enterSeedPhrase.tr(),
                      style: theme.textStyles.headingLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: DimensSize.d8,
                      left: DimensSize.d16,
                      right: DimensSize.d16,
                    ),
                    child: PrimaryText(LocaleKeys.pasteSeedIntoFirstBox.tr()),
                  ),
                  StateNotifierBuilder(
                    listenableState: wm.tabState,
                    builder: (_, EnterSeedPhraseTabData? tabData) {
                      if (tabData == null) {
                        return const SizedBox.shrink();
                      }
                      return EnterSeedPhraseWords(
                        formKey: wm.formKey,
                        renderManager: wm.renderManager,
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
                  DoubleSourceBuilder(
                    firstSource: wm.tabState,
                    secondSource: wm.seedPhraseFormatState,
                    builder: (_, tabData, seedPhraseFormat) =>
                        SeedPhraseFormatView(
                          networkGroup: wm.networkGroup,
                          networkType: wm.networkType,
                          wordsCount: tabData?.currentValue,
                          value: seedPhraseFormat,
                          onChanged: wm.onSeedPhraseFormatChanged,
                        ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSize.d16,
                    ),
                    child: AccentButton(
                      buttonShape: ButtonShape.pill,
                      title: LocaleKeys.confirm.tr(),
                      onPressed: wm.confirm,
                    ),
                  ),
                  if (wm.isOnboarding)
                    const ViewInsetsPadding(additionalPadding: -DimensSize.d24)
                  else
                    const ViewInsetsPadding(additionalPadding: DimensSize.d24),
                  if (wm.isOnboarding)
                    const SystemSpace(additionalPadding: DimensSize.d12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
