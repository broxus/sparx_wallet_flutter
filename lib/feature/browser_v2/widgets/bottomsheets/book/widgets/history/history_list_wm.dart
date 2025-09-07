import 'dart:async';
import 'dart:collection';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/history_list.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/history_list_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/ui_models/history_ui_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/widgets/clear_history_modal.dart';
import 'package:app/utils/common_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [HistoryList]
@injectable
class HistoryListWidgetModel
    extends CustomWidgetModel<HistoryList, HistoryListModel> {
  HistoryListWidgetModel(
    super.model,
  );

  late final searchController = createTextEditingController();

  late final _historyState = createNotifier<List<HistoryUiModel>>([]);

  late final _editState = createNotifier<bool>(false);

  late final _activeMenuState = createNotifier<bool>(true);

  late final _isShowSearchState = createNotifier<bool>(true);

  StreamSubscription<List<BrowserHistoryItem>>? _historySubs;
  StreamSubscription<int>? _countSubs;

  final _dateFormatCache = HashMap<DateTime, String>();

  ListenableState<List<HistoryUiModel>> get historyState => _historyState;

  ListenableState<bool> get editState => _editState;

  ListenableState<bool> get activeMenuState => _activeMenuState;

  ListenableState<bool> get isShowSearchState => _isShowSearchState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _search();
    _countSubs = model.watchHistoryCount().listen((int count) {
      _isShowSearchState.accept(count > 10);
    });
    searchController.addListener(_search);
  }

  @override
  void dispose() {
    _historySubs?.cancel();
    _countSubs?.cancel();
    _dateFormatCache.clear();
    super.dispose();
  }

  Future<void> onPressedItem(String id) async {
    final historyItem = await model.getHistoryItemById(id);

    if (historyItem == null) {
      return;
    }

    model.requestUrl(historyItem.url);
    _close();
  }

  void onPressedEdit() {
    _editState.accept(true);
  }

  void onPressedDone() {
    _editState.accept(false);
  }

  void onPressedClear() {
    Future(
      () async {
        final ctx = contextSafe;

        if (ctx == null) {
          return;
        }

        _close();

        // ignore: use_build_context_synchronously
        final result = await showClearHistoryModal(ctx);

        if (result == null) {
          return;
        }

        final period = result.$1;
        final targets = result.$2;

        if (targets.isEmpty) {
          return;
        }

        model.clearData(period, targets);
        _close();
      },
    );
  }

  void onPressedRemove(String bookmarkId) {
    model.removeHistory(bookmarkId);
  }

  void _close() {
    Navigator.of(context).pop();
  }

  void _handleHistory(List<BrowserHistoryItem> items) {
    _activeMenuState.accept(items.isNotEmpty);

    if (items.isEmpty) {
      _editState.accept(false);
      _historyState.accept([]);
      return;
    }

    final result = <HistoryUiModel>[];

    BrowserHistoryItem? prevItem;
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final visitTime = item.visitTime;

      if (prevItem == null || !prevItem.visitTime.isSameDay(visitTime)) {
        final date = _dateFormatCache[visitTime] ??=
            DateFormat.yMMMMEEEEd(model.localeCode).format(visitTime);
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

  void _search() {
    _historySubs?.cancel();
    _historySubs =
        model.watchHistory(searchController.text).listen(_handleHistory);
  }
}
