import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/data/models/browser_item.dart';
import 'package:app/feature/browser/domain/service/browser_service.dart';
import 'package:app/feature/browser/widgets/tips_bar/tips_bar.dart';
import 'package:app/feature/browser/widgets/tips_bar/tips_bar_model.dart';
import 'package:app/feature/browser/widgets/tips_bar/ui_models.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [TipsBar]
@injectable
class TipsBarWidgetModel
    extends CustomWidgetModelParametrized<TipsBar, TipsBarModel, TipBarParam> {
  TipsBarWidgetModel(super.model);

  NotNullListenableState<String> get _textNotifier =>
      wmParams.value.textNotifier;

  VoidCallback get _onPressedItem => wmParams.value.onPressedItem;

  final _searchResult = <String, BrowserItem>{};
  final _urlsResult = <String>{};
  String _prevText = '';

  late final _uiModelsState = createNotifier<List<TipUiModel>>();

  ListenableState<List<TipUiModel>> get uiModelsState => _uiModelsState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _textNotifier.addListener(_onChangedText);
    _prevText = _textNotifier.value;
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

    final lowText = text.toLowerCase();

    final uiModels = <TipUiModel>[];

    try {
      for (final bookmark in model.browserBookmarks) {
        if (_urlsResult.contains(bookmark.url.host)) {
          continue;
        }

        await Future(() {
          if (bookmark.url.toString().toLowerCase().contains(lowText) ||
              bookmark.title.toLowerCase().contains(lowText)) {
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
        });
      }

      final items = await model.getHistoryItems();

      for (final history in items) {
        if (_urlsResult.contains(history.url.host) ||
            history.url.host.contains(BrowserService.searchEngineHost)) {
          continue;
        }

        await Future(() {
          if (history.url.host.toLowerCase().contains(lowText) ||
              history.title.toLowerCase().contains(lowText)) {
            _searchResult[history.id] = history;
            _urlsResult.add(history.url.host);
            uiModels.add(
              HistoryTipUiModel(id: history.id, title: history.title),
            );
          }
        });
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

class TipBarParam {
  TipBarParam({required this.textNotifier, required this.onPressedItem});

  final NotNullListenableState<String> textNotifier;
  final VoidCallback onPressedItem;
}
