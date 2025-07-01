import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/browser_item.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/widgets/tips_bar/tips_bar.dart';
import 'package:app/feature/browser_v2/widgets/tips_bar/tips_bar_model.dart';
import 'package:app/feature/browser_v2/widgets/tips_bar/ui_models.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [TipsBarWidgetModel]
TipsBarWidgetModel defaultTipsBarWidgetModelFactory(
  BuildContext context, {
  required ValueListenable<String> textListenable,
  required ValueChanged<Uri> onSelect,
}) {
  return TipsBarWidgetModel(
    TipsBarModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    textListenable,
    onSelect,
  );
}

/// [WidgetModel] для [TipsBar]
class TipsBarWidgetModel extends CustomWidgetModel<TipsBar, TipsBarModel> {
  TipsBarWidgetModel(
    super.model,
    this._textListenable,
    this._onSelect,
  );

  final ValueListenable<String> _textListenable;
  final ValueChanged<Uri> _onSelect;
  Timer? _searchTimer;

  final _searchResult = <String, BrowserItem>{};

  late final _uiModelsState = createNotifier<List<TipUiModel>>();

  ListenableState<List<TipUiModel>> get uiModelsState => _uiModelsState;

  @override
  void initWidgetModel() {
    _textListenable.addListener(_onChangedText);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _textListenable.addListener(_onChangedText);
    _searchTimer?.cancel();
    super.dispose();
  }

  void onPressedItem(String id) {
    final item = _searchResult[id];

    if (item == null) {
      return;
    }
    _onSelect(item.uri);
  }

  Future<void> _search(String text) async {
    try {
      _searchResult.clear();

      final uiModels = <TipUiModel>[];

      for (final history in model.browserHistoryItems) {
        await Future(() {
          _searchResult[history.id] = history;
          uiModels.add(
            HistoryTipUiModel(
              id: history.id,
              title: history.title,
            ),
          );
        });
      }

      for (final bookmark in model.browserBookmarks) {
        await Future(() {
          _searchResult[bookmark.id] = bookmark;

          uiModels.add(BookmarkTipUiModel(
            id: bookmark.id,
            title: bookmark.title,
            uri: bookmark.uri,
          ));
        });
      }

      _uiModelsState.accept(uiModels);
    } catch (_) {
      _uiModelsState.accept(null);
    }
  }

  Future<void> _onChangedText() async {
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(seconds: 2), () {
      _search(_textListenable.value);
    });
  }
}
