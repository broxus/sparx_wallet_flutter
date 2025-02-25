import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/tabs/widgets/menu/browser_tabs_menu.dart';
import 'package:app/feature/browserV2/screens/tabs/widgets/menu/browser_tabs_menu_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [BrowserTabsMenuWidgetModel]
BrowserTabsMenuWidgetModel defaultBrowserTabsMenuWidgetModelFactory(
  BuildContext context,
) {
  return BrowserTabsMenuWidgetModel(
    BrowserTabsMenuModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserTabsMenu]
class BrowserTabsMenuWidgetModel
    extends CustomWidgetModel<BrowserTabsMenu, BrowserTabsMenuModel> {
  BrowserTabsMenuWidgetModel(
    super.model,
  );

  ListenableState<BrowserTabsData> get tabsState => model.tabsState;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  void onCloseAllPressed() {
    model.clearTabs();

    // TODO(knightforce): need it?
    context.goNamed(AppRoute.browser.name);
  }

  void onPlusPressed() {
    model.createEmptyTab();

    // TODO(knightforce): need it?
    context.goNamed(AppRoute.browser.name);
  }

  void onDonePressed() {
    // TODO(knightforce): need it?
    context.goNamed(AppRoute.browser.name);
  }
}
