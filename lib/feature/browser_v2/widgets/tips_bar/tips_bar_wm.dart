import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_safe_notifier.dart';
import 'package:app/data/models/browser_item.dart';
import 'package:app/di/di.dart';
import 'package:app/extensions/string_extension.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/widgets/tips_bar/tips_bar.dart';
import 'package:app/feature/browser_v2/widgets/tips_bar/tips_bar_model.dart';
import 'package:app/feature/browser_v2/widgets/tips_bar/ui_models.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [TipsBarWidgetModel]
TipsBarWidgetModel defaultTipsBarWidgetModelFactory(
  BuildContext context, {
  required NotNullNotifier<String> textNotifier,
  required VoidCallback onPressedItem,
}) {
  return TipsBarWidgetModel(
    TipsBarModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    textNotifier,
    onPressedItem,
  );
}

/// [WidgetModel] для [TipsBar]
class TipsBarWidgetModel extends CustomWidgetModel<TipsBar, TipsBarModel> {
  TipsBarWidgetModel(
    super.model,
    this._textNotifier,
    this._onPressedItem,
  );

  final NotNullNotifier<String> _textNotifier;
  final VoidCallback _onPressedItem;

  final _searchResult = <String, BrowserItem>{};
  final _urlsResult = <String>{};
  late String _prevText = _textNotifier.value;

  late final _uiModelsState = createNotifier<List<TipUiModel>>();

  ListenableState<List<TipUiModel>> get uiModelsState => _uiModelsState;

  @override
  void initWidgetModel() {
    _textNotifier.addListener(_onChangedText);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _textNotifier.removeListener(_onChangedText);
    super.dispose();
  }

  void onPressedItem(String id) {
    final item = _searchResult[id];

    if (item == null) {
      return;
    }

    model.requestUri(item.url);

    _onPressedItem();
  }

  Future<void> _search(String text) async {
    _searchResult.clear();
    _urlsResult.clear();

    if (text.isEmpty) {
      _uiModelsState.accept(null);
      return;
    }

    final lowText = text.low;

    final uiModels = <TipUiModel>[];

    try {
      for (final bookmark in model.browserBookmarks) {
        if (_urlsResult.contains(bookmark.url.host)) {
          continue;
        }

        await Future(
          () {
            if (bookmark.url.toString().low.contains(lowText) ||
                bookmark.title.low.contains(lowText)) {
              _searchResult[bookmark.id] = bookmark;
              _urlsResult.add(bookmark.url.host);

              uiModels.add(
                BookmarkTipUiModel(
                  id: bookmark.id,
                  title: bookmark.title,
                  uri: bookmark.url,
                ),
              );
            }
          },
        );
      }

      for (final history in model.browserHistoryItems) {
        if (_urlsResult.contains(history.url.host) ||
            history.url.host.contains(BrowserService.searchEngineHost)) {
          continue;
        }

        await Future(
          () {
            if (history.url.host.low.contains(lowText) ||
                history.title.low.contains(lowText)) {
              _searchResult[history.id] = history;
              _urlsResult.add(history.url.host);
              uiModels.add(
                HistoryTipUiModel(
                  id: history.id,
                  title: history.title,
                ),
              );
            }
          },
        );
      }
      _uiModelsState.accept(uiModels.toList());
    } catch (_) {
      _uiModelsState.accept(null);
    }
  }

  Future<void> _onChangedText() async {
    if (_prevText == _textNotifier.value) {
      return;
    }

    _prevText = _textNotifier.value;

    return _search(_textNotifier.value);
  }
}
