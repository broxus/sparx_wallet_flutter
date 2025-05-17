import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/colors_v2.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

/// Factory method for creating [CreateBrowserGroupScreenWidgetModel]
CreateBrowserGroupScreenWidgetModel
    defaultCreateBrowserGroupScreenWidgetModelFactory(
  BuildContext context,
) {
  return CreateBrowserGroupScreenWidgetModel(
    CreateBrowserGroupScreenModel(
      createPrimaryErrorHandler(context),
    ),
  );
}

/// [WidgetModel] для [CreateBrowserGroupScreen]
class CreateBrowserGroupScreenWidgetModel extends CustomWidgetModel<
    CreateBrowserGroupScreen, CreateBrowserGroupScreenModel> {
  CreateBrowserGroupScreenWidgetModel(
    super.model,
  );

  ColorsPaletteV2 get colors => _themeStyleV2.colors;

  ThemeStyleV2 get _themeStyleV2 => context.themeStyleV2;

  NavigatorState get _navigator => Navigator.of(context);

  void onPressedBack() {
    _navigator.pop();
  }

  void onEditingComplete(String text) {
    _navigator.pop(text);
  }
}
