import 'dart:async';
import 'dart:collection';

import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browser/widgets/bottomsheets/book/browser_book_model.dart';
import 'package:app/feature/browser/widgets/bottomsheets/book/ui_models/ui_model.dart';
import 'package:app/feature/browser/widgets/bottomsheets/book/widgets/clear_history_modal.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

class UiHistoryDelegate {
  UiHistoryDelegate(this._model);

  final BrowserBookModel _model;

  final searchController = TextEditingController();

  late final _historyState = StateNotifier<List<HistoryUiModel>>(initValue: []);

  late final _searchVisibleState = StateNotifier<bool>();

  final _editState = StateNotifier<bool>(initValue: false);

  final _activeEditState = StateNotifier<bool>(initValue: true);
  final _activeClearState = StateNotifier<bool>(initValue: true);

  StreamSubscription<List<BrowserHistoryItem>>? _historySubs;
  StreamSubscription<int>? _countSubs;

  final _dateFormatCache = HashMap<DateTime, String>();

  ListenableState<List<HistoryUiModel>> get historyState => _historyState;

  ListenableState<bool> get editState => _editState;

  ListenableState<bool> get activeEditState => _activeEditState;
  ListenableState<bool> get activeClearState => _activeClearState;

  ListenableState<bool> get searchVisibleState => _searchVisibleState;

  void init() {
    _historySubs = _model.watchHistory().listen(_handleHistory);
    _countSubs = _model.watchHistoryCount().listen(_handleCount);
    searchController.addListener(_search);
  }

  void dispose() {
    searchController.dispose();
    _historySubs?.cancel();
    _countSubs?.cancel();
    _historyState.dispose();
    _searchVisibleState.dispose();
    _editState.dispose();
    _activeEditState.dispose();
    _activeClearState.dispose();
    _dateFormatCache.clear();
  }

  Future<bool> onPressedItem(String id) async {
    final historyItem = await _model.getHistoryItemById(id);

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

  void _handleHistory(List<BrowserHistoryItem> items) {
    _activeEditState.accept(items.isNotEmpty);

    if (items.isEmpty) {
      _historyState.accept([]);
      return;
    }

    final result = <HistoryUiModel>[];

    BrowserHistoryItem? prevItem;
    final count = items.length;

    for (var i = 0; i < count; i++) {
      final item = items[i];

      final visitTime = item.visitTime;
      if (prevItem == null || !prevItem.visitTime.isSameDay(visitTime)) {
        final date = _dateFormatCache[visitTime] ??= DateFormat.yMMMMEEEEd(
          _model.localeCode,
        ).format(visitTime);
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

  void _handleCount(int count) {
    _searchVisibleState.accept(count > 10);
    _activeClearState.accept(count > 0);

    if (count == 0) {
      _editState.accept(false);
    }
  }

  void _search() {
    _historySubs?.cancel();

    _historySubs = _model
        .watchHistory(searchController.text)
        .listen(_handleHistory);
  }
}
