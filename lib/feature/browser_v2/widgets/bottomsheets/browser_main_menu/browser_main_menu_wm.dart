import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/widgets/clear_history_modal.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/data/browser_main_menu_data.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Factory method for creating [BrowserMainMenuWidgetModel]
BrowserMainMenuWidgetModel defaultBrowserMainMenuWidgetModelFactory(
  BuildContext context,
) {
  return BrowserMainMenuWidgetModel(
    BrowserMainMenuModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserMainMenu]
class BrowserMainMenuWidgetModel
    extends CustomWidgetModel<BrowserMainMenu, BrowserMainMenuModel> {
  BrowserMainMenuWidgetModel(
    super.model,
  );

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
        model.createTab();
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
