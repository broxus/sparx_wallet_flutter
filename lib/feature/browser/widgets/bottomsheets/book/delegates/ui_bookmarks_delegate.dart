import 'dart:async';

import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser/widgets/bottomsheets/book/browser_book_model.dart';
import 'package:app/feature/browser/widgets/bottomsheets/book/ui_models/ui_model.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

class UiBookmarksDelegate {
  UiBookmarksDelegate(this._model);

  final BrowserBookModel _model;

  final searchController = TextEditingController();

  final _bookmarksState = StateNotifier<List<BookMarkUiModel>>(initValue: []);

  final _searchVisibleState = StateNotifier<bool>();

  final _activeMenuState = StateNotifier<bool>(initValue: true);

  final _editState = StateNotifier<bool>(initValue: false);

  StreamSubscription<List<BrowserBookmarkItem>>? _bookmarksSubs;

  ListenableState<List<BookMarkUiModel>> get bookmarksState => _bookmarksState;

  ListenableState<bool> get activeMenuState => _activeMenuState;

  ListenableState<bool> get editState => _editState;

  ListenableState<bool> get searchVisibleState => _searchVisibleState;

  bool get _isShowSearch => _model.browserBookmarks.length > 10;

  void init() {
    _bookmarksSubs = _model.browserBookmarksStream.listen(
      (_) => _handleBookmarks(),
    );
    searchController.addListener(_handleBookmarks);
  }

  void dispose() {
    searchController.dispose();
    _bookmarksState.dispose();
    _searchVisibleState.dispose();
    _editState.dispose();
    _activeMenuState.dispose();
    _bookmarksSubs?.cancel();
  }

  bool onPressedItem(String id) {
    final bookmark = _model.browserBookmarks.firstWhereOrNull(
      (item) => item.id == id,
    );

    if (bookmark == null) {
      return false;
    }

    _model.requestUrl(bookmark.url);
    return true;
  }

  void onPressedEdit() {
    _editState.accept(true);
  }

  void onPressedDone() {
    _editState.accept(false);
  }

  void onPressedRemove(String bookmarkId) {
    _model.removeBookmark(bookmarkId);
  }

  void onReorder(int oldIndex, int newIndex) {
    _model.reorderBookmark(oldIndex, newIndex);
  }

  void _handleBookmarks() {
    _activeMenuState.accept(_model.isExistBookmarks);

    if (_model.browserBookmarks.isEmpty) {
      _editState.accept(false);
    }

    _searchVisibleState.accept(_isShowSearch);

    final list = _model.browserBookmarks;
    final searchedText = searchController.value.text;
    _bookmarksState.accept([
      for (final bookmark in list)
        if (searchedText.isEmpty ||
            bookmark.title.contains(searchedText) ||
            bookmark.url.toString().contains(searchedText))
          BookMarkUiModel(
            bookmarkId: bookmark.id,
            title: bookmark.title,
            uri: bookmark.url,
          ),
    ]);
  }
}
