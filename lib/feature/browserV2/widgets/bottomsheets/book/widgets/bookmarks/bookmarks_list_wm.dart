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
import 'package:flutter/widgets.dart';

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

  StreamSubscription<List<BrowserBookmarkItem>>? _bookmarksSubs;

  ListenableState<List<BookMarkUiModel>> get bookmarksState => _bookmarksState;

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
    // TODO
  }

  void onPressedDone() {
    // TODO
  }

  void onReorder(int oldIndex, int newIndex) {
    // TODO
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
