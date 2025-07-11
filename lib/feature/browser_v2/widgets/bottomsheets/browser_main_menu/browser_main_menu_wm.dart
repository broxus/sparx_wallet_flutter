import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/widgets/clear_history_modal.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/data/browser_main_menu_data.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserMainMenuWmParams {
  BrowserMainMenuWmParams({
    required this.groupId,
    required this.onPressedCreateTab,
  });

  final String groupId;
  final DoubleValueCallback<String, String> onPressedCreateTab;
}

/// [WidgetModel] для [BrowserMainMenu]
@injectable
class BrowserMainMenuWidgetModel
    extends CustomWidgetModel<BrowserMainMenu, BrowserMainMenuModel> {
  BrowserMainMenuWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final BrowserMainMenuWmParams _wmParams;
  String get _groupId => _wmParams.groupId;
  DoubleValueCallback<String, String> get _onPressedCreateTab =>
      _wmParams.onPressedCreateTab;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  Future<void> onPressedItem(BrowserMainMenuData value) async {
    switch (value) {
      case BrowserMainMenuData.clearHistory:
        _close();

        final result = await showClearHistoryModal(context);

        if (result != null) {
          _clearHistory(result);
        }
      case BrowserMainMenuData.newTab:
        _close();
        final result = model.createTab(_groupId);
        _onPressedCreateTab(result.$1, result.$2);
      case BrowserMainMenuData.reload:
        model.reload();
        _close();
      case BrowserMainMenuData.translatePage:
        _close();
      case BrowserMainMenuData.addBookmark:
        model.addCurrentToBookmark();
        _close();
    }
  }

  void _close() {
    Navigator.of(context).pop();
  }

  void _clearHistory(ClearHistoryType result) {
    final period = result.$1;
    final targets = result.$2;

    if (targets.isEmpty) {
      return;
    }

    model.clearData(period, targets);
  }
}
