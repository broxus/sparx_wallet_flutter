import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browserV2/screens/browser_view/widgets/control_panel/browser_control_panel.dart';
import 'package:app/feature/browserV2/screens/browser_view/widgets/control_panel/browser_control_panel_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [BrowserControlPanelWidgetModel]
BrowserControlPanelWidgetModel defaultBrowserControlPanelWidgetModelFactory(
  BuildContext context,
) {
  return BrowserControlPanelWidgetModel(
    BrowserControlPanelModel(
      createPrimaryErrorHandler(context),
    ),
  );
}

/// [WidgetModel] для [BrowserControlPanel]
class BrowserControlPanelWidgetModel
    extends CustomWidgetModel<BrowserControlPanel, BrowserControlPanelModel> {
  BrowserControlPanelWidgetModel(
    super.model,
  );

  ThemeStyleV2 get _theme => context.themeStyleV2;

  ColorsPaletteV2 get colors => _theme.colors;

  void onPressedBackPressed() {
    // TODO
  }

  void onPressedForwardPressed() {
    // TODO
  }

  void onPressedDotsPressed() {
    // TODO
  }

  void onPressedBook() {
    // TODO
  }

  void onPressedTabs() {
    context.goNamed(AppRoute.browserTabs.name);
  }
}
