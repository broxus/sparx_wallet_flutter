import 'dart:io';

import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/colors_v2.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

/// Factory method for creating [CreateBrowserGroupScreenWidgetModel]
CreateBrowserGroupScreenWidgetModel
    defaultCreateBrowserGroupScreenWidgetModelFactory(
  BuildContext context, {
  String? tabId,
}) {
  return CreateBrowserGroupScreenWidgetModel(
    CreateBrowserGroupScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    tabId,
  );
}

/// [WidgetModel] для [CreateBrowserGroupScreen]
class CreateBrowserGroupScreenWidgetModel extends CustomWidgetModel<
    CreateBrowserGroupScreen, CreateBrowserGroupScreenModel> {
  CreateBrowserGroupScreenWidgetModel(
    super.model,
    this._tabId,
  );

  late final screenHeight = MediaQuery.of(context).size.height;

  final String? _tabId;
  final int _maxLength = 24;

  late final _tabState = createNotifier<BrowserTab?>();
  late final _screenShotState = createNotifier<File?>();
  late final _errorState = createNotifier<bool>(false);

  ColorsPaletteV2 get colors => _themeStyleV2.colors;

  ThemeStyleV2 get _themeStyleV2 => context.themeStyleV2;

  ListenableState<BrowserTab?> get tabState => _tabState;

  ListenableState<File?> get screenShotState => _screenShotState;

  ListenableState<bool> get errorState => _errorState;

  int get maxLength => _maxLength;

  @override
  void initWidgetModel() {
    _tabState.accept(model.getTabsByIds(_tabId));
    super.initWidgetModel();
  }

  void onPressedBack() {
    context.compassBack();
  }

  void onChangeText(String text) {
    _errorState.accept(text.length > _maxLength);
  }

  void onEditingComplete(String text) {
    context.compassBack<String>(text);
    _errorState.accept(text.length > _maxLength);
  }

  void onOverflowLength() => _errorState.accept(true);
}
