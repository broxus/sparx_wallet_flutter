import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/bookmarks/book_mark_ui_model.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list_model.dart';
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

  late final isVisibleMenu = !model.isEmptyBookmarks;

  late final _bookmarksState = createNotifier<List<BookMarkUiModel>>([]);

  late final _editState = createNotifier<bool>(false);

  StreamSubscription<List<BrowserBookmarkItem>>? _bookmarksSubs;

  ListenableState<List<BookMarkUiModel>> get bookmarksState => _bookmarksState;

  ListenableState<bool> get editState => _editState;

  late final theme = Theme.of(context).copyWith(
    canvasColor: Colors.transparent,
    shadowColor: Colors.transparent,
  );

  @override
  void initWidgetModel() {
    _bookmarksSubs = model.browserBookmarksStream.listen(_handleBookmarks);
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
    _editState.accept(true);
  }

  void onPressedDone() {
    _editState.accept(false);
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

  void _handleBookmarks(List<BrowserBookmarkItem> list) {
    _bookmarksState.accept([
      for (final bookmark in list)
        BookMarkUiModel(
          bookmarkId: bookmark.id,
          title: bookmark.title,
          url: bookmark.url.toString(),
          host: bookmark.url.host,
        ),
    ]);
  }
}
