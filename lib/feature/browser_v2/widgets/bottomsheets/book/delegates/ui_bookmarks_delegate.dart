import 'dart:async';

import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/ui_models/ui_models.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UiBookmarksDelegate {
  UiBookmarksDelegate(
    this._model,
    this._searchListenable,
  );

  final BrowserBookModel _model;
  final ValueListenable<TextEditingValue> _searchListenable;

  late final _bookmarksState =
      StateNotifier<List<BookMarkUiModel>>(initValue: []);

  late final _activeMenuState = StateNotifier<bool>(initValue: true);

  final _editState = StateNotifier<EditValue>(initValue: EditValue.none);

  StreamSubscription<List<BrowserBookmarkItem>>? _bookmarksSubs;

  ListenableState<List<BookMarkUiModel>> get bookmarksState => _bookmarksState;

  ListenableState<bool> get activeMenuState => _activeMenuState;

  ListenableState<EditValue> get editState => _editState;

  bool get isShowSearch => _model.browserBookmarks.length > 10;

  void init() {
    _bookmarksSubs = _model.browserBookmarksStream.listen(_handleBookmarks);
    _updateActiveMenu();
  }

  void dispose() {
    _bookmarksState.dispose();
    _editState.dispose();
    _activeMenuState.dispose();
    _bookmarksSubs?.cancel();
  }

  void handleSearch() {
    _updateBookmarks();
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
    _updateEdit();
  }

  void onPressedDone() {
    _editState.accept(EditValue.none);
  }

  void onPressedRemove(String bookmarkId) {
    _model.removeBookmark(bookmarkId);
  }

  void onReorder(int oldIndex, int newIndex) {
    _model.reorderBookmark(
      oldIndex,
      newIndex,
    );
  }

  void _handleBookmarks(_) {
    _updateBookmarks();
    _updateActiveMenu();

    if (_model.browserBookmarks.isEmpty) {
      _editState.accept(EditValue.none);
    }
  }

  void _updateEdit() {
    _editState.accept(
      _searchListenable.value.text.isEmpty
          ? EditValue.edit
          : EditValue.searchEdit,
    );
  }

  void _updateBookmarks() {
    final list = _model.browserBookmarks;
    final searchedText = _searchListenable.value.text;

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
      _model.isExistBookmarks,
    );
  }
}

enum EditValue {
  edit,
  searchEdit,
  none,
}
