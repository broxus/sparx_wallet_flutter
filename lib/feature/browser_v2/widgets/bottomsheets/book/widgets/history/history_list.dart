import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/book_item/book_item.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/book_menu.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/history_list_wm.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/ui_models/history_ui_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/widgets/date_item.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/widgets/history_empty.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class HistoryList extends InjectedElementaryWidget<HistoryListWidgetModel> {
  const HistoryList({
    super.key,
  }) : super();

  @override
  Widget build(HistoryListWidgetModel wm) {
    return Column(
      children: [
        StateNotifierBuilder(
          listenableState: wm.isShowSearchState,
          builder: (_, bool? isShowSearch) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: DimensSizeV2.d16,
                left: DimensSizeV2.d24,
                right: DimensSizeV2.d24,
              ),
              child: PrimaryTextField(
                hintText: LocaleKeys.browserSearch.tr(),
                textEditingController: wm.searchController,
              ),
            );
          },
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
                      :final Uri uri,
                      :final String title,
                      :final String subTitle,
                    ) =>
                      HistoryListItem(
                        key: ValueKey(id),
                        editState: wm.editState,
                        uri: uri,
                        title: title,
                        subTitle: subTitle,
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
