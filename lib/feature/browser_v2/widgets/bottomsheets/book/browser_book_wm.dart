import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/delegates/ui_bookmarks_delegate.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/delegates/ui_history_delegate.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/ui_models/ui_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/tab_data.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// [WidgetModel] для [BrowserBook]
@injectable
class BrowserBookWidgetModel
    extends CustomWidgetModel<BrowserBook, BrowserBookModel> {
  BrowserBookWidgetModel(super.model);

  late final bookmarksDelegate = UiBookmarksDelegate(model);
  late final historyDelegate = UiHistoryDelegate(model);

  late final theme = Theme.of(
    context,
  ).copyWith(canvasColor: Colors.transparent, shadowColor: Colors.transparent);

  late final _tabBarState = createNotifier<BrowserBookTabBarValue>(
    BrowserBookTabBarValue.bookMarks,
  );

  late final _itemsState = createNotifier<List<BaseBookUiModel>>();

  ListenableState<BrowserBookTabBarValue> get tabBarState => _tabBarState;

  ListenableState<List<BaseBookUiModel>> get itemsState => _itemsState;

  ColorsPaletteV2 get colors => context.themeStyleV2.colors;

  @override
  void initWidgetModel() {
    bookmarksDelegate
      ..init()
      ..bookmarksState.addListener(_handleBookmarks);
    historyDelegate
      ..init()
      ..historyState.addListener(_handleHistory);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    bookmarksDelegate.dispose();
    historyDelegate.dispose();
    super.dispose();
  }

  void onBackgroundPressed() {
    Navigator.of(context).pop();
  }

  void onPressedTab(BrowserBookTabBarValue value) {
    _tabBarState.accept(value);

    _itemsState.accept(switch (_tabBarState.value) {
      BrowserBookTabBarValue.bookMarks =>
        bookmarksDelegate.bookmarksState.value,
      BrowserBookTabBarValue.history => historyDelegate.historyState.value,
      _ => null,
    });
  }

  void _handleBookmarks() {
    if (_tabBarState.value != BrowserBookTabBarValue.bookMarks) {
      return;
    }

    _itemsState.accept(bookmarksDelegate.bookmarksState.value);
  }

  void _handleHistory() {
    if (_tabBarState.value != BrowserBookTabBarValue.history) {
      return;
    }

    _itemsState.accept(historyDelegate.historyState.value);
  }

  Future<void> onPressedItem(BaseBookUiModel uiModel) async {
    var isSuccess = false;

    if (uiModel is BookMarkUiModel) {
      isSuccess = bookmarksDelegate.onPressedItem(uiModel.bookmarkId);
    } else if (uiModel is HistoryItemUiModel) {
      isSuccess = await historyDelegate.onPressedItem(uiModel.id);
    }

    if (isSuccess) {
      _close();
    }
  }

  Future<void> onPressedClear() async {
    final isSuccess = await historyDelegate.clear(context);

    if (isSuccess) {
      _close();
    }
  }

  void _close() {
    Navigator.of(context).pop();
  }
}
