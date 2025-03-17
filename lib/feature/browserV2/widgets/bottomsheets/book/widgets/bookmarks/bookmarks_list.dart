import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/book_item/book_item.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/book_menu.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/bookmarks/book_mark_ui_model.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list_wm.dart';
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
          Flexible(
            child: StateNotifierBuilder<List<BookMarkUiModel>>(
              listenableState: wm.bookmarksState,
              builder: (_, List<BookMarkUiModel>? list) {
                if (list == null) {
                  return const SizedBox.shrink();
                } else if (list.isEmpty) {
                  return const _EmptyContent();
                }
                return ReorderableListView.builder(
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
                      subTitle: list[index].host,
                      url: list[index].url,
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
          if (wm.isVisibleMenu)
            BrowserBookmarksMenu(
              editState: wm.editState,
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

class _EmptyContent extends StatelessWidget {
  const _EmptyContent();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Padding(
      padding: const EdgeInsets.only(
        bottom: DimensSizeV2.d70,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
            child: Text(
              LocaleKeys.noBookmarksYet.tr(),
              style: theme.textStyles.headingLarge,
            ),
          ),
          Text(
            LocaleKeys.bookmarksEmptyDescription.tr(),
            textAlign: TextAlign.center,
            style: theme.textStyles.paragraphMedium.copyWith(
              color: theme.colors.content4,
            ),
          ),
        ],
      ),
    );
  }
}
