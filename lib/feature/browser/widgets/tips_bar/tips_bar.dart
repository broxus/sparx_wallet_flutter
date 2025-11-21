import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser/widgets/tips_bar/tip_bar_item.dart';
import 'package:app/feature/browser/widgets/tips_bar/tips_bar_wm.dart';
import 'package:app/feature/browser/widgets/tips_bar/ui_models.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TipsBar
    extends
        InjectedElementaryParametrizedWidget<TipsBarWidgetModel, TipBarParam> {
  TipsBar({
    required NotNullListenableState<String> textNotifier,
    required VoidCallback onPressedItem,
    super.key,
  }) : super(
         wmFactoryParam: TipBarParam(
           textNotifier: textNotifier,
           onPressedItem: onPressedItem,
         ),
       );

  @override
  Widget build(TipsBarWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.uiModelsState,
      builder: (_, List<TipUiModel>? uiModels) {
        if (uiModels == null) {
          return const SizedBox.shrink();
        }
        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.only(
            top: DimensSizeV2.d200,
            bottom: DimensSizeV2.d16,
            left: DimensSizeV2.d16,
            right: DimensSizeV2.d16,
          ),
          itemCount: uiModels.length,
          itemBuilder: (_, int index) {
            return switch (uiModels[index]) {
              HistoryTipUiModel(:final id, :final title) => HistoryTip(
                key: ValueKey(id),
                title: title,
                onPressed: () => wm.onPressedItem(id),
              ),
              BookmarkTipUiModel(:final id, :final title, :final uri) =>
                BookmarkTip(
                  key: ValueKey(id),
                  title: title,
                  uri: uri,
                  onPressed: () => wm.onPressedItem(id),
                ),
            };
          },
        );
      },
    );
  }
}
