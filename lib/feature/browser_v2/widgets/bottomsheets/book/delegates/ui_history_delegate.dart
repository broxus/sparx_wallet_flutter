import 'dart:async';
import 'dart:collection';

import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/ui_models/ui_models.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/clear_history_modal.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UiHistoryDelegate {
  UiHistoryDelegate(
    this._model,
    this._searchListenable,
  );

  final BrowserBookModel _model;
  final ValueListenable<TextEditingValue> _searchListenable;

  late final _historyState = StateNotifier<List<HistoryUiModel>>(initValue: []);

  late final _editState = StateNotifier<bool>(initValue: false);

  late final _activeMenuState = StateNotifier<bool>(initValue: true);

  StreamSubscription<List<BrowserHistoryItem>>? _historySubs;

  final _dateFormatCache = HashMap<DateTime, String>();

  ListenableState<List<HistoryUiModel>> get historyState => _historyState;

  ListenableState<bool> get editState => _editState;

  ListenableState<bool> get activeMenuState => _activeMenuState;

  bool get isShowSearch => _model.originalBrowserHistoryItems.length > 10;

  void init() {
    _historySubs = _model.originalBrowserHistoryStream.listen(_handleHistory);
    _updateActiveMenu();
  }

  void dispose() {
    _historySubs?.cancel();
    _historyState.dispose();
    _editState.dispose();
    _activeMenuState.dispose();
    _dateFormatCache.clear();
  }

  bool onPressedItem(String id) {
    final historyItem = _model.originalBrowserHistoryItems.firstWhereOrNull(
      (item) => item.id == id,
    );

    if (historyItem == null) {
      return false;
    }

    _model.requestUrl(historyItem.url);
    return true;
  }

  void onPressedEdit() {
    _editState.accept(true);
  }

  void onPressedDone() {
    _editState.accept(false);
  }

  Future<bool> clear(BuildContext context) async {
    final result = await showClearHistoryModal(context);

    if (result == null) {
      return false;
    }

    final period = result.$1;
    final targets = result.$2;

    if (targets.isEmpty) {
      return false;
    }

    _model.clearData(period, targets);

    return true;
  }

  void onPressedRemove(String bookmarkId) {
    _model.removeHistory(bookmarkId);
  }

  void handleSearch() {
    _updateHistory();
  }

  void _handleHistory(_) {
    _updateHistory();
    _updateActiveMenu();

    if (_model.originalBrowserHistoryItems.isEmpty) {
      _editState.accept(false);
    }
  }

  void _updateHistory() {
    final list = [..._model.originalBrowserHistoryItems];
    final searchedText = _searchListenable.value.text;

    if (list.isEmpty) {
      _historyState.accept([]);
      return;
    }

    final result = <HistoryUiModel>[];

    final sortedItems = list.sorted(
      (a, b) => a.visitTime.compareTo(b.visitTime),
    );

    BrowserHistoryItem? prevItem;
    final count = sortedItems.length;

    for (var i = count - 1; i >= 0; i--) {
      final item = sortedItems[i];

      if (!item.title.contains(searchedText) &&
          !item.url.toString().contains(searchedText)) {
        continue;
      }

      final visitTime = item.visitTime;
      if (prevItem == null || !prevItem.visitTime.isSameDay(visitTime)) {
        final date = _dateFormatCache[visitTime] ??=
            DateFormat.yMMMMEEEEd(_model.localeCode).format(visitTime);
        result.add(DateUiModel(date));
      }

      result.add(
        HistoryItemUiModel(
          id: item.id,
          uri: item.url,
          title: item.url.host,
          subTitle: item.url.toString(),
        ),
      );

      prevItem = item;
    }

    _historyState.accept(result);
  }

  void _updateActiveMenu() {
    _activeMenuState.accept(
      _model.isExistHistory,
    );
  }
}
