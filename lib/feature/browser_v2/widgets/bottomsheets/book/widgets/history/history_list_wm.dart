import 'dart:async';
import 'dart:collection';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/history_list.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/history_list_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/ui_models/history_ui_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/widgets/clear_history_modal.dart';
import 'package:app/utils/common_utils.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [HistoryListWidgetModel]
HistoryListWidgetModel defaultHistoryListWidgetModelFactory(
  BuildContext context,
) {
  return HistoryListWidgetModel(
    HistoryListModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [HistoryList]
class HistoryListWidgetModel
    extends CustomWidgetModel<HistoryList, HistoryListModel> {
  HistoryListWidgetModel(
    super.model,
  );

  late final searchController = createTextEditingController();

  late final _historyState = createNotifier<List<HistoryUiModel>>([]);

  late final _editState = createNotifier<bool>(false);

  late final _activeMenuState = createNotifier<bool>(true);

  StreamSubscription<List<BrowserHistoryItem>>? _historySubs;

  final _dateFormatCache = HashMap<DateTime, String>();

  ListenableState<List<HistoryUiModel>> get historyState => _historyState;

  ListenableState<bool> get editState => _editState;

  ListenableState<bool> get activeMenuState => _activeMenuState;

  bool get isShowSearch => model.originalBrowserHistoryItems.length > 10;

  @override
  void initWidgetModel() {
    _historySubs = model.originalBrowserHistoryStream.listen(_handleHistory);
    searchController.addListener(_handleSearch);
    _updateActiveMenu();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _historySubs?.cancel();
    _dateFormatCache.clear();
    super.dispose();
  }

  void onPressedItem(String id) {
    final historyItem = model.originalBrowserHistoryItems.firstWhereOrNull(
      (item) => item.id == id,
    );

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

  void _handleHistory(_) {
    _updateHistory();
    _updateActiveMenu();

    if (model.originalBrowserHistoryItems.isEmpty) {
      _editState.accept(false);
    }
  }

  void _handleSearch() {
    _updateHistory();
  }

  void _updateHistory() {
    final list = [...model.originalBrowserHistoryItems];
    final searchedText = searchController.text;

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

  void _updateActiveMenu() {
    _activeMenuState.accept(
      model.isExistHistory,
    );
  }
}
