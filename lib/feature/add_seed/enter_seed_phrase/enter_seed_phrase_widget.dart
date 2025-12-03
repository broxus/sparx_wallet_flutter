import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/add_seed.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

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
        appBar: const DefaultAppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
              controller: wm.screenScrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                    child: PrimaryText(LocaleKeys.pasteSeedIntoFirstBox.tr()),
                  ),
                  Flexible(
                    child: StateNotifierBuilder(
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
                  ),
                  const SizedBox(height: DimensSizeV2.d100),
                  const ViewInsetsPadding(),
                  const SystemSpace(additionalPadding: DimensSize.d20),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: RenderMetricsObject(
                id: wm.actionBarId,
                manager: wm.renderManager,
                child: Container(
                  color: theme.colors.background0,
                  padding: const EdgeInsets.only(
                    top: DimensSizeV2.d16,
                    left: DimensSizeV2.d16,
                    right: DimensSizeV2.d16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      AccentButton(
                        buttonShape: ButtonShape.pill,
                        title: LocaleKeys.confirm.tr(),
                        onPressed: wm.confirm,
                      ),
                      const ViewInsetsPadding(
                        additionalPadding: -DimensSize.d48,
                      ),
                      const SystemSpace(additionalPadding: DimensSize.d20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
