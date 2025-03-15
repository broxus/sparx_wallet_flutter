import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_main_menu/browser_main_menu.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_main_menu/browser_main_menu_model.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_main_menu/data/browser_main_menu_data.dart';
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

  void onPressedItem(BrowserMainMenuData value) {
    Navigator.of(context).pop();
  }
}
