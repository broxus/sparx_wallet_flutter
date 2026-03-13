import 'package:app/feature/add_seed/enter_seed_phrase/data/input_data.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/data/tab_data.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_wm.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/widgets/tabs.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/components/input/common_input_style_v2.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EnterSeedPhraseWords extends StatelessWidget {
  const EnterSeedPhraseWords({
    required this.formKey,
    required this.renderManager,
    required this.allowedValues,
    required this.currentValue,
    required this.displayPasteButtonState,
    required this.tabState,
    required this.changeTab,
    required this.pastePhrase,
    required this.clearFields,
    required this.onSuggestions,
    required this.onSuggestionSelected,
    required this.onNext,
    super.key,
  });

  static final _log = Logger('EnterSeedPhraseWords');

  final GlobalKey<FormState> formKey;
  final RenderManager<Object> renderManager;
  final List<int> allowedValues;
  final int currentValue;
  final ListenableState<bool> displayPasteButtonState;
  final ListenableState<EnterSeedPhraseTabData> tabState;
  final ValueChanged<int> changeTab;
  final VoidCallback pastePhrase;
  final VoidCallback clearFields;
  final SuggestionsCallback<String> onSuggestions;
  final SuggestionSelectedCallback onSuggestionSelected;
  final ValueChanged<int> onNext;

  @override
  Widget build(BuildContext context) {
    final themeStyleV2 = context.themeStyleV2;
    final mediaQuery = MediaQuery.of(context);

    _log.info(
      'ENTER SEED:\n'
      'build: mediaSize=${mediaQuery.size}, '
      'devicePixelRatio=${mediaQuery.devicePixelRatio}, '
      'viewInsetsBottom=${mediaQuery.viewInsets.bottom}, '
      'currentValue=$currentValue',
    );

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: DimensSize.d24),
          Flexible(
            child: EnterSeedPhraseTabs(
              allowedValues: allowedValues,
              currentValue: currentValue,
              displayPasteButtonState: displayPasteButtonState,
              changeTab: changeTab,
              pastePhrase: pastePhrase,
              clearFields: clearFields,
            ),
          ),
          StateNotifierBuilder(
            listenableState: tabState,
            builder: (_, EnterSeedPhraseTabData? data) {
              if (data == null) {
                return const SizedBox.shrink();
              }

              final splitIndex = (data.inputs.length / 2).ceil();
              final leftInputs = data.inputs.take(splitIndex).toList();
              final rightInputs = data.inputs.skip(splitIndex).toList();
              final columnWidth =
                  (mediaQuery.size.width -
                      (DimensSize.d16 * 2) -
                      DimensSize.d8) /
                  2;

              _log.info(
                'ENTER SEED:\n'
                'layout: inputs=${data.inputs.length}, '
                'columnWidth=$columnWidth, '
                'splitIndex=$splitIndex',
              );

              return Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: DimensSize.d16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _InputsColumn(
                          inputs: leftInputs,
                          renderManager: renderManager,
                          theme: themeStyleV2,
                          currentValue: currentValue,
                          onSuggestions: onSuggestions,
                          onSuggestionSelected: onSuggestionSelected,
                          onNext: onNext,
                        ),
                      ),
                      const SizedBox(width: DimensSize.d8),
                      Expanded(
                        child: _InputsColumn(
                          inputs: rightInputs,
                          renderManager: renderManager,
                          theme: themeStyleV2,
                          currentValue: currentValue,
                          onSuggestions: onSuggestions,
                          onSuggestionSelected: onSuggestionSelected,
                          onNext: onNext,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InputsColumn extends StatelessWidget {
  const _InputsColumn({
    required this.inputs,
    required this.renderManager,
    required this.theme,
    required this.currentValue,
    required this.onSuggestions,
    required this.onSuggestionSelected,
    required this.onNext,
  });

  final List<EnterSeedPhraseInputData> inputs;
  final RenderManager<Object> renderManager;
  final ThemeStyleV2 theme;
  final int currentValue;
  final SuggestionsCallback<String> onSuggestions;
  final SuggestionSelectedCallback onSuggestionSelected;
  final ValueChanged<int> onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < inputs.length; i++) ...[
          _Input(
            key: ValueKey(inputs[i].index),
            renderManager: renderManager,
            theme: theme,
            data: inputs[i],
            currentValue: currentValue,
            onSuggestions: onSuggestions,
            onSuggestionSelected: onSuggestionSelected,
            onNext: onNext,
          ),
          if (i != inputs.length - 1) const SizedBox(height: DimensSize.d8),
        ],
      ],
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    required this.theme,
    required this.renderManager,
    required this.data,
    required this.currentValue,
    required this.onSuggestions,
    required this.onSuggestionSelected,
    required this.onNext,
    super.key,
  });

  static final _log = Logger('EnterSeedPhraseInput');

  final ThemeStyleV2 theme;
  final RenderManager<Object> renderManager;
  final EnterSeedPhraseInputData data;
  final int currentValue;
  final SuggestionsCallback<String> onSuggestions;
  final SuggestionSelectedCallback onSuggestionSelected;
  final ValueChanged<int> onNext;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final themeStyleV2 = context.themeStyleV2;
    final displayIndex = (data.index + 1).toString();

    return RenderMetricsObject(
      id: data.focusNode,
      manager: renderManager,
      child: CommonInput(
        autocorrect: false,
        hintStyle: themeStyleV2.textStyles.labelSmall,
        inactiveBorderColor: themeStyleV2.colors.border0,
        textStyle: themeStyleV2.textStyles.labelSmall,
        suggestionBackground: themeStyleV2.colors.background1,
        keyboardType: TextInputType.visiblePassword,
        height: DimensSize.d48,
        controller: data.controller,
        suggestionsCallback: (_) {
          _log.info(
            'ENTER SEED:\n'
            'suggestionsCallback: index=${data.index}, '
            'textLength=${data.controller.text.length}, '
            'isFocused=${data.focusNode.hasFocus}',
          );
          return onSuggestions(data.controller.text);
        },
        itemBuilder: _itemBuilder,
        onSuggestionSelected: (suggestion) =>
            onSuggestionSelected(suggestion, data.index),
        focusNode: data.focusNode,
        // show error border if field is empty
        validator: (v) => v?.isEmpty ?? true ? '' : null,
        needClearButton: false,
        // IntrinsicWidth to force Center match prefixIconConstraints
        prefixIcon: IntrinsicWidth(
          child: Center(
            child: Text(
              displayIndex,
              style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
            ),
          ),
        ),
        onSubmitted: (_) => onNext(data.index),
        textInputAction: data.index == currentValue - 1
            ? TextInputAction.done
            : TextInputAction.next,
        v2Style: CommonInputStyleV2(themeStyleV2),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, String suggestion) {
    return ListTile(
      tileColor: Colors.transparent,
      title: Text(suggestion, style: theme.textStyles.labelSmall),
    );
  }
}
