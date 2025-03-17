import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/book_item/book_item.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/book_menu.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/history_list_wm.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/ui_models/history_ui_model.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/widgets/date_item.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/widgets/history_empty.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class HistoryList extends ElementaryWidget<HistoryListWidgetModel> {
  const HistoryList({
    super.key,
    WidgetModelFactory<HistoryListWidgetModel> wmFactory =
        defaultHistoryListWidgetModelFactory,
  }) : super(wmFactory);

  // HistoryEmptyEmptyContent
  @override
  Widget build(HistoryListWidgetModel wm) {
    return Column(
      children: [
        if (wm.isShowSearch)
          Padding(
            padding: const EdgeInsets.only(
              bottom: DimensSizeV2.d16,
              left: DimensSizeV2.d24,
              right: DimensSizeV2.d24,
            ),
            child: PrimaryTextField(
              hintText: LocaleKeys.browserSearch.tr(),
              textEditingController: wm.searchController,
            ),
          ),
        Flexible(
          child: StateNotifierBuilder<List<HistoryUiModel>>(
            listenableState: wm.historyState,
            builder: (_, List<HistoryUiModel>? list) {
              if (list == null) {
                return const SizedBox.shrink();
              } else if (list.isEmpty) {
                return const HistoryEmptyEmptyContent();
              }
              return ListView.builder(
                itemCount: list.length,
                padding: const EdgeInsets.only(
                  left: DimensSizeV2.d24,
                  right: DimensSizeV2.d24,
                ),
                itemBuilder: (_, int index) {
                  return switch (list[index]) {
                    DateUiModel(:final dateText) => DateItem(
                        key: ValueKey(dateText),
                        dateText: dateText,
                      ),
                    HistoryItemUiModel(
                      :final String id,
                      :final String url,
                      :final String title,
                    ) =>
                      HistoryListItem(
                        key: ValueKey(id),
                        editState: wm.editState,
                        title: title,
                        url: url,
                        onPressed: () => wm.onPressedItem(id),
                        onPressedRemove: () => wm.onPressedRemove(id),
                      ),
                  };
                },
              );
            },
          ),
        ),
        HistoryBookmarksMenu(
          editState: wm.editState,
          activeState: wm.activeMenuState,
          onPressedEdit: wm.onPressedEdit,
          onPressedDone: wm.onPressedDone,
          onPressedClear: wm.onPressedClear,
        ),
      ],
    );
  }
}
