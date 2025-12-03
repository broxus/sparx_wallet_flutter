import 'package:app/feature/add_seed/enter_seed_phrase/data/input_data.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/data/tab_data.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_wm.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/widgets/tabs.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
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

              return Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: DimensSizeV2.d16,
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.inputs.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: DimensSizeV2.d8),
                    itemBuilder: (_, index) => _Input(
                      key: ValueKey(index),
                      renderManager: renderManager,
                      theme: themeStyleV2,
                      data: data.inputs[index],
                      currentValue: currentValue,
                      onSuggestions: onSuggestions,
                      onSuggestionSelected: onSuggestionSelected,
                      onNext: onNext,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: DimensSize.d16),
        ],
      ),
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
        suggestionsCallback: (_) => onSuggestions(data.controller.text),
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

/*
*
class _Input extends StatefulWidget {
  const _Input({
    required this.theme,
    required this.renderManager,
    required this.data,
    required this.currentValue,
    required this.onSuggestions,
    required this.onSuggestionSelected,
    required this.onNext,
    required this.onFocus,
    super.key,
  });

  final ThemeStyleV2 theme;
  final RenderManager<String> renderManager;
  final EnterSeedPhraseInputData data;
  final int currentValue;
  final SuggestionsCallback<String> onSuggestions;
  final SuggestionSelectedCallback onSuggestionSelected;
  final ValueChanged<int> onNext;
  final ValueChanged<String> onFocus;

  @override
  State<_Input> createState() => _InputState();
}

class _InputState extends State<_Input> {
  late final _focusNode = FocusNode();
  late final _displayIndex = (widget.data.index + 1).toString();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => widget.onFocus(_displayIndex));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final themeStyleV2 = context.themeStyleV2;

    return RenderMetricsObject(
      id: _displayIndex,
      manager: widget.renderManager,
      child: CommonInput(
        autocorrect: false,
        hintStyle: themeStyleV2.textStyles.labelSmall,
        inactiveBorderColor: themeStyleV2.colors.border0,
        textStyle: themeStyleV2.textStyles.labelSmall,
        suggestionBackground: themeStyleV2.colors.background1,
        keyboardType: TextInputType.visiblePassword,
        height: DimensSize.d48,
        controller: widget.data.controller,
        focusNode: _focusNode,
        suggestionsCallback: (_) =>
            widget.onSuggestions(widget.data.controller.text),
        itemBuilder: _itemBuilder,
        onSuggestionSelected: (suggestion) =>
            widget.onSuggestionSelected(suggestion, widget.data.index),
        focusNode: widget.data.focusNode,
        // show error border if field is empty
        validator: (v) => v?.isEmpty ?? true ? '' : null,
        needClearButton: false,
        // IntrinsicWidth to force Center match prefixIconConstraints
        prefixIcon: IntrinsicWidth(
          child: Center(
            child: Text(
              _displayIndex,
              style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
            ),
          ),
        ),
        onSubmitted: (_) => widget.onNext(widget.data.index),
        textInputAction: widget.data.index == widget.currentValue - 1
            ? TextInputAction.done
            : TextInputAction.next,
        v2Style: CommonInputStyleV2(themeStyleV2),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, String suggestion) {
    return ListTile(
      tileColor: Colors.transparent,
      title: Text(suggestion, style: widget.theme.textStyles.labelSmall),
    );
  }
}
*/
