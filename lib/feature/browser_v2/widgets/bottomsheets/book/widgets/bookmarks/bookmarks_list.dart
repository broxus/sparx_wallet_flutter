import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/book_item/book_item.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/book_menu.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list_wm.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/bookmarks/ui_models/book_mark_ui_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/bookmarks/widgets/bookmarks_empty.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BookmarksList extends ElementaryWidget<BookmarksListWidgetModel> {
  const BookmarksList({
    super.key,
    WidgetModelFactory<BookmarksListWidgetModel> wmFactory =
        defaultBookmarksListWidgetModelFactory,
  }) : super(wmFactory);

  @override
  Widget build(BookmarksListWidgetModel wm) {
    return Theme(
      data: wm.theme,
      child: Column(
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
            child: StateNotifierBuilder<List<BookMarkUiModel>>(
              listenableState: wm.bookmarksState,
              builder: (_, List<BookMarkUiModel>? list) {
                if (list == null) {
                  return const SizedBox.shrink();
                } else if (list.isEmpty) {
                  return const BookmarksEmptyContent();
                }
                return ReorderableListView.builder(
                  physics: const ClampingScrollPhysics(),
                  proxyDecorator: _proxyDecorator,
                  buildDefaultDragHandles: false,
                  itemCount: list.length,
                  onReorder: wm.onReorder,
                  padding: const EdgeInsets.only(
                    left: DimensSizeV2.d24,
                    right: DimensSizeV2.d24,
                  ),
                  itemBuilder: (_, int index) {
                    return BookmarkListItem(
                      key: ValueKey(list[index].bookmarkId),
                      index: index,
                      editState: wm.editState,
                      title: list[index].title,
                      subTitle: list[index].subTitle,
                      uri: list[index].uri,
                      onPressed: () => wm.onPressedItem(list[index].bookmarkId),
                      onPressedRemove: () => wm.onPressedRemove(
                        list[index].bookmarkId,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          BrowserBookmarksMenu(
            editState: wm.editState,
            activeState: wm.activeMenuState,
            onPressedEdit: wm.onPressedEdit,
            onPressedDone: wm.onPressedDone,
          ),
        ],
      ),
    );
  }

  Widget _proxyDecorator(Widget child, _, __) {
    return Material(
      color: Colors.transparent,
      child: child,
    );
  }
}
