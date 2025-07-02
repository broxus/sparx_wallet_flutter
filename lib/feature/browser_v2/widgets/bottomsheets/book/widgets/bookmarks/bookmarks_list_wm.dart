import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/bookmarks/ui_models/book_mark_ui_model.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

/// Factory method for creating [BookmarksListWidgetModel]
BookmarksListWidgetModel defaultBookmarksListWidgetModelFactory(
  BuildContext context,
) {
  return BookmarksListWidgetModel(
    BookmarksListModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BookmarksList]
class BookmarksListWidgetModel
    extends CustomWidgetModel<BookmarksList, BookmarksListModel> {
  BookmarksListWidgetModel(
    super.model,
  );

  late final searchController = createTextEditingController();

  late final _bookmarksState = createNotifier<List<BookMarkUiModel>>([]);

  late final _activeMenuState = createNotifier<bool>(true);

  late final _editState = createNotifier<EditValue>(EditValue.none);

  StreamSubscription<List<BrowserBookmarkItem>>? _bookmarksSubs;

  ListenableState<List<BookMarkUiModel>> get bookmarksState => _bookmarksState;

  ListenableState<bool> get activeMenuState => _activeMenuState;

  ListenableState<EditValue> get editState => _editState;

  bool get isShowSearch => model.browserBookmarks.length > 10;

  late final theme = Theme.of(context).copyWith(
    canvasColor: Colors.transparent,
    shadowColor: Colors.transparent,
  );

  @override
  void initWidgetModel() {
    _bookmarksSubs = model.browserBookmarksStream.listen(_handleBookmarks);
    searchController.addListener(_handleSearch);
    _updateActiveMenu();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _bookmarksSubs?.cancel();
    super.dispose();
  }

  void onPressedItem(String id) {
    final bookmark = model.browserBookmarks.firstWhereOrNull(
      (item) => item.id == id,
    );

    if (bookmark == null) {
      return;
    }

    model.requestUrl(bookmark.url);
    _close();
  }

  void onPressedEdit() {
    _updateEdit();
  }

  void onPressedDone() {
    _editState.accept(EditValue.none);
  }

  void onPressedRemove(String bookmarkId) {
    model.removeBookmark(bookmarkId);
  }

  void onReorder(int oldIndex, int newIndex) {
    model.reorder(
      oldIndex,
      newIndex,
    );
  }

  void _close() {
    Navigator.of(context).pop();
  }

  void _handleBookmarks(_) {
    _updateBookmarks();
    _updateActiveMenu();

    if (model.browserBookmarks.isEmpty) {
      _editState.accept(EditValue.none);
    }
  }

  void _handleSearch() {
    _updateBookmarks();
  }

  void _updateEdit() {
    _editState.accept(
      searchController.text.isEmpty ? EditValue.edit : EditValue.searchEdit,
    );
  }

  void _updateBookmarks() {
    final list = model.browserBookmarks;
    final searchedText = searchController.text;

    _bookmarksState.accept(
      [
        for (final bookmark in list)
          if (searchedText.isEmpty ||
              bookmark.title.contains(searchedText) ||
              bookmark.url.toString().contains(searchedText))
            BookMarkUiModel(
              bookmarkId: bookmark.id,
              title: bookmark.title,
              uri: bookmark.url,
            ),
      ],
    );
  }

  void _updateActiveMenu() {
    _activeMenuState.accept(
      model.isExistBookmarks,
    );
  }
}

enum EditValue {
  edit,
  searchEdit,
  none,
}
